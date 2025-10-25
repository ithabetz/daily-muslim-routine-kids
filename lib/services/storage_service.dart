import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/daily_progress.dart';

class StorageService {
  static const String _cityKey = 'user_city';
  static const String _latitudeKey = 'user_latitude';
  static const String _longitudeKey = 'user_longitude';
  static const String _progressPrefix = 'progress_';
  static const String _isFirstLaunchKey = 'is_first_launch';

  static Future<void> saveUserLocation({
    required String city,
    required double latitude,
    required double longitude,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cityKey, city);
    await prefs.setDouble(_latitudeKey, latitude);
    await prefs.setDouble(_longitudeKey, longitude);
  }

  static Future<Map<String, dynamic>?> getUserLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final city = prefs.getString(_cityKey);
    final latitude = prefs.getDouble(_latitudeKey);
    final longitude = prefs.getDouble(_longitudeKey);

    if (city != null && latitude != null && longitude != null) {
      return {
        'city': city,
        'latitude': latitude,
        'longitude': longitude,
      };
    }
    return null;
  }

  static Future<void> saveDailyProgress(DailyProgress progress) async {
    final prefs = await SharedPreferences.getInstance();
    final dateKey = _getDateKey(progress.date);
    final progressKey = '$_progressPrefix$dateKey';
    
    await prefs.setString(progressKey, jsonEncode(progress.toJson()));
  }

  static Future<DailyProgress?> loadDailyProgress(String dateKey) async {
    final prefs = await SharedPreferences.getInstance();
    final progressKey = '$_progressPrefix$dateKey';
    final progressJson = prefs.getString(progressKey);
    
    if (progressJson != null) {
      try {
        final progressData = jsonDecode(progressJson) as Map<String, dynamic>;
        return DailyProgress.fromJson(progressData);
      } catch (e) {
        // Handle JSON parsing errors
        return null;
      }
    }
    return null;
  }

  static Future<List<DailyProgress>> loadAllDailyProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((key) => key.startsWith(_progressPrefix));
    final progressList = <DailyProgress>[];
    
    for (final key in keys) {
      final progressJson = prefs.getString(key);
      if (progressJson != null) {
        try {
          final progressData = jsonDecode(progressJson) as Map<String, dynamic>;
          progressList.add(DailyProgress.fromJson(progressData));
        } catch (e) {
          // Handle JSON parsing errors
        }
      }
    }
    
    return progressList;
  }

  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isFirstLaunchKey) ?? true;
  }

  static Future<void> setFirstLaunchCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isFirstLaunchKey, false);
  }


  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Clear all progress data
    final keys = prefs.getKeys().where((key) => key.startsWith(_progressPrefix));
    for (final key in keys) {
      await prefs.remove(key);
    }
    
    // Clear other data
    await prefs.remove(_cityKey);
    await prefs.remove(_latitudeKey);
    await prefs.remove(_longitudeKey);
    
    // Keep first launch flag to show onboarding again
  }


  // Helper method to convert date to key
  static String _getDateKey(DateTime date) {
    return '${date.year}_${date.month.toString().padLeft(2, '0')}_${date.day.toString().padLeft(2, '0')}';
  }
}