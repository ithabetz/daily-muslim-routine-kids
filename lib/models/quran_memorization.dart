import 'dart:convert';

/// Tracks memorization progress for Quran surahs
class QuranMemorization {
  final Map<int, bool> memorizedSurahs; // surah number -> memorized status
  final Map<int, int> juzTargetMonths; // juz number -> target month (1-12)
  final Map<String, int> monthlyProgress; // "YYYY-MM" -> current day in month
  final DateTime lastUpdated;

  QuranMemorization({
    Map<int, bool>? memorizedSurahs,
    Map<int, int>? juzTargetMonths,
    Map<String, int>? monthlyProgress,
    DateTime? lastUpdated,
  })  : memorizedSurahs = memorizedSurahs ?? {},
        juzTargetMonths = juzTargetMonths ?? _getDefaultJuzTargetMonths(),
        monthlyProgress = monthlyProgress ?? {},
        lastUpdated = lastUpdated ?? DateTime.now();

  /// Check if a surah is memorized
  bool isSurahMemorized(int surahNumber) {
    return memorizedSurahs[surahNumber] ?? false;
  }

  /// Toggle memorization status for a surah
  QuranMemorization toggleSurah(int surahNumber) {
    final newMemorizedSurahs = Map<int, bool>.from(memorizedSurahs);
    newMemorizedSurahs[surahNumber] = !(memorizedSurahs[surahNumber] ?? false);
    
    return QuranMemorization(
      memorizedSurahs: newMemorizedSurahs,
      juzTargetMonths: juzTargetMonths,
      lastUpdated: DateTime.now(),
    );
  }

  /// Get target month for a Juz
  int getJuzTargetMonth(int juzNumber) {
    return juzTargetMonths[juzNumber] ?? 1; // Default to January if not set
  }

  /// Set target month for a Juz
  QuranMemorization setJuzTargetMonth(int juzNumber, int month) {
    final newJuzTargetMonths = Map<int, int>.from(juzTargetMonths);
    newJuzTargetMonths[juzNumber] = month;
    
    return QuranMemorization(
      memorizedSurahs: memorizedSurahs,
      juzTargetMonths: newJuzTargetMonths,
      lastUpdated: DateTime.now(),
    );
  }

  /// Get current day in month for memorization progress
  int getCurrentDayInMonth() {
    final now = DateTime.now();
    final monthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    return monthlyProgress[monthKey] ?? now.day;
  }

  /// Update current day in month
  QuranMemorization updateCurrentDayInMonth() {
    final now = DateTime.now();
    final monthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    final newMonthlyProgress = Map<String, int>.from(monthlyProgress);
    newMonthlyProgress[monthKey] = now.day;
    
    return QuranMemorization(
      memorizedSurahs: memorizedSurahs,
      juzTargetMonths: juzTargetMonths,
      monthlyProgress: newMonthlyProgress,
      lastUpdated: DateTime.now(),
    );
  }

  /// Get total days in current month
  int getTotalDaysInCurrentMonth() {
    final now = DateTime.now();
    return DateTime(now.year, now.month + 1, 0).day;
  }

  /// Get current day progress for a specific Juz's target month
  int getJuzCurrentDay(int juzNumber) {
    final targetMonth = getJuzTargetMonth(juzNumber);
    final now = DateTime.now();
    
    // If the target month is the current month, return current day
    if (targetMonth == now.month) {
      return now.day;
    }
    
    // If the target month is in the past, return the last day of that month
    if (targetMonth < now.month) {
      return DateTime(now.year, targetMonth + 1, 0).day;
    }
    
    // If the target month is in the future, return day 1
    return 1;
  }

  /// Get total days in a Juz's target month
  int getJuzTotalDaysInMonth(int juzNumber) {
    final targetMonth = getJuzTargetMonth(juzNumber);
    final now = DateTime.now();
    return DateTime(now.year, targetMonth + 1, 0).day;
  }

