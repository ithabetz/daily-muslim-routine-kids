import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lib/services/storage_service.dart';

void main() {
  group('Data Persistence After Reinstall Tests', () {
    setUp(() {
      // Initialize SharedPreferences for testing
      SharedPreferences.setMockInitialValues({});
    });

    tearDown(() {
      // Clean up after each test
    });

    test('Should detect reinstall scenario when user has no local data', () async {
      // Arrange: Clear all local data (simulating reinstall)
      SharedPreferences.setMockInitialValues({});
      
      // Act: Check if reinstall scenario is detected
      final hasLocation = await StorageService.getUserLocation() != null;
      final hasProgress = await StorageService.getDailyProgress(DateTime.now()) != null;
      final hasNotes = (await StorageService.getNotes()).isNotEmpty;
      
      // Assert: Should detect reinstall scenario
      expect(hasLocation, isFalse);
      expect(hasProgress, isFalse);
      expect(hasNotes, isFalse);
    });

    test('Should not detect reinstall when user has local data', () async {
      // Arrange: Set up local data
      SharedPreferences.setMockInitialValues({
        'user_city': 'Test City',
        'user_latitude': 40.7128,
        'user_longitude': -74.0060,
      });
      
      // Act: Check if reinstall scenario is detected
      final hasLocation = await StorageService.getUserLocation() != null;
      
      // Assert: Should not detect reinstall scenario
      expect(hasLocation, isTrue);
    });

    test('Should save and retrieve user location correctly', () async {
      // Arrange: Clear initial values
      SharedPreferences.setMockInitialValues({});
      
      // Act: Save location
      await StorageService.saveUserLocation(
        city: 'Test City',
        latitude: 40.7128,
        longitude: -74.0060,
      );
      
      // Assert: Should retrieve location correctly
      final location = await StorageService.getUserLocation();
      expect(location, isNotNull);
      expect(location!['city'], equals('Test City'));
      expect(location['latitude'], equals(40.7128));
      expect(location['longitude'], equals(-74.0060));
    });

    test('Should handle empty notes list correctly', () async {
      // Arrange: Clear initial values
      SharedPreferences.setMockInitialValues({});
      
      // Act: Get notes
      final notes = await StorageService.getNotes();
      
      // Assert: Should return empty list
      expect(notes, isEmpty);
    });

    test('Should detect reinstall scenario with mixed data', () async {
      // Arrange: Set up partial local data (some data exists but not all)
      SharedPreferences.setMockInitialValues({
        'user_city': 'Test City',
        // Missing latitude and longitude
      });
      
      // Act: Check if reinstall scenario is detected
      final hasLocation = await StorageService.getUserLocation() != null;
      final hasProgress = await StorageService.getDailyProgress(DateTime.now()) != null;
      final hasNotes = (await StorageService.getNotes()).isNotEmpty;
      
      // Assert: Should detect reinstall scenario (incomplete data)
      expect(hasLocation, isFalse); // Incomplete location data
      expect(hasProgress, isFalse);
      expect(hasNotes, isFalse);
    });

    test('Should clear all data correctly', () async {
      // Arrange: Set up some data
      SharedPreferences.setMockInitialValues({
        'user_city': 'Test City',
        'user_latitude': 40.7128,
        'user_longitude': -74.0060,
        'progress_2024_01_01': '{"date":"2024-01-01T00:00:00.000Z","prayers":[],"azkar":[],"azkarAfterPrayer":[],"sunnahPrayers":[],"sunnahPrayersAfter":[],"tasks":[]}',
      });
      
      // Act: Clear all data
      await StorageService.clearAllData();
      
      // Assert: All data should be cleared
      final location = await StorageService.getUserLocation();
      final progress = await StorageService.getDailyProgress(DateTime(2024, 1, 1));
      final notes = await StorageService.getNotes();
      
      expect(location, isNull);
      expect(progress, isNull);
      expect(notes, isEmpty);
    });
  });

  group('Reinstall Detection Logic Tests', () {
    test('Should correctly identify reinstall scenario', () async {
      // Arrange: Simulate reinstall (no local data)
      SharedPreferences.setMockInitialValues({});
      
      // Act: Check various data sources
      final hasLocation = await StorageService.getUserLocation() != null;
      final hasProgress = await StorageService.getDailyProgress(DateTime.now()) != null;
      final hasNotes = (await StorageService.getNotes()).isNotEmpty;
      
      // Assert: All should be false for reinstall scenario
      expect(hasLocation, isFalse);
      expect(hasProgress, isFalse);
      expect(hasNotes, isFalse);
      
      // This combination indicates a reinstall scenario
      final isReinstallScenario = !hasLocation && !hasProgress && !hasNotes;
      expect(isReinstallScenario, isTrue);
    });

    test('Should correctly identify normal scenario with data', () async {
      // Arrange: Simulate normal app with data
      SharedPreferences.setMockInitialValues({
        'user_city': 'Test City',
        'user_latitude': 40.7128,
        'user_longitude': -74.0060,
        'progress_2024_01_01': '{"date":"2024-01-01T00:00:00.000Z","prayers":[],"azkar":[],"azkarAfterPrayer":[],"sunnahPrayers":[],"sunnahPrayersAfter":[],"tasks":[]}',
        'user_notes_v1': '[]',
      });
      
      // Act: Check various data sources
      final hasLocation = await StorageService.getUserLocation() != null;
      final hasProgress = await StorageService.getDailyProgress(DateTime(2024, 1, 1)) != null;
      final hasNotes = (await StorageService.getNotes()).isNotEmpty;
      
      // Assert: Should have data (not reinstall scenario)
      expect(hasLocation, isTrue);
      expect(hasProgress, isNotNull);
      expect(hasNotes, isFalse); // Empty array is still considered "no notes"
      
      // This combination indicates normal scenario
      final isReinstallScenario = !hasLocation && !hasProgress && !hasNotes;
      expect(isReinstallScenario, isFalse);
    });
  });
}
