import 'package:shared_preferences/shared_preferences.dart';
import '../models/quran_memorization.dart';
import 'cloud_storage_service.dart';
import 'auth_service.dart';

/// Service for managing Quran memorization data
class QuranMemorizationService {
  static const String _memorization_key = 'quran_memorization';
  static final CloudStorageService _cloudStorage = CloudStorageService();
  static final AuthService _authService = AuthService();

  /// Save memorization progress to both local and cloud storage
  static Future<void> saveMemorization(QuranMemorization memorization) async {
    // Save to local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_memorization_key, memorization.toJsonString());
    
    // Save to cloud storage if user is authenticated
    if (_authService.isLoggedIn) {
      try {
        final userProfile = _authService.getCurrentUserProfile();
        if (userProfile != null) {
          await _cloudStorage.saveQuranMemorization(userProfile.uid, memorization);
        }
      } catch (e) {
        // Log error but don't fail the save operation
        // Failed to save memorization to cloud
      }
    }
  }

  /// Load memorization progress from local storage first, with optional cloud sync
  static Future<QuranMemorization> loadMemorization({bool syncWithCloud = false}) async {
    // Always load from local storage first for better performance
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_memorization_key);
    
    QuranMemorization localMemorization;
    if (jsonString == null) {
      localMemorization = QuranMemorization();
    } else {
      try {
        localMemorization = QuranMemorization.fromJsonString(jsonString);
      } catch (e) {
        localMemorization = QuranMemorization();
      }
    }
    
    // Only sync with cloud if explicitly requested and user is authenticated
    if (syncWithCloud && _authService.isLoggedIn) {
      try {
        final userProfile = _authService.getCurrentUserProfile();
        if (userProfile != null) {
          final cloudMemorization = await _cloudStorage.getQuranMemorization(userProfile.uid);
          if (cloudMemorization != null) {
            // Save to local storage for offline access
            await prefs.setString(_memorization_key, cloudMemorization.toJsonString());
            return cloudMemorization;
          }
        }
      } catch (e) {
        // Failed to load memorization from cloud
      }
    }
    
    return localMemorization;
  }

  /// Clear all memorization data from both local and cloud storage
  static Future<void> clearMemorization() async {
    // Clear local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_memorization_key);
    
    // Clear cloud storage if user is authenticated
    if (_authService.isLoggedIn) {
      try {
        final userProfile = _authService.getCurrentUserProfile();
        if (userProfile != null) {
          await _cloudStorage.saveQuranMemorization(userProfile.uid, QuranMemorization());
        }
      } catch (e) {
        // Failed to clear memorization from cloud
      }
    }
  }

  /// Sync local memorization data to cloud
  static Future<void> syncToCloud() async {
    if (!_authService.isLoggedIn) return;
    
    try {
      final userProfile = _authService.getCurrentUserProfile();
      if (userProfile != null) {
        final localMemorization = await loadMemorization();
        await _cloudStorage.syncQuranMemorizationToCloud(userProfile.uid, localMemorization);
      }
    } catch (e) {
      // Failed to sync memorization to cloud
    }
  }

  /// Toggle a surah's memorization status and save
  static Future<QuranMemorization> toggleSurahMemorization(
    QuranMemorization current,
    int surahNumber,
  ) async {
    final updated = current.toggleSurah(surahNumber);
    await saveMemorization(updated);
    return updated;
  }

  /// Set target month for a Juz and save
  static Future<QuranMemorization> setJuzTargetMonth(
    QuranMemorization current,
    int juzNumber,
    int month,
  ) async {
    final updated = current.setJuzTargetMonth(juzNumber, month);
    await saveMemorization(updated);
    return updated;
  }
}

