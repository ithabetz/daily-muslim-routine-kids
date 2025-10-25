import 'prayer.dart';
import 'azkar_task.dart';
import 'sunnah_prayer.dart';
import 'task_type.dart';
import 'user_profile.dart';

class DailyProgress {
  final DateTime date;
  final List<PrayerTask> prayers;
  final List<AzkarTask> azkar;
  final List<SunnahPrayer> sunnahPrayers;

  DailyProgress({
    required this.date,
    required this.prayers,
    required this.azkar,
    required this.sunnahPrayers,
  });

  double getTotalScore() {
    return calculateScore();
  }

  static DailyProgress createForDate(DateTime date) {
    return DailyProgress(
      date: date,
      prayers: PrayerType.values.map((type) => PrayerTask(
        type: type,
        time: DateTime.now(),
        isCompleted: false,
        prayedOnTime: false,
        inMosque: false,
        prayedOutOfTime: false,
      )).toList(),
      azkar: AzkarType.values.map((type) => AzkarTask(
        type: type,
        isCompleted: false,
      )).toList(),
      sunnahPrayers: SunnahPrayerType.values.map((type) => SunnahPrayer(
        type: type,
        isCompleted: false,
      )).toList(),
    );
  }

  DailyProgress updatePrayer(PrayerType prayerType, PrayerStatus status) {
    final updatedPrayers = prayers.map((prayer) {
      if (prayer.type == prayerType) {
        return PrayerTask(
          type: prayerType,
          time: prayer.time,
          isCompleted: status == PrayerStatus.performed,
          prayedOnTime: status == PrayerStatus.performed,
          inMosque: prayer.inMosque,
          prayedOutOfTime: status == PrayerStatus.late,
        );
      }
      return prayer;
    }).toList();
    
    return DailyProgress(
      date: date,
      prayers: updatedPrayers,
      azkar: azkar,
      sunnahPrayers: sunnahPrayers,
    );
  }

  DailyProgress updatePrayerDetails({
    required PrayerType prayerType,
    bool? prayedOnTime,
    bool? inMosque,
    bool? prayedOutOfTime,
    Gender? gender,
  }) {
    final updatedPrayers = prayers.map((prayer) {
      if (prayer.type == prayerType) {
        // Apply gender-specific rules
        bool finalPrayedOnTime = prayedOnTime ?? prayer.prayedOnTime;
        bool finalInMosque = inMosque ?? prayer.inMosque;
        bool finalPrayedOutOfTime = prayedOutOfTime ?? prayer.prayedOutOfTime;
        
        // For boys: if prayed out of time, clear other options
        if (gender == Gender.male && finalPrayedOutOfTime) {
          finalPrayedOnTime = false;
          finalInMosque = false;
        }
        
        // For boys: if prayed on time, clear out of time option
        if (gender == Gender.male && finalPrayedOnTime) {
          finalPrayedOutOfTime = false;
        }
        
        // For boys: mosque option is only valid if prayed on time
        if (gender == Gender.male && finalInMosque && !finalPrayedOnTime) {
          finalInMosque = false;
        }
        
        // For girls: mutually exclusive - only one can be true
        if (gender == Gender.female) {
          if (finalPrayedOnTime) {
            finalInMosque = false;
            finalPrayedOutOfTime = false;
          } else if (finalInMosque) {
            finalPrayedOnTime = false;
            finalPrayedOutOfTime = false;
          } else if (finalPrayedOutOfTime) {
            finalPrayedOnTime = false;
            finalInMosque = false;
          }
        }
        
        // For girls: mosque option is only valid if prayed on time
        if (gender == Gender.female && finalInMosque && !finalPrayedOnTime) {
          finalInMosque = false;
        }
        
        // Determine if prayer is completed based on any checkbox being true
        final isCompleted = finalPrayedOnTime || finalInMosque || finalPrayedOutOfTime;
        
        return PrayerTask(
          type: prayerType,
          time: prayer.time,
          isCompleted: isCompleted,
          prayedOnTime: finalPrayedOnTime,
          inMosque: finalInMosque,
          prayedOutOfTime: finalPrayedOutOfTime,
        );
      }
      return prayer;
    }).toList();
    
    return DailyProgress(
      date: date,
      prayers: updatedPrayers,
      azkar: azkar,
      sunnahPrayers: sunnahPrayers,
    );
  }

  DailyProgress updateAzkar(AzkarType azkarType, bool completed) {
    final updatedAzkar = azkar.map((azkar) {
      if (azkar.type == azkarType) {
        return AzkarTask(
          type: azkarType,
          isCompleted: completed,
        );
      }
      return azkar;
    }).toList();
    
    return DailyProgress(
      date: date,
      prayers: prayers,
      azkar: updatedAzkar,
      sunnahPrayers: sunnahPrayers,
    );
  }

