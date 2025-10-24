import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'task_type.dart';

enum PrayerType {
  fajr,
  dhuhr,
  asr,
  maghrib,
  isha,
}

extension PrayerTypeExtension on PrayerType {
  String get displayName {
    switch (this) {
      case PrayerType.fajr:
        return 'Fajr';
      case PrayerType.dhuhr:
        return 'Dhuhr';
      case PrayerType.asr:
        return 'Asr';
      case PrayerType.maghrib:
        return 'Maghrib';
      case PrayerType.isha:
        return 'Isha';
    }
  }

  String getLocalizedName(AppLocalizations l10n) {
    switch (this) {
      case PrayerType.fajr:
        return l10n.fajr;
      case PrayerType.dhuhr:
        return l10n.dhuhr;
      case PrayerType.asr:
        return l10n.asr;
      case PrayerType.maghrib:
        return l10n.maghrib;
      case PrayerType.isha:
        return l10n.isha;
    }
  }

  IconData get icon {
    switch (this) {
      case PrayerType.fajr:
        return Icons.wb_sunny;
      case PrayerType.dhuhr:
        return Icons.wb_sunny_outlined;
      case PrayerType.asr:
        return Icons.wb_sunny_outlined;
      case PrayerType.maghrib:
        return Icons.nights_stay;
      case PrayerType.isha:
        return Icons.nights_stay_outlined;
    }
  }
}

class PrayerTask {
  final PrayerType type;
  final DateTime time;
  final TaskType taskType = TaskType.fard; // Prayers are Fard (mandatory)
  bool isCompleted;
  bool prayedOnTime;
  bool inMosque;
  bool prayedOutOfTime;

  PrayerTask({
    required this.type,
    required this.time,
    this.isCompleted = false,
    this.prayedOnTime = false,
    this.inMosque = false,
    this.prayedOutOfTime = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'time': time.toIso8601String(),
      'isCompleted': isCompleted,
      'prayedOnTime': prayedOnTime,
      'inMosque': inMosque,
      'prayedOutOfTime': prayedOutOfTime,
    };
  }

  factory PrayerTask.fromJson(Map<String, dynamic> json) {
    return PrayerTask(
      type: PrayerType.values.firstWhere(
        (e) => e.toString() == json['type'],
      ),
      time: DateTime.parse(json['time']),
      isCompleted: json['isCompleted'] ?? false,
      prayedOnTime: json['prayedOnTime'] ?? false,
      inMosque: json['inMosque'] ?? false,
      prayedOutOfTime: json['prayedOutOfTime'] ?? false,
    );
  }

  double get score {
    if (!isCompleted) return 0.0;
    
    // New scoring system: each prayer max 1.0 point
    // - 0.5 points for praying on time
    // - 0.5 points for praying in mosque
    // - If prayed out of time: only 0.25 points (no mosque bonus)
    
    double totalScore = 0.0;
    
    if (prayedOnTime) {
      totalScore += 0.5; // Half point for on time
    }
    
    if (inMosque && prayedOnTime) {
      totalScore += 0.5; // Half point for in mosque (only if prayed on time)
    }
    
    // If prayed out of time but not on time, only 0.25 points
    if (prayedOutOfTime && !prayedOnTime) {
      totalScore = 0.25;
    }
    
    return totalScore;
  }
  
  // Maximum possible score per prayer (on time)
  static const double maxScore = 1.0;
}

