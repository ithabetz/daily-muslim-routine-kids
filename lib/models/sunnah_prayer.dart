import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'task_type.dart';

enum SunnahPrayerType {
  // Regular Sunnah Prayers
  salatAlDuha,  // Morning prayer
  qiyamAlLayl,  // Night prayer
  
  // Sunnah Before/After Fard Prayers
  fajrSunnahBefore,    // 2 rakat before Fajr
  fajrSunnahAfter,     // No sunnah after Fajr
  
  dhuhrSunnahBefore1,  // 2 rakat before Dhuhr (first)
  dhuhrSunnahBefore2,  // 2 rakat before Dhuhr (second)
  dhuhrSunnahAfter,    // 2 rakat after Dhuhr
  
  asrSunnahBefore,     // No sunnah before Asr
  asrSunnahAfter,      // No sunnah after Asr
  
  maghribSunnahBefore, // No sunnah before Maghrib
  maghribSunnahAfter,  // 2 rakat after Maghrib
  
  ishaSunnahBefore,    // No sunnah before Isha
  ishaSunnahAfter,     // 2 rakat after Isha
}

extension SunnahPrayerTypeExtension on SunnahPrayerType {
  String get displayName {
    switch (this) {
      case SunnahPrayerType.salatAlDuha:
        return 'صلاة الضحى';
      case SunnahPrayerType.qiyamAlLayl:
        return 'قيام الليل';
      
      // Fajr Sunnah
      case SunnahPrayerType.fajrSunnahBefore:
        return 'قبل الفجر (ركعتان)';
      case SunnahPrayerType.fajrSunnahAfter:
        return 'سنة الفجر بعد';
      
      // Dhuhr Sunnah
      case SunnahPrayerType.dhuhrSunnahBefore1:
        return 'قبل الظهر (ركعتان)';
      case SunnahPrayerType.dhuhrSunnahBefore2:
        return 'قبل الظهر (ركعتان)';
      case SunnahPrayerType.dhuhrSunnahAfter:
        return 'بعد الظهر (ركعتان)';
      
      // Asr Sunnah
      case SunnahPrayerType.asrSunnahBefore:
        return 'سنة العصر قبل';
      case SunnahPrayerType.asrSunnahAfter:
        return 'سنة العصر بعد';
      
      // Maghrib Sunnah
      case SunnahPrayerType.maghribSunnahBefore:
        return 'سنة المغرب قبل';
      case SunnahPrayerType.maghribSunnahAfter:
        return 'بعد المغرب (ركعتان)';
      
      // Isha Sunnah
      case SunnahPrayerType.ishaSunnahBefore:
        return 'سنة العشاء قبل';
      case SunnahPrayerType.ishaSunnahAfter:
        return 'بعد العشاء (ركعتان)';
    }
  }

  String getLocalizedName(AppLocalizations l10n) {
    switch (this) {
      case SunnahPrayerType.salatAlDuha:
        return l10n.salatAlDuha;
      case SunnahPrayerType.qiyamAlLayl:
        return l10n.qiyamAlLayl;
      
      // Fajr Sunnah
      case SunnahPrayerType.fajrSunnahBefore:
        return 'قبل الفجر (ركعتان)';
      case SunnahPrayerType.fajrSunnahAfter:
        return 'سنة الفجر بعد';
      
      // Dhuhr Sunnah
      case SunnahPrayerType.dhuhrSunnahBefore1:
        return 'قبل الظهر (ركعتان)';
      case SunnahPrayerType.dhuhrSunnahBefore2:
        return 'قبل الظهر (ركعتان)';
      case SunnahPrayerType.dhuhrSunnahAfter:
        return 'بعد الظهر (ركعتان)';
      
      // Asr Sunnah
      case SunnahPrayerType.asrSunnahBefore:
        return 'سنة العصر قبل';
      case SunnahPrayerType.asrSunnahAfter:
        return 'سنة العصر بعد';
      
      // Maghrib Sunnah
      case SunnahPrayerType.maghribSunnahBefore:
        return 'سنة المغرب قبل';
      case SunnahPrayerType.maghribSunnahAfter:
        return 'بعد المغرب (ركعتان)';
      
      // Isha Sunnah
      case SunnahPrayerType.ishaSunnahBefore:
        return 'سنة العشاء قبل';
      case SunnahPrayerType.ishaSunnahAfter:
        return 'بعد العشاء (ركعتان)';
    }
  }

