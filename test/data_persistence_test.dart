import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lib/services/storage_service.dart';

void main() {
  group('Data Persistence Tests', () {
    setUp(() {
      // Initialize SharedPreferences for testing
      SharedPreferences.setMockInitialValues({});
    });

    tearDown(() {
      // Clean up after each test
    });

    test('Should detect when user has no location data', () async {
      // Arrange: Clear all local data (simulating fresh install)
      SharedPreferences.setMockInitialValues({});
      
      // Act: Check if location data exists
      final hasLocation = await StorageService.getUserLocation() != null;
      
      // Assert: Should detect no location data
      expect(hasLocation, isFalse);
    });

    test('Should detect when user has location data', () async {
      // Arrange: Set up location data
      SharedPreferences.setMockInitialValues({
        'user_city': 'Test City',
        'user_country': 'Test Country',
      });
      
      // Act: Check if location data exists
      final hasLocation = await StorageService.getUserLocation() != null;
      
      // Assert: Should detect location data
      expect(hasLocation, isTrue);
    });
  });
}