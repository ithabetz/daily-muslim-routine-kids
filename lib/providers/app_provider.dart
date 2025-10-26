import 'package:flutter/material.dart';
import '../models/prayer.dart';
import '../models/azkar_task.dart';
import '../models/sunnah_prayer.dart';
import '../models/daily_progress.dart';
import '../models/user_profile.dart';
import '../models/task_type.dart';
import '../services/prayer_time_service.dart';
import '../services/storage_service.dart';
import '../services/auth_service.dart';
import '../services/cloud_storage_service.dart';
import '../services/quran_memorization_service.dart';
import '../l10n/app_localizations.dart';

class AppProvider with ChangeNotifier {
  // Services
  final AuthService _authService = AuthService();
  final CloudStorageService _cloudStorage = CloudStorageService();
  
  // User data
  UserProfile? _userProfile;
  
  // Location data
  String? _city;
  double? _latitude;
  double? _longitude;
  
  // Prayer times
  Map<PrayerType, DateTime>? _prayerTimes;
  
  // Daily progress
  DailyProgress? _todayProgress;
  
  // Loading state
  bool _isLoading = false;
  bool _isRestoringData = false;
  String? _restoreStatus;

  // Getters
  UserProfile? get userProfile => _userProfile;
  bool get isAuthenticated => _authService.isLoggedIn;
  String? get city => _city;
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  Map<PrayerType, DateTime>? get prayerTimes => _prayerTimes;
  DailyProgress? get todayProgress => _todayProgress;
  bool get isLoading => _isLoading;
  bool get isRestoringData => _isRestoringData;
  String? get restoreStatus => _restoreStatus;
  bool get isLocationSet => _city != null && _latitude != null && _longitude != null;

  // Score calculations
  double get todayScore {
    if (_todayProgress == null) return 0.0;
    return _todayProgress!.getTotalScore();
  }

  double get todayScorePercentage {
    if (_todayProgress == null) return 0.0;
    return (_todayProgress!.getTotalScore() / 100.0) * 100;
  }