  String getLocalizedDescription(AppLocalizations l10n) {
    switch (this) {
      case SunnahPrayerType.salatAlDuha:
        return l10n.salatAlDuhaDescription;
      case SunnahPrayerType.qiyamAlLayl:
        return l10n.qiyamAlLaylDescription;
      
      // Fajr Sunnah
      case SunnahPrayerType.fajrSunnahBefore:
        return 'صلاة السنة قبل الفجر';
      case SunnahPrayerType.fajrSunnahAfter:
        return 'لا توجد سنة بعد الفجر';
      
      // Dhuhr Sunnah
      case SunnahPrayerType.dhuhrSunnahBefore1:
        return 'المجموعة الأولى من صلاة السنة قبل الظهر';
      case SunnahPrayerType.dhuhrSunnahBefore2:
        return 'المجموعة الثانية من صلاة السنة قبل الظهر';
      case SunnahPrayerType.dhuhrSunnahAfter:
        return 'صلاة السنة بعد الظهر';
      
      // Asr Sunnah
      case SunnahPrayerType.asrSunnahBefore:
        return 'لا توجد سنة قبل العصر';
      case SunnahPrayerType.asrSunnahAfter:
        return 'لا توجد سنة بعد العصر';
      
      // Maghrib Sunnah
      case SunnahPrayerType.maghribSunnahBefore:
        return 'لا توجد سنة قبل المغرب';
      case SunnahPrayerType.maghribSunnahAfter:
        return 'صلاة السنة بعد المغرب';
      
      // Isha Sunnah
      case SunnahPrayerType.ishaSunnahBefore:
        return 'لا توجد سنة قبل العشاء';
      case SunnahPrayerType.ishaSunnahAfter:
        return 'صلاة السنة بعد العشاء';
    }
  }
  
  String get description {
    switch (this) {
      case SunnahPrayerType.salatAlDuha:
        return 'صلاة الصباح بعد الشروق';
      case SunnahPrayerType.qiyamAlLayl:
        return 'صلاة الليل قبل الفجر';
      
      // Fajr Sunnah
      case SunnahPrayerType.fajrSunnahBefore:
        return 'صلاة السنة قبل الفجر';
      case SunnahPrayerType.fajrSunnahAfter:
        return 'لا توجد سنة بعد الفجر';
      
      // Dhuhr Sunnah
      case SunnahPrayerType.dhuhrSunnahBefore1:
        return 'المجموعة الأولى من صلاة السنة قبل الظهر';
      case SunnahPrayerType.dhuhrSunnahBefore2:
        return 'المجموعة الثانية من صلاة السنة قبل الظهر';
      case SunnahPrayerType.dhuhrSunnahAfter:
        return 'صلاة السنة بعد الظهر';
      
      // Asr Sunnah
      case SunnahPrayerType.asrSunnahBefore:
        return 'لا توجد سنة قبل العصر';
      case SunnahPrayerType.asrSunnahAfter:
        return 'لا توجد سنة بعد العصر';
      
      // Maghrib Sunnah
      case SunnahPrayerType.maghribSunnahBefore:
        return 'لا توجد سنة قبل المغرب';
      case SunnahPrayerType.maghribSunnahAfter:
        return 'صلاة السنة بعد المغرب';
      
      // Isha Sunnah
      case SunnahPrayerType.ishaSunnahBefore:
        return 'لا توجد سنة قبل العشاء';
      case SunnahPrayerType.ishaSunnahAfter:
        return 'صلاة السنة بعد العشاء';
    }
  }
  
  IconData get icon {
    switch (this) {
      case SunnahPrayerType.salatAlDuha:
        return Icons.wb_sunny;
      case SunnahPrayerType.qiyamAlLayl:
        return Icons.nights_stay;
      
      // Fajr Sunnah
      case SunnahPrayerType.fajrSunnahBefore:
      case SunnahPrayerType.fajrSunnahAfter:
        return Icons.wb_twilight;
      
      // Dhuhr Sunnah
      case SunnahPrayerType.dhuhrSunnahBefore1:
      case SunnahPrayerType.dhuhrSunnahBefore2:
      case SunnahPrayerType.dhuhrSunnahAfter:
        return Icons.wb_sunny;
      
      // Asr Sunnah
      case SunnahPrayerType.asrSunnahBefore:
      case SunnahPrayerType.asrSunnahAfter:
        return Icons.wb_sunny_outlined;
      
      // Maghrib Sunnah
      case SunnahPrayerType.maghribSunnahBefore:
      case SunnahPrayerType.maghribSunnahAfter:
        return Icons.wb_twilight;
      
      // Isha Sunnah
      case SunnahPrayerType.ishaSunnahBefore:
      case SunnahPrayerType.ishaSunnahAfter:
        return Icons.nights_stay;
    }
  }
}

class SunnahPrayer {
  final SunnahPrayerType type;
  final TaskType taskType = TaskType.sunnah;
  bool isCompleted;
  final double weight;

  SunnahPrayer({
    required this.type,
    this.isCompleted = false,
    this.weight = 0.5, // Same weight as other Sunnah tasks
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'isCompleted': isCompleted,
      'weight': weight,
    };
  }

  factory SunnahPrayer.fromJson(Map<String, dynamic> json) {
    return SunnahPrayer(
      type: SunnahPrayerType.values.firstWhere(
        (e) => e.toString() == json['type'],
      ),
      isCompleted: json['isCompleted'] ?? false,
      weight: json['weight'] ?? 0.5,
    );
  }

  double get score => isCompleted ? weight : 0.0;
}
