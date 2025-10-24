import 'prayer.dart';
import 'azkar_task.dart';
import 'sunnah_prayer.dart';
import 'task_type.dart';

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
  }) {
    final updatedPrayers = prayers.map((prayer) {
      if (prayer.type == prayerType) {
        // Determine if prayer is completed based on any checkbox being true
        final isCompleted = (prayedOnTime ?? prayer.prayedOnTime) || 
                           (inMosque ?? prayer.inMosque) || 
                           (prayedOutOfTime ?? prayer.prayedOutOfTime);
        
        return PrayerTask(
          type: prayerType,
          time: prayer.time,
          isCompleted: isCompleted,
          prayedOnTime: prayedOnTime ?? prayer.prayedOnTime,
          inMosque: inMosque ?? prayer.inMosque,
          prayedOutOfTime: prayedOutOfTime ?? prayer.prayedOutOfTime,
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
          weight: prayer.weight,
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
    // FARD TASKS (5.0 points max)
    // ==========================================
    // 5 Daily Prayers - Each prayer worth 1.0 point max (0.5 on-time + 0.5 mosque)
    // Out of time prayer: 0.25 points only
    // Total possible: 5 prayers × 1.0 point = 5.0 points
    // No scaling needed - direct calculation
    double fardScore = 0;
    if (prayers.isNotEmpty) {
      fardScore = prayers.fold(0.0, (sum, p) => sum + p.score);
    }

    // ==========================================
    // SUNNAH TASKS (2.5 points max)
    // ==========================================
    double sunnahRawScore = 0;
    double sunnahMaxScore = 0;
    
    // Sunnah Azkar
    for (var a in azkar) {
      if (a.taskType == TaskType.sunnah) {
        sunnahMaxScore += a.weight;
        if (a.isCompleted) {
          sunnahRawScore += a.weight;
        }
      }
    }
    
    // Sunnah Prayers
    for (var s in sunnahPrayers) {
      sunnahMaxScore += s.weight;
      if (s.isCompleted) {
        sunnahRawScore += s.weight;
      }
    }
    
    // Scale sunnah score to 5.0 points max (increased from 2.5 since we removed wird)
    double sunnahScore = sunnahMaxScore > 0 ? (sunnahRawScore / sunnahMaxScore) * 5.0 : 0.0;

    // ==========================================
    // TOTAL SCORE (10.0 points max)
    // ==========================================
    return fardScore + sunnahScore;
  }

  Map<String, dynamic> getScoreBreakdown() {
    double fardScore = 0;
    if (prayers.isNotEmpty) {
      double totalPrayerScore = prayers.fold(0.0, (sum, p) => sum + p.score);
      double maxPossibleScore = prayers.length * 1.0;
      fardScore = maxPossibleScore > 0 ? (totalPrayerScore / maxPossibleScore) * 5.0 : 0.0;
    }

    double sunnahRawScore = 0;
    double sunnahMaxScore = 0;
    
    for (var a in azkar) {
      if (a.taskType == TaskType.sunnah) {
        sunnahMaxScore += a.weight;
        if (a.isCompleted) sunnahRawScore += a.weight;
      }
    }
    
    for (var s in sunnahPrayers) {
      sunnahMaxScore += s.weight;
      if (s.isCompleted) sunnahRawScore += s.weight;
    }
    
    double sunnahScore = sunnahMaxScore > 0 ? (sunnahRawScore / sunnahMaxScore) * 5.0 : 0.0;

    return {
      'fard': fardScore,
      'sunnah': sunnahScore,
      'total': fardScore + sunnahScore,
    };
  }

  Map<String, double> getCompletionPercentages() {
    Map<String, double> percentages = {};
    
    // Prayer completion (Fard)
    if (prayers.isNotEmpty) {
      int completedPrayers = prayers.where((p) => p.isCompleted).length;
      percentages['fard'] = (completedPrayers / prayers.length) * 100;
    }
    
    // Azkar completion
    if (azkar.isNotEmpty) {
      int completedAzkar = azkar.where((a) => a.isCompleted).length;
      percentages['azkar'] = (completedAzkar / azkar.length) * 100;
    }
    
    // Sunnah prayers completion
    if (sunnahPrayers.isNotEmpty) {
      int completedSunnah = sunnahPrayers.where((s) => s.isCompleted).length;
      percentages['sunnahPrayers'] = (completedSunnah / sunnahPrayers.length) * 100;
    }
    
    // Calculate combined sunnah percentage (azkar + sunnah prayers)
    double sunnahPercentage = 0.0;
    if (azkar.isNotEmpty && sunnahPrayers.isNotEmpty) {
      int totalSunnahTasks = azkar.length + sunnahPrayers.length;
      int completedSunnahTasks = azkar.where((a) => a.isCompleted).length + 
                                 sunnahPrayers.where((s) => s.isCompleted).length;
      sunnahPercentage = (completedSunnahTasks / totalSunnahTasks) * 100;
    } else if (azkar.isNotEmpty) {
      int completedAzkar = azkar.where((a) => a.isCompleted).length;
      sunnahPercentage = (completedAzkar / azkar.length) * 100;
    } else if (sunnahPrayers.isNotEmpty) {
      int completedSunnah = sunnahPrayers.where((s) => s.isCompleted).length;
      sunnahPercentage = (completedSunnah / sunnahPrayers.length) * 100;
    }
    percentages['sunnah'] = sunnahPercentage;
    
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

  static List<SunnahPrayer> _reorderSunnahPrayers(List<SunnahPrayer> prayers) {
    // Reorder sunnah prayers by type for consistent display
    final orderedTypes = [
      SunnahPrayerType.salatAlDuha,
      SunnahPrayerType.qiyamAlLayl,
    ];
    
    List<SunnahPrayer> orderedPrayers = [];
    for (var type in orderedTypes) {
      final prayer = prayers.firstWhere(
        (p) => p.type == type,
        orElse: () => SunnahPrayer(type: type, isCompleted: false, weight: 1.0),
      );
      orderedPrayers.add(prayer);
    }
    
    return orderedPrayers;
  }
}