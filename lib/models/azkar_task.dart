import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'task_type.dart';

enum AzkarType {
  morning,           // Morning Azkar (Wird)
  evening,           // Evening Azkar (Wird)
  quranReading,      // Quran Reading (Wird)
  quranListening,    // Quran Listening (Wird)
  istighfar,         // Istighfar (Wird) - الاستغفار
  salatAlaNabi,      // Salat ala Nabi (Wird) - الصلاة على النبي
  tasbih,            // Tasbih (Wird) - سبحان الله
  tahmid,            // Tahmid (Wird) - الحمد لله
  laIlahaIllaAllah,  // La Ilaha Illa Allah (Wird) - لا اله الا الله
  takbir,            // Takbir (Wird) - الله أكبر
  laHawlaWaLaQuwwata, // La Hawla Wa La Quwwata Illa Billah (Wird) - لا حول ولا قوة إلا بالله
}

extension AzkarTypeExtension on AzkarType {
  String get displayName {
    switch (this) {
      case AzkarType.morning:
        return 'أذكار الصباح';
      case AzkarType.evening:
        return 'أذكار المساء';
      case AzkarType.quranReading:
        return 'قراءة القرآن';
      case AzkarType.quranListening:
        return 'الاستماع للقرآن';
      case AzkarType.istighfar:
        return 'الاستغفار (100 مرة)';
      case AzkarType.salatAlaNabi:
        return 'الصلاة على النبي (100 مرة)';
      case AzkarType.laHawlaWaLaQuwwata:
        return 'لا حول ولا قوة إلا بالله (100 مرة)';
      case AzkarType.tasbih:
        return 'سبحان الله (100 مرة)';
      case AzkarType.tahmid:
        return 'الحمد لله (100 مرة)';
      case AzkarType.takbir:
        return 'الله أكبر (100 مرة)';
      case AzkarType.laIlahaIllaAllah:
        return 'لا إله إلا الله (100 مرة)';
    }
  }

  String getLocalizedName(AppLocalizations l10n) {
    switch (this) {
      case AzkarType.morning:
        return l10n.morningAzkar;
      case AzkarType.evening:
        return l10n.eveningAzkar;
      case AzkarType.quranReading:
        return l10n.quranReading;
      case AzkarType.quranListening:
        return l10n.quranListening;
      case AzkarType.istighfar:
        return l10n.istighfar;
      case AzkarType.salatAlaNabi:
        return l10n.salatAlaNabi;
      case AzkarType.tasbih:
        return l10n.tasbih;
      case AzkarType.tahmid:
        return l10n.tahmid;
      case AzkarType.laIlahaIllaAllah:
        return l10n.laIlahaIllaAllah;
      case AzkarType.takbir:
        return l10n.takbir;
      case AzkarType.laHawlaWaLaQuwwata:
        return l10n.laHawlaWaLaQuwwata;
    }
  }

  String getLocalizedDescription(AppLocalizations l10n) {
    switch (this) {
      case AzkarType.morning:
        return l10n.morningAzkarDescription;
      case AzkarType.evening:
        return l10n.eveningAzkarDescription;
      case AzkarType.quranReading:
        return l10n.quranReadingDescription;
      case AzkarType.quranListening:
        return l10n.quranListeningDescription;
      case AzkarType.istighfar:
        return l10n.istighfarDescription;
      case AzkarType.salatAlaNabi:
        return l10n.salatAlaNabiDescription;
      case AzkarType.tasbih:
        return l10n.tasbihDescription;
      case AzkarType.tahmid:
        return l10n.tahmidDescription;
      case AzkarType.laIlahaIllaAllah:
        return l10n.laIlahaIllaAllahDescription;
      case AzkarType.takbir:
        return l10n.takbirDescription;
      case AzkarType.laHawlaWaLaQuwwata:
        return l10n.laHawlaWaLaQuwwataDescription;
    }
  }
  