  /// Update progress for a specific Juz's target month
  QuranMemorization updateJuzProgress(int juzNumber, int day) {
    final targetMonth = getJuzTargetMonth(juzNumber);
    final now = DateTime.now();
    final monthKey = '${now.year}-${targetMonth.toString().padLeft(2, '0')}';
    final newMonthlyProgress = Map<String, int>.from(monthlyProgress);
    newMonthlyProgress[monthKey] = day;
    
    return QuranMemorization(
      memorizedSurahs: memorizedSurahs,
      juzTargetMonths: juzTargetMonths,
      monthlyProgress: newMonthlyProgress,
      lastUpdated: DateTime.now(),
    );
  }

  /// Check if there has been any memorization progress today
  bool hasProgressToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastUpdate = DateTime(lastUpdated.year, lastUpdated.month, lastUpdated.day);
    
    // If last update was today, consider it as progress
    return today.isAtSameMomentAs(lastUpdate);
  }

  /// Check if there are any memorized surahs
  bool hasAnyMemorizedSurahs() {
    return memorizedSurahs.values.any((memorized) => memorized);
  }

  /// Get default Juz target months - Focus on specific Juz for memorization
  static Map<int, int> _getDefaultJuzTargetMonths() {
    return {
      // Focus on specific Juz for memorization
      28: 12, // Juz 28 (Qad Sami) in December
      29: 11, // Juz 29 (Tabarak) in November  
      30: 10, // Juz 30 (Amma) in October
    };
  }

  /// Get Juz name by number
  static String getJuzName(int juzNumber) {
    switch (juzNumber) {
      case 28: return 'جزء قد سمع';
      case 29: return 'جزء تبارك';
      case 30: return 'جزء عم';
      default: return 'الجزء $juzNumber';
    }
  }

  /// Get available Juz for memorization
  static List<int> getAvailableJuz() {
    return [28, 29, 30];
  }


  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'memorizedSurahs': memorizedSurahs.map((key, value) => MapEntry(key.toString(), value)),
      'juzTargetMonths': juzTargetMonths.map((key, value) => MapEntry(key.toString(), value)),
      'monthlyProgress': monthlyProgress,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  /// Create from JSON
  factory QuranMemorization.fromJson(Map<String, dynamic> json) {
    final memorizedSurahsMap = <int, bool>{};
    if (json['memorizedSurahs'] != null) {
      (json['memorizedSurahs'] as Map<String, dynamic>).forEach((key, value) {
        memorizedSurahsMap[int.parse(key)] = value as bool;
      });
    }

    final juzTargetMonthsMap = <int, int>{};
    if (json['juzTargetMonths'] != null) {
      (json['juzTargetMonths'] as Map<String, dynamic>).forEach((key, value) {
        juzTargetMonthsMap[int.parse(key)] = value as int;
      });
    }

    final monthlyProgressMap = <String, int>{};
    if (json['monthlyProgress'] != null) {
      (json['monthlyProgress'] as Map<String, dynamic>).forEach((key, value) {
        monthlyProgressMap[key] = value as int;
      });
    }

    return QuranMemorization(
      memorizedSurahs: memorizedSurahsMap,
      juzTargetMonths: juzTargetMonthsMap.isNotEmpty ? juzTargetMonthsMap : null,
      monthlyProgress: monthlyProgressMap,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : DateTime.now(),
    );
  }


  /// Convert to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  /// Create from JSON string
  factory QuranMemorization.fromJsonString(String jsonString) {
    return QuranMemorization.fromJson(jsonDecode(jsonString));
  }

  /// Get count of memorized surahs in a specific juz
  int getMemorizedCountForJuz(int juzNumber, List<int> surahsInJuz) {
    return surahsInJuz.where((surahNumber) => isSurahMemorized(surahNumber)).length;
  }

  /// Create a copy with updated values
  QuranMemorization copyWith({
    Map<int, bool>? memorizedSurahs,
    Map<int, int>? juzTargetMonths,
    Map<String, int>? monthlyProgress,
    DateTime? lastUpdated,
  }) {
    return QuranMemorization(
      memorizedSurahs: memorizedSurahs ?? this.memorizedSurahs,
      juzTargetMonths: juzTargetMonths ?? this.juzTargetMonths,
      monthlyProgress: monthlyProgress ?? this.monthlyProgress,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

