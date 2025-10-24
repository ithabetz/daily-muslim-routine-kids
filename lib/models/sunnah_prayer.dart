import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'task_type.dart';

enum SunnahPrayerType {
  salatAlDuha,  // Morning prayer
  qiyamAlLayl,  // Night prayer
}

extension SunnahPrayerTypeExtension on SunnahPrayerType {
  String get displayName {
    switch (this) {
      case SunnahPrayerType.salatAlDuha:
        return 'Salat al-Duha (Morning Prayer)';
      case SunnahPrayerType.qiyamAlLayl:
        return 'Qiyam al-Layl (Night Prayer)';
    }
  }

  String getLocalizedName(AppLocalizations l10n) {
    switch (this) {
      case SunnahPrayerType.salatAlDuha:
        return l10n.salatAlDuha;
      case SunnahPrayerType.qiyamAlLayl:
        return l10n.qiyamAlLayl;
    }
  }

  String getLocalizedDescription(AppLocalizations l10n) {
    switch (this) {
      case SunnahPrayerType.salatAlDuha:
        return l10n.salatAlDuhaDescription;
      case SunnahPrayerType.qiyamAlLayl:
        return l10n.qiyamAlLaylDescription;
    }
  }
  
  String get description {
    switch (this) {
      case SunnahPrayerType.salatAlDuha:
        return 'Morning prayer after sunrise';
      case SunnahPrayerType.qiyamAlLayl:
        return 'Night prayer before Fajr';
    }
  }
  
  IconData get icon {
    switch (this) {
      case SunnahPrayerType.salatAlDuha:
        return Icons.wb_sunny;
      case SunnahPrayerType.qiyamAlLayl:
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