  TaskType get taskType {
    switch (this) {
      case AzkarType.morning:
      case AzkarType.evening:
      case AzkarType.quranReading:
      case AzkarType.quranListening:
      case AzkarType.istighfar:
      case AzkarType.salatAlaNabi:
      case AzkarType.tasbih:
      case AzkarType.tahmid:
      case AzkarType.laIlahaIllaAllah:
      case AzkarType.takbir:
      case AzkarType.laHawlaWaLaQuwwata:
        return TaskType.sunnah;
    }
  }
  
  double get weight {
    switch (this) {
      case AzkarType.morning:
        return 0.7; // أذكار الصباح تحصل على 0.7 نقطة
      case AzkarType.evening:
        return 0.7; // أذكار المساء تحصل على 0.7 نقطة
      case AzkarType.quranReading:
        return 0.2; // Quran Reading gets 0.2 points
      case AzkarType.quranListening:
        return 0.2; // Quran Listening gets 0.2 points
      case AzkarType.istighfar:
        return 0.1; // Istighfar gets 0.1 points
      case AzkarType.salatAlaNabi:
        return 0.1; // Salat ala Nabi gets 0.1 points
      case AzkarType.tasbih:
        return 0.1; // Tasbih gets 0.1 points
      case AzkarType.tahmid:
        return 0.1; // Tahmid gets 0.1 points
      case AzkarType.laIlahaIllaAllah:
        return 0.1; // La Ilaha Illa Allah gets 0.1 points
      case AzkarType.takbir:
        return 0.1; // Takbir gets 0.1 points
      case AzkarType.laHawlaWaLaQuwwata:
        return 0.1; // La Hawla Wa La Quwwata Illa Billah gets 0.1 points
    }
  }

  IconData get icon {
    switch (this) {
      case AzkarType.morning:
        return Icons.wb_sunny;
      case AzkarType.evening:
        return Icons.nights_stay;
      case AzkarType.quranReading:
        return Icons.menu_book; // Book icon for Quran reading
      case AzkarType.quranListening:
        return Icons.headphones; // Headphones icon for Quran listening
      case AzkarType.istighfar:
        return Icons.auto_fix_high;
      case AzkarType.salatAlaNabi:
        return Icons.favorite;
      case AzkarType.tasbih:
        return Icons.radio_button_checked;
      case AzkarType.tahmid:
        return Icons.thumb_up;
      case AzkarType.laIlahaIllaAllah:
        return Icons.account_balance; // Mosque/faith icon for testimony of faith
      case AzkarType.takbir:
        return Icons.volume_up;
      case AzkarType.laHawlaWaLaQuwwata:
        return Icons.eco; // Nature/creation icon for the righteous deeds
    }
  }
}

class AzkarTask {
  final AzkarType type;
  TaskType get taskType => type.taskType; // Dynamic based on type
  double get weight => type.weight; // Dynamic based on type
  bool isCompleted;

  AzkarTask({
    required this.type,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'isCompleted': isCompleted,
    };
  }

  factory AzkarTask.fromJson(Map<String, dynamic> json) {
    // Handle backward compatibility for removed gharasAlJannah and old baqiyatSalihat
    String typeString = json['type'];
    if (typeString.contains('gharasAlJannah') || typeString.contains('baqiyatSalihat')) {
      // Map old names to laHawlaWaLaQuwwata for backward compatibility
      typeString = 'AzkarType.laHawlaWaLaQuwwata';
    }
    
    // Handle backward compatibility for old AdhkarType enum values
    if (typeString.contains('AdhkarType.')) {
      typeString = typeString.replaceAll('AdhkarType.', 'AzkarType.');
    }
    
    return AzkarTask(
      type: AzkarType.values.firstWhere(
        (e) => e.toString() == typeString,
        orElse: () => AzkarType.istighfar, // Fallback to istighfar if type not found
      ),
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}

