import '../l10n/app_localizations.dart';

enum PrayerStatus {
  notPerformed,
  performed,
  late,
}

enum TaskType {
  fard,     // Mandatory (5 prayers)
  sunnah,   // Sunnah (Qiyam al-Layl)
}

extension TaskTypeExtension on TaskType {
  String getLocalizedDisplayName(AppLocalizations l10n) {
    switch (this) {
      case TaskType.fard:
        return l10n.fard;
      case TaskType.sunnah:
        return l10n.sunnah;
    }
  }
  
  String get description {
    switch (this) {
      case TaskType.fard:
        return 'Mandatory';
      case TaskType.sunnah:
        return 'Recommended';
    }
  }
  
  String getLocalizedDescription(AppLocalizations l10n) {
    switch (this) {
      case TaskType.fard:
        return l10n.mandatory;
      case TaskType.sunnah:
        return l10n.recommended;
    }
  }
}

