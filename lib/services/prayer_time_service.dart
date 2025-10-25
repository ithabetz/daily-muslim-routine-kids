import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/prayer.dart';

class PrayerTimeService {
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<String?> getCityFromLocation(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        return placemarks.first.locality ?? placemarks.first.administrativeArea;
      }
    } catch (e) {
      // Error getting city - return null
    }
    return null;
  }

  static Future<Map<PrayerType, DateTime>> calculatePrayerTimes({
    required double latitude,
    required double longitude,
    DateTime? date,
  }) async {
    final coordinates = Coordinates(latitude, longitude);
    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.shafi;

    final prayerTimes = PrayerTimes.today(coordinates, params);

    return {
      PrayerType.fajr: prayerTimes.fajr,
      PrayerType.dhuhr: prayerTimes.dhuhr,
      PrayerType.asr: prayerTimes.asr,
      PrayerType.maghrib: prayerTimes.maghrib,
      PrayerType.isha: prayerTimes.isha,
    };
  }


  static PrayerType? getNextPrayer(Map<PrayerType, DateTime> prayerTimes) {
    final now = DateTime.now();
    
    for (var entry in prayerTimes.entries) {
      if (now.isBefore(entry.value)) {
        return entry.key;
      }
    }
    
    return null; // All prayers have passed for today
  }

  static Duration? getTimeUntilNextPrayer(Map<PrayerType, DateTime> prayerTimes) {
    final now = DateTime.now();
    
    for (var entry in prayerTimes.entries) {
      if (now.isBefore(entry.value)) {
        return entry.value.difference(now);
      }
    }
    
    return null;
  }
}