  // Authentication Methods
  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
    Gender? gender,
  }) async {
    final profile = await _authService.signUpWithEmailAndPassword(
      email: email,
      password: password,
      displayName: displayName,
      gender: gender,
    );

    if (profile != null) {
      // Clear any existing local data to ensure new user starts fresh
      await StorageService.clearAllData();
      
      _userProfile = profile;
      await _cloudStorage.createUserProfile(profile);
      notifyListeners();
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    _isRestoringData = true;
    _restoreStatus = l10n.authenticating;
    notifyListeners();

    try {
      final profile = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (profile != null) {
        _userProfile = profile;
        _restoreStatus = l10n.restoringYourData;
        notifyListeners();
        
        // Load user data from cloud FIRST, then clear local data
        await _loadUserDataFromCloud();
        
        _restoreStatus = l10n.savingDataLocally;
        notifyListeners();
        
        // Only clear local data AFTER successfully loading from cloud
        await StorageService.clearAllData();
        
        // Save the loaded cloud data to local storage for offline access
        await _saveLoadedDataToLocal();
        
        _restoreStatus = l10n.updatingProfile;
        notifyListeners();
        
        // Update last login time
        await _cloudStorage.updateUserProfile(profile.uid, {
          'lastLoginAt': DateTime.now().toIso8601String(),
        });
        
        _restoreStatus = l10n.dataRestoredSuccessfully;
        notifyListeners();
        
        // Small delay to show success message
        await Future.delayed(const Duration(milliseconds: 500));
        
        _isRestoringData = false;
        _restoreStatus = null;
        notifyListeners();
      }
    } catch (e) {
      _isRestoringData = false;
      _restoreStatus = 'Failed to restore data: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    
    // Clear all local data to prevent data leakage between users
    await StorageService.clearAllData();
    
    // Clear in-memory data
    _userProfile = null;
    _city = null;
    _latitude = null;
    _longitude = null;
    _prayerTimes = null;
    _todayProgress = null;
    
    notifyListeners();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _authService.sendPasswordResetEmail(email);
  }

  Future<void> updateProfile({String? displayName, String? photoUrl, Gender? gender}) async {
    if (_userProfile == null) return;

    await _authService.updateUserProfile(
      displayName: displayName,
      photoUrl: photoUrl,
    );

    await _cloudStorage.updateUserProfile(_userProfile!.uid, {
      if (displayName != null) 'displayName': displayName,
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (gender != null) 'gender': gender.toString(),
    });

    _userProfile = _userProfile!.copyWith(
      displayName: displayName ?? _userProfile!.displayName,
      photoUrl: photoUrl ?? _userProfile!.photoUrl,
      gender: gender ?? _userProfile!.gender,
    );

    notifyListeners();
  }

  Future<void> deleteAccount() async {
    if (_userProfile == null) return;

    // Delete cloud data
    await _cloudStorage.deleteUserData(_userProfile!.uid);
    
    // Delete local data
    await StorageService.clearAllData();
    
    // Delete Firebase Auth account
    await _authService.deleteAccount();
    
    // Clear in-memory data
    _userProfile = null;
    _city = null;
    _latitude = null;
    _longitude = null;
    _prayerTimes = null;
    _todayProgress = null;
    
    notifyListeners();
  }

  // Location Methods
  Future<void> setLocation({
    required String city,
    required double latitude,
    required double longitude,
  }) async {
    _city = city;
    _latitude = latitude;
    _longitude = longitude;
    
    await StorageService.saveUserLocation(
      city: city,
      latitude: latitude,
      longitude: longitude,
    );
    
    // Update prayer times
    _updatePrayerTimes();
    
    notifyListeners();
  }

  Future<void> _updatePrayerTimes() async {
    if (_latitude == null || _longitude == null) return;
    
    try {
      // Run prayer time calculation in a separate isolate to avoid blocking UI
      _prayerTimes = await PrayerTimeService.calculatePrayerTimes(
        latitude: _latitude!,
        longitude: _longitude!,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          // Return empty map if calculation times out
          return <PrayerType, DateTime>{};
        },
      );
    notifyListeners();
      } catch (e) {
      // Handle error silently for now
      _prayerTimes = <PrayerType, DateTime>{};
      }
  }

  // Daily Progress Methods
  Future<void> initialize({required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Set a timeout for the entire initialization process
      await Future.wait([
        _initializeUserProfile(),
        _initializeLocation(),
        _initializeDailyProgress(),
      ]).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          // Continue with default values if initialization times out
          return <void>[];
        },
      );

      // Load data from cloud after local initialization
      if (_userProfile != null) {
        await loadFromCloud();
      }
      
    } catch (e) {
      // Handle initialization errors
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _initializeUserProfile() async {
    // Load user profile if authenticated
    if (_authService.isLoggedIn) {
      final uid = _authService.currentUser?.uid;
      if (uid != null) {
        _userProfile = await _cloudStorage.getUserProfile(uid);
      }
    }
  }

  Future<void> _initializeLocation() async {
    // Load location
    final location = await StorageService.getUserLocation();
    if (location != null) {
      _city = location['city'];
      _latitude = location['latitude'];
      _longitude = location['longitude'];
      // Don't wait for prayer times during initialization to avoid ANR
      // They will be calculated in the background
      _updatePrayerTimes();
    }
  }

  Future<void> _initializeDailyProgress() async {
    // Load today's progress
    await refreshDay();
  }

  Future<void> refreshDay() async {
    final today = DateTime.now();
    final todayKey = '${today.year}_${today.month.toString().padLeft(2, '0')}_${today.day.toString().padLeft(2, '0')}';
    
    try {
      // Load today's progress from local storage with timeout
      _todayProgress = await StorageService.loadDailyProgress(todayKey).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          // Create new progress if loading times out
          return DailyProgress.createForDate(today);
        },
      );
      
      // If no progress exists, create a new one
      if (_todayProgress == null) {
        _todayProgress = DailyProgress.createForDate(today);
        await StorageService.saveDailyProgress(_todayProgress!);
      } else {
        // Check if sunnah prayers are missing and add them
        final allSunnahTypes = SunnahPrayerType.values;
        final existingSunnahTypes = _todayProgress!.sunnahPrayers.map((p) => p.type).toSet();
        final missingSunnahTypes = allSunnahTypes.where((type) => !existingSunnahTypes.contains(type)).toList();
        
        if (missingSunnahTypes.isNotEmpty) {
          // Add missing sunnah prayers
          final updatedSunnahPrayers = List<SunnahPrayer>.from(_todayProgress!.sunnahPrayers);
          for (final type in missingSunnahTypes) {
            updatedSunnahPrayers.add(SunnahPrayer(type: type, isCompleted: false));
          }
          
          _todayProgress = DailyProgress(
            date: _todayProgress!.date,
            prayers: _todayProgress!.prayers,
            azkar: _todayProgress!.azkar,
            sunnahPrayers: updatedSunnahPrayers,
          );
          
          await StorageService.saveDailyProgress(_todayProgress!);
        }
      }
      
    notifyListeners();
      } catch (e) {
      // Create default progress if anything fails
      _todayProgress = DailyProgress.createForDate(today);
    notifyListeners();
  }
  }

  Future<void> updatePrayer(PrayerType prayerType, PrayerStatus status) async {
    if (_todayProgress == null) return;

    _todayProgress = _todayProgress!.updatePrayer(prayerType, status);
    await StorageService.saveDailyProgress(_todayProgress!);
    
    // Sync with cloud if authenticated
    if (_userProfile != null) {
      try {
        await _cloudStorage.saveDailyProgress(_userProfile!.uid, _todayProgress!);
      } catch (e) {
        // Handle sync error silently
      }
    }

    notifyListeners();
  }

  Future<void> updatePrayerDetails({
    required PrayerType prayerType,
    bool? prayedOnTime,
    bool? prayedOutOfTime,
  }) async {
    if (_todayProgress == null) return;

    _todayProgress = _todayProgress!.updatePrayerDetails(
      prayerType: prayerType,
      prayedOnTime: prayedOnTime,
      prayedOutOfTime: prayedOutOfTime,
    );
    await StorageService.saveDailyProgress(_todayProgress!);
    
    // Sync with cloud if authenticated
    if (_userProfile != null) {
      try {
        await _cloudStorage.saveDailyProgress(_userProfile!.uid, _todayProgress!);
      } catch (e) {
        // Handle sync error silently
      }
    }

    notifyListeners();
  }

  Future<void> updateAzkar(AzkarType azkarType, bool completed) async {
    if (_todayProgress == null) return;
    
    _todayProgress = _todayProgress!.updateAzkar(azkarType, completed);
    await StorageService.saveDailyProgress(_todayProgress!);
    
    // Sync with cloud if authenticated
    if (_userProfile != null) {
      try {
        await _cloudStorage.saveDailyProgress(_userProfile!.uid, _todayProgress!);
      } catch (e) {
        // Handle sync error silently
      }
    }

    notifyListeners();
  }

  Future<void> updateSunnahPrayer(SunnahPrayerType sunnahType, bool completed) async {
    if (_todayProgress == null) return;
    
    _todayProgress = _todayProgress!.updateSunnahPrayer(sunnahType, completed);
    await StorageService.saveDailyProgress(_todayProgress!);
    
    // Sync with cloud if authenticated
      if (_userProfile != null) {
        try {
        await _cloudStorage.saveDailyProgress(_userProfile!.uid, _todayProgress!);
        } catch (e) {
        // Handle sync error silently
        }
      }

      notifyListeners();
  }
  
  // Toggle methods for widgets
  Future<void> togglePrayer(PrayerType prayerType) async {
    if (_todayProgress == null) return;
    
    final currentPrayer = _todayProgress!.prayers.firstWhere(
      (p) => p.type == prayerType,
      orElse: () => PrayerTask(
        type: prayerType,
        time: DateTime.now(),
        isCompleted: false,
        prayedOnTime: false,
        prayedOutOfTime: false,
      ),
    );
    
    final newStatus = currentPrayer.isCompleted 
        ? PrayerStatus.notPerformed 
        : PrayerStatus.performed;
    
    await updatePrayer(prayerType, newStatus);
  }

  Future<void> toggleAzkar(AzkarType azkarType) async {
    if (_todayProgress == null) return;
    
    final currentAzkar = _todayProgress!.azkar.firstWhere(
      (a) => a.type == azkarType,
      orElse: () => AzkarTask(
        type: azkarType,
        isCompleted: false,
      ),
    );
    
    await updateAzkar(azkarType, !currentAzkar.isCompleted);
  }

  Future<void> toggleSunnahPrayer(SunnahPrayerType sunnahType) async {
    if (_todayProgress == null) return;
    
    final currentPrayer = _todayProgress!.sunnahPrayers.firstWhere(
      (p) => p.type == sunnahType,
      orElse: () => SunnahPrayer(
        type: sunnahType,
        isCompleted: false,
      ),
    );
    
    await updateSunnahPrayer(sunnahType, !currentPrayer.isCompleted);
  }

  Future<void> _loadUserDataFromCloud() async {
    if (_userProfile == null) return;
    
    try {
      // Load daily progress from cloud
      final today = DateTime.now();
      final todayKey = '${today.year}_${today.month.toString().padLeft(2, '0')}_${today.day.toString().padLeft(2, '0')}';
      
      final cloudProgress = await _cloudStorage.getDailyProgress(_userProfile!.uid, todayKey);
      if (cloudProgress != null) {
        _todayProgress = cloudProgress;
      }
      
      // Load Quran memorization from cloud
      final cloudMemorization = await _cloudStorage.getQuranMemorization(_userProfile!.uid);
      if (cloudMemorization != null) {
        await QuranMemorizationService.saveMemorization(cloudMemorization);
      }
      
    } catch (e) {
      // Handle cloud loading errors silently
    }
  }

  /// Load all user data from cloud storage
  Future<void> loadFromCloud() async {
    if (_userProfile == null) return;
    
    try {
      await _loadUserDataFromCloud();
      await _saveLoadedDataToLocal();
      notifyListeners();
    } catch (e) {
      // Handle cloud loading errors silently
    }
  }

  Future<void> _saveLoadedDataToLocal() async {
    try {
      // Save daily progress to local storage
      if (_todayProgress != null) {
        await StorageService.saveDailyProgress(_todayProgress!);
      }
      
      // Save Quran memorization to local storage
      final memorization = await QuranMemorizationService.loadMemorization();
      await QuranMemorizationService.saveMemorization(memorization);
      
    } catch (e) {
      // Handle local saving errors silently
    }
  }
}