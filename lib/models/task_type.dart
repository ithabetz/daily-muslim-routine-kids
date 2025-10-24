import '../l10n/app_localizations.dart';

enum PrayerStatus {
  notPerformed,
  performed,
  late,
}

enum TaskType {
  fard,     // Mandatory (5 prayers)
  sunnah,   // Sunnah (Qiyam al-Layl)
  wird,     // Daily Wird (Quran, Azkar, Salat ala Nabi)
  sadaqat,  // Monthly Sadaqat (Unified charity tracking)
  muhasabatAlNafs, // محاسبة النفس (Self-accountability)
}

extension TaskTypeExtension on TaskType {
  String getLocalizedDisplayName(AppLocalizations l10n) {
    switch (this) {
      case TaskType.fard:
        return l10n.fard;
      case TaskType.sunnah:
        return l10n.sunnah;
      case TaskType.wird:
        return l10n.wird;
      case TaskType.sadaqat:
        return l10n.sadaqat;
      case TaskType.muhasabatAlNafs:
        return l10n.muhasabatAlNafsTracker;
    }
  }
  
  String get description {
    switch (this) {
      case TaskType.fard:
        return 'Mandatory';
      case TaskType.sunnah:
        return 'Recommended';
      case TaskType.wird:
        return 'Daily Devotion';
      case TaskType.sadaqat:
        return 'Charity';
      case TaskType.muhasabatAlNafs:
        return 'Self-Accountability';
    }
  }
  
  String getLocalizedDescription(AppLocalizations l10n) {
    switch (this) {
      case TaskType.fard:
        return l10n.mandatory;
      case TaskType.sunnah:
        return l10n.recommended;
      case TaskType.wird:
        return l10n.dailyDevotion;
      case TaskType.sadaqat:
        return l10n.charity;
      case TaskType.muhasabatAlNafs:
        return l10n.selfAccountability;
    }
  }
}