  DailyProgress updateSunnahPrayer(SunnahPrayerType sunnahType, bool completed) {
    final updatedSunnahPrayers = sunnahPrayers.map((prayer) {
      if (prayer.type == sunnahType) {
        return SunnahPrayer(
          type: sunnahType,
          isCompleted: completed,
        );
      }
      return prayer;
    }).toList();
    
    return DailyProgress(
      date: date,
      prayers: prayers,
      azkar: azkar,
      sunnahPrayers: updatedSunnahPrayers,
    );
  }

  double calculateScore() {
    // ==========================================
    // FARD TASKS (50.0 points max)
    // ==========================================
    // 5 Daily Prayers - Each prayer worth 10.0 points max (5.0 on-time + 5.0 mosque)
    // Out of time prayer: 2.5 points only
    // Total possible: 5 prayers × 10.0 points = 50.0 points
    double fardScore = 0;
    if (prayers.isNotEmpty) {
      fardScore = prayers.fold(0.0, (sum, p) => sum + p.score);
    }

    // ==========================================
    // SUNNAH PRAYERS (30.0 points max)
    // ==========================================
    double sunnahPrayerScore = 0;
    double sunnahPrayerMaxScore = 0;
    for (var s in sunnahPrayers) {
      sunnahPrayerMaxScore += s.weight;
      if (s.isCompleted) {
        sunnahPrayerScore += s.weight;
      }
    }
    // Direct calculation: total weight = 30.0, so no conversion needed
    double sunnahScore = sunnahPrayerScore;

    // ==========================================
    // AZKAR (20.0 points max)
    // ==========================================
    double azkarRawScore = 0;
    double azkarMaxScore = 0;
    for (var a in azkar) {
      azkarMaxScore += a.weight;
      if (a.isCompleted) {
        azkarRawScore += a.weight;
      }
    }
    double azkarScore = azkarMaxScore > 0 ? (azkarRawScore / azkarMaxScore) * 20.0 : 0.0;

    // ==========================================
    // TOTAL SCORE (100.0 points max)
    // ==========================================
    return fardScore + sunnahScore + azkarScore;
  }

  Map<String, dynamic> getScoreBreakdown() {
    double fardScore = 0;
    if (prayers.isNotEmpty) {
      double totalPrayerScore = prayers.fold(0.0, (sum, p) => sum + p.score);
      double maxPossibleScore = prayers.length * 10.0;
      fardScore = maxPossibleScore > 0 ? (totalPrayerScore / maxPossibleScore) * 50.0 : 0.0;
    }

    // Calculate Sunnah Prayers score separately
    double sunnahPrayerScore = 0;
    double sunnahPrayerMaxScore = 0;
    for (var s in sunnahPrayers) {
      sunnahPrayerMaxScore += s.weight;
      if (s.isCompleted) sunnahPrayerScore += s.weight;
    }
    // Direct calculation: total weight = 30.0, so no conversion needed
    double sunnahScore = sunnahPrayerScore;

    // Calculate Azkar score separately
    double azkarRawScore = 0;
    double azkarMaxScore = 0;
    for (var a in azkar) {
      azkarMaxScore += a.weight;
      if (a.isCompleted) azkarRawScore += a.weight;
    }
    double azkarScore = azkarMaxScore > 0 ? (azkarRawScore / azkarMaxScore) * 20.0 : 0.0;

    return {
      'fard': fardScore,
      'sunnah': sunnahScore,
      'azkar': azkarScore,
      'total': fardScore + sunnahScore + azkarScore,
    };
  }

  Map<String, double> getCompletionPercentages() {
    Map<String, double> percentages = {};
    
    // Prayer completion (Fard)
    if (prayers.isNotEmpty) {
      int completedPrayers = prayers.where((p) => p.isCompleted).length;
      percentages['fard'] = (completedPrayers / prayers.length) * 100;
    }
    
    // Azkar completion (separate category)
    if (azkar.isNotEmpty) {
      int completedAzkar = azkar.where((a) => a.isCompleted).length;
      percentages['azkar'] = (completedAzkar / azkar.length) * 100;
    }
    
    // Sunnah prayers completion (separate category)
    if (sunnahPrayers.isNotEmpty) {
      int completedSunnah = sunnahPrayers.where((s) => s.isCompleted).length;
      percentages['sunnah'] = (completedSunnah / sunnahPrayers.length) * 100;
    }
    
    return percentages;
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'prayers': prayers.map((p) => p.toJson()).toList(),
      'azkar': azkar.map((a) => a.toJson()).toList(),
      'sunnahPrayers': sunnahPrayers.map((s) => s.toJson()).toList(),
    };
  }

  factory DailyProgress.fromJson(Map<String, dynamic> json) {
    return DailyProgress(
      date: DateTime.parse(json['date']),
      prayers: (json['prayers'] as List)
          .map((p) => PrayerTask.fromJson(p))
          .toList(),
      azkar: (json['azkar'] as List)
          .map((a) => AzkarTask.fromJson(a))
          .toList(),
      sunnahPrayers: (json['sunnahPrayers'] as List?)
          ?.map((s) => SunnahPrayer.fromJson(s))
          .toList() ?? [],
    );
  }

}