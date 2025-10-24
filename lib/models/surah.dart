/// Represents a Surah (chapter) of the Quran
class Surah {
  final int number;
  final String nameArabic;
  final String nameEnglish;
  final String transliteration;
  final int numberOfAyahs;
  final int juzNumber;
  final String revelationType; // 'Meccan' or 'Medinan'

  const Surah({
    required this.number,
    required this.nameArabic,
    required this.nameEnglish,
    required this.transliteration,
    required this.numberOfAyahs,
    required this.juzNumber,
    required this.revelationType,
  });

  /// Returns all surahs in Juz' 28 (Juz' Qad Sami)
  static List<Surah> getJuz28Surahs() {
    return [
      const Surah(
        number: 58,
        nameArabic: 'المجادلة',
        nameEnglish: 'The Disputation',
        transliteration: 'Al-Mujadila',
        numberOfAyahs: 22,
        juzNumber: 28,
        revelationType: 'Medinan',
      ),
      const Surah(
        number: 59,
        nameArabic: 'الحشر',
        nameEnglish: 'The Exile',
        transliteration: 'Al-Hashr',
        numberOfAyahs: 24,
        juzNumber: 28,
        revelationType: 'Medinan',
      ),
      const Surah(
        number: 60,
        nameArabic: 'الممتحنة',
        nameEnglish: 'She That Is To Be Examined',
        transliteration: 'Al-Mumtahina',
        numberOfAyahs: 13,
        juzNumber: 28,
        revelationType: 'Medinan',
      ),
      const Surah(
        number: 61,
        nameArabic: 'الصف',
        nameEnglish: 'The Ranks',
        transliteration: 'As-Saff',
        numberOfAyahs: 14,
        juzNumber: 28,
        revelationType: 'Medinan',
      ),
      const Surah(
        number: 62,
        nameArabic: 'الجمعة',
        nameEnglish: 'Friday',
        transliteration: 'Al-Jumu\'a',
        numberOfAyahs: 11,
        juzNumber: 28,
        revelationType: 'Medinan',
      ),
      const Surah(
        number: 63,
        nameArabic: 'المنافقون',
        nameEnglish: 'The Hypocrites',
        transliteration: 'Al-Munafiqun',
        numberOfAyahs: 11,
        juzNumber: 28,
        revelationType: 'Medinan',
      ),
      const Surah(
        number: 64,
        nameArabic: 'التغابن',
        nameEnglish: 'The Mutual Disillusion',
        transliteration: 'At-Taghabun',
        numberOfAyahs: 18,
        juzNumber: 28,
        revelationType: 'Medinan',
      ),
      const Surah(
        number: 65,
        nameArabic: 'الطلاق',
        nameEnglish: 'The Divorce',
        transliteration: 'At-Talaq',
        numberOfAyahs: 12,
        juzNumber: 28,
        revelationType: 'Medinan',
      ),
      const Surah(
        number: 66,
        nameArabic: 'التحريم',
        nameEnglish: 'The Prohibition',
        transliteration: 'At-Tahrim',
        numberOfAyahs: 12,
        juzNumber: 28,
        revelationType: 'Medinan',
      ),
    ];
  }

  /// Returns all surahs in Juz' 29 (Juz' Tabarak)
  static List<Surah> getJuz29Surahs() {
    return [
      const Surah(
        number: 67,
        nameArabic: 'الملك',
        nameEnglish: 'The Sovereignty',
        transliteration: 'Al-Mulk',
        numberOfAyahs: 30,
        juzNumber: 29,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 68,
        nameArabic: 'القلم',
        nameEnglish: 'The Pen',
        transliteration: 'Al-Qalam',
        numberOfAyahs: 52,
        juzNumber: 29,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 69,
        nameArabic: 'الحاقة',
        nameEnglish: 'The Reality',
        transliteration: 'Al-Haqqah',
        numberOfAyahs: 52,
        juzNumber: 29,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 70,
        nameArabic: 'المعارج',
        nameEnglish: 'The Ascending Stairways',
        transliteration: 'Al-Ma\'arij',
        numberOfAyahs: 44,
        juzNumber: 29,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 71,
        nameArabic: 'نوح',
        nameEnglish: 'Noah',
        transliteration: 'Nuh',
        numberOfAyahs: 28,
        juzNumber: 29,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 72,
        nameArabic: 'الجن',
        nameEnglish: 'The Jinn',
        transliteration: 'Al-Jinn',
        numberOfAyahs: 28,
        juzNumber: 29,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 73,
        nameArabic: 'المزمل',
        nameEnglish: 'The Enshrouded One',
        transliteration: 'Al-Muzzammil',
        numberOfAyahs: 20,
        juzNumber: 29,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 74,
        nameArabic: 'المدثر',
        nameEnglish: 'The Cloaked One',
        transliteration: 'Al-Muddaththir',
        numberOfAyahs: 56,
        juzNumber: 29,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 75,
        nameArabic: 'القيامة',
        nameEnglish: 'The Resurrection',
        transliteration: 'Al-Qiyamah',
        numberOfAyahs: 40,
        juzNumber: 29,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 76,
        nameArabic: 'الإنسان',
        nameEnglish: 'The Human',
        transliteration: 'Al-Insan',
        numberOfAyahs: 31,
        juzNumber: 29,
        revelationType: 'Medinan',
      ),
      const Surah(
        number: 77,
        nameArabic: 'المرسلات',
        nameEnglish: 'The Emissaries',
        transliteration: 'Al-Mursalat',
        numberOfAyahs: 50,
        juzNumber: 29,
        revelationType: 'Meccan',
      ),
    ];
  }

  /// Returns all surahs in Juz' 30 (Juz' Amma)
  static List<Surah> getJuz30Surahs() {
    return [
      const Surah(
        number: 78,
        nameArabic: 'النبأ',
        nameEnglish: 'The Tidings',
        transliteration: 'An-Naba',
        numberOfAyahs: 40,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 79,
        nameArabic: 'النازعات',
        nameEnglish: 'Those Who Pull Out',
        transliteration: 'An-Nazi\'at',
        numberOfAyahs: 46,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 80,
        nameArabic: 'عبس',
        nameEnglish: 'He Frowned',
        transliteration: '\'Abasa',
        numberOfAyahs: 42,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 81,
        nameArabic: 'التكوير',
        nameEnglish: 'The Overthrowing',
        transliteration: 'At-Takwir',
        numberOfAyahs: 29,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 82,
        nameArabic: 'الإنفطار',
        nameEnglish: 'The Cleaving',
        transliteration: 'Al-Infitar',
        numberOfAyahs: 19,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 83,
        nameArabic: 'المطففين',
        nameEnglish: 'The Defrauders',
        transliteration: 'Al-Mutaffifin',
        numberOfAyahs: 36,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 84,
        nameArabic: 'الإنشقاق',
        nameEnglish: 'The Splitting Asunder',
        transliteration: 'Al-Inshiqaq',
        numberOfAyahs: 25,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 85,
        nameArabic: 'البروج',
        nameEnglish: 'The Mansions of the Stars',
        transliteration: 'Al-Buruj',
        numberOfAyahs: 22,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 86,
        nameArabic: 'الطارق',
        nameEnglish: 'The Night-Comer',
        transliteration: 'At-Tariq',
        numberOfAyahs: 17,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 87,
        nameArabic: 'الأعلى',
        nameEnglish: 'The Most High',
        transliteration: 'Al-A\'la',
        numberOfAyahs: 19,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 88,
        nameArabic: 'الغاشية',
        nameEnglish: 'The Overwhelming',
        transliteration: 'Al-Ghashiyah',
        numberOfAyahs: 26,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 89,
        nameArabic: 'الفجر',
        nameEnglish: 'The Dawn',
        transliteration: 'Al-Fajr',
        numberOfAyahs: 30,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 90,
        nameArabic: 'البلد',
        nameEnglish: 'The City',
        transliteration: 'Al-Balad',
        numberOfAyahs: 20,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 91,
        nameArabic: 'الشمس',
        nameEnglish: 'The Sun',
        transliteration: 'Ash-Shams',
        numberOfAyahs: 15,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 92,
        nameArabic: 'الليل',
        nameEnglish: 'The Night',
        transliteration: 'Al-Layl',
        numberOfAyahs: 21,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 93,
        nameArabic: 'الضحى',
        nameEnglish: 'The Forenoon',
        transliteration: 'Ad-Duha',
        numberOfAyahs: 11,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 94,
        nameArabic: 'الشرح',
        nameEnglish: 'The Opening Forth',
        transliteration: 'Ash-Sharh',
        numberOfAyahs: 8,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 95,
        nameArabic: 'التين',
        nameEnglish: 'The Fig',
        transliteration: 'At-Tin',
        numberOfAyahs: 8,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 96,
        nameArabic: 'العلق',
        nameEnglish: 'The Clot',
        transliteration: 'Al-\'Alaq',
        numberOfAyahs: 19,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 97,
        nameArabic: 'القدر',
        nameEnglish: 'The Night of Decree',
        transliteration: 'Al-Qadr',
        numberOfAyahs: 5,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 98,
        nameArabic: 'البينة',
        nameEnglish: 'The Clear Evidence',
        transliteration: 'Al-Bayyinah',
        numberOfAyahs: 8,
        juzNumber: 30,
        revelationType: 'Medinan',
      ),
      const Surah(
        number: 99,
        nameArabic: 'الزلزلة',
        nameEnglish: 'The Earthquake',
        transliteration: 'Az-Zalzalah',
        numberOfAyahs: 8,
        juzNumber: 30,
        revelationType: 'Medinan',
      ),
      const Surah(
        number: 100,
        nameArabic: 'العاديات',
        nameEnglish: 'The Courser',
        transliteration: 'Al-\'Adiyat',
        numberOfAyahs: 11,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 101,
        nameArabic: 'القارعة',
        nameEnglish: 'The Calamity',
        transliteration: 'Al-Qari\'ah',
        numberOfAyahs: 11,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 102,
        nameArabic: 'التكاثر',
        nameEnglish: 'The Rivalry in Worldly Increase',
        transliteration: 'At-Takathur',
        numberOfAyahs: 8,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 103,
        nameArabic: 'العصر',
        nameEnglish: 'The Time',
        transliteration: 'Al-\'Asr',
        numberOfAyahs: 3,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 104,
        nameArabic: 'الهمزة',
        nameEnglish: 'The Slanderer',
        transliteration: 'Al-Humazah',
        numberOfAyahs: 9,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 105,
        nameArabic: 'الفيل',
        nameEnglish: 'The Elephant',
        transliteration: 'Al-Fil',
        numberOfAyahs: 5,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 106,
        nameArabic: 'قريش',
        nameEnglish: 'Quraysh',
        transliteration: 'Quraysh',
        numberOfAyahs: 4,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 107,
        nameArabic: 'الماعون',
        nameEnglish: 'The Small Kindnesses',
        transliteration: 'Al-Ma\'un',
        numberOfAyahs: 7,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 108,
        nameArabic: 'الكوثر',
        nameEnglish: 'The Abundance',
        transliteration: 'Al-Kawthar',
        numberOfAyahs: 3,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 109,
        nameArabic: 'الكافرون',
        nameEnglish: 'The Disbelievers',
        transliteration: 'Al-Kafirun',
        numberOfAyahs: 6,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 110,
        nameArabic: 'النصر',
        nameEnglish: 'The Divine Support',
        transliteration: 'An-Nasr',
        numberOfAyahs: 3,
        juzNumber: 30,
        revelationType: 'Medinan',
      ),
      const Surah(
        number: 111,
        nameArabic: 'المسد',
        nameEnglish: 'The Palm Fiber',
        transliteration: 'Al-Masad',
        numberOfAyahs: 5,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 112,
        nameArabic: 'الإخلاص',
        nameEnglish: 'The Sincerity',
        transliteration: 'Al-Ikhlas',
        numberOfAyahs: 4,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 113,
        nameArabic: 'الفلق',
        nameEnglish: 'The Daybreak',
        transliteration: 'Al-Falaq',
        numberOfAyahs: 5,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
      const Surah(
        number: 114,
        nameArabic: 'الناس',
        nameEnglish: 'Mankind',
        transliteration: 'An-Nas',
        numberOfAyahs: 6,
        juzNumber: 30,
        revelationType: 'Meccan',
      ),
    ];
  }

  /// Returns surahs for a specific Juz
  static List<Surah> getSurahsByJuz(int juzNumber) {
    switch (juzNumber) {
      case 28:
        return getJuz28Surahs();
      case 29:
        return getJuz29Surahs();
      case 30:
        return getJuz30Surahs();
      default:
        return [];
    }
  }

  /// Returns all available Juz' numbers (that we have data for)
  static List<int> getAvailableJuzNumbers() {
    return [28, 29, 30];
  }

  /// Returns all 30 Juz' (for future expansion)
  static List<int> getAllJuzNumbers() {
    return List.generate(30, (index) => index + 1);
  }

  /// Get Surah name for a specific Juz and quarter
  /// Each Juz has 4 quarters (rub'), and each quarter corresponds to specific Surahs
  static String getSurahNameForJuzQuarter(int juzNumber, int quarterNumber) {
    // This is a simplified mapping - in reality, quarters don't always align perfectly with Surah boundaries
    // But we'll provide approximate Surah names for each quarter
    
    switch (juzNumber) {
      case 1:
        switch (quarterNumber) {
          case 1: return 'البقرة (1-71)';
          case 2: return 'البقرة (72-142)';
          case 3: return 'البقرة (143-213)';
          case 4: return 'البقرة (214-286)';
        }
        break;
      case 2:
        switch (quarterNumber) {
          case 1: return 'البقرة (1-71)';
          case 2: return 'البقرة (72-142)';
          case 3: return 'البقرة (143-213)';
          case 4: return 'البقرة (214-286)';
        }
        break;
      case 3:
        switch (quarterNumber) {
          case 1: return 'البقرة (1-71)';
          case 2: return 'البقرة (72-142)';
          case 3: return 'البقرة (143-213)';
          case 4: return 'البقرة (214-286)';
        }
        break;
      case 4:
        switch (quarterNumber) {
          case 1: return 'آل عمران (1-71)';
          case 2: return 'آل عمران (72-142)';
          case 3: return 'آل عمران (143-213)';
          case 4: return 'آل عمران (214-286)';
        }
        break;
      case 5:
        switch (quarterNumber) {
          case 1: return 'النساء (1-71)';
          case 2: return 'النساء (72-142)';
          case 3: return 'النساء (143-213)';
          case 4: return 'النساء (214-286)';
        }
        break;
      case 6:
        switch (quarterNumber) {
          case 1: return 'النساء (1-71)';
          case 2: return 'النساء (72-142)';
          case 3: return 'النساء (143-213)';
          case 4: return 'النساء (214-286)';
        }
        break;
      case 7:
        switch (quarterNumber) {
          case 1: return 'المائدة (1-71)';
          case 2: return 'المائدة (72-142)';
          case 3: return 'المائدة (143-213)';
          case 4: return 'المائدة (214-286)';
        }
        break;
      case 8:
        switch (quarterNumber) {
          case 1: return 'الأنعام (1-71)';
          case 2: return 'الأنعام (72-142)';
          case 3: return 'الأنعام (143-213)';
          case 4: return 'الأنعام (214-286)';
        }
        break;
      case 9:
        switch (quarterNumber) {
          case 1: return 'الأعراف (1-71)';
          case 2: return 'الأعراف (72-142)';
          case 3: return 'الأعراف (143-213)';
          case 4: return 'الأعراف (214-286)';
        }
        break;
      case 10:
        switch (quarterNumber) {
          case 1: return 'الأنفال (1-71)';
          case 2: return 'الأنفال (72-142)';
          case 3: return 'الأنفال (143-213)';
          case 4: return 'الأنفال (214-286)';
        }
        break;
      case 11:
        switch (quarterNumber) {
          case 1: return 'التوبة (1-71)';
          case 2: return 'التوبة (72-142)';
          case 3: return 'التوبة (143-213)';
          case 4: return 'التوبة (214-286)';
        }
        break;
      case 12:
        switch (quarterNumber) {
          case 1: return 'هود (1-71)';
          case 2: return 'هود (72-142)';
          case 3: return 'هود (143-213)';
          case 4: return 'هود (214-286)';
        }
        break;
      case 13:
        switch (quarterNumber) {
          case 1: return 'يوسف (1-71)';
          case 2: return 'يوسف (72-142)';
          case 3: return 'يوسف (143-213)';
          case 4: return 'يوسف (214-286)';
        }
        break;
      case 14:
        switch (quarterNumber) {
          case 1: return 'الحجر (1-71)';
          case 2: return 'الحجر (72-142)';
          case 3: return 'الحجر (143-213)';
          case 4: return 'الحجر (214-286)';
        }
        break;
      case 15:
        switch (quarterNumber) {
          case 1: return 'الإسراء (1-71)';
          case 2: return 'الإسراء (72-142)';
          case 3: return 'الإسراء (143-213)';
          case 4: return 'الإسراء (214-286)';
        }
        break;
      case 16:
        switch (quarterNumber) {
          case 1: return 'الكهف (1-71)';
          case 2: return 'الكهف (72-142)';
          case 3: return 'الكهف (143-213)';
          case 4: return 'الكهف (214-286)';
        }
        break;
      case 17:
        switch (quarterNumber) {
          case 1: return 'الأنبياء (1-71)';
          case 2: return 'الأنبياء (72-142)';
          case 3: return 'الأنبياء (143-213)';
          case 4: return 'الأنبياء (214-286)';
        }
        break;
      case 18:
        switch (quarterNumber) {
          case 1: return 'المؤمنون (1-71)';
          case 2: return 'المؤمنون (72-142)';
          case 3: return 'المؤمنون (143-213)';
          case 4: return 'المؤمنون (214-286)';
        }
        break;
      case 19:
        switch (quarterNumber) {
          case 1: return 'الفرقان (1-71)';
          case 2: return 'الفرقان (72-142)';
          case 3: return 'الفرقان (143-213)';
          case 4: return 'الفرقان (214-286)';
        }
        break;
      case 20:
        switch (quarterNumber) {
          case 1: return 'النمل (1-71)';
          case 2: return 'النمل (72-142)';
          case 3: return 'النمل (143-213)';
          case 4: return 'النمل (214-286)';
        }
        break;
      case 21:
        switch (quarterNumber) {
          case 1: return 'العنكبوت (1-71)';
          case 2: return 'العنكبوت (72-142)';
          case 3: return 'العنكبوت (143-213)';
          case 4: return 'العنكبوت (214-286)';
        }
        break;
      case 22:
        switch (quarterNumber) {
          case 1: return 'الأحزاب (1-71)';
          case 2: return 'الأحزاب (72-142)';
          case 3: return 'الأحزاب (143-213)';
          case 4: return 'الأحزاب (214-286)';
        }
        break;
      case 23:
        switch (quarterNumber) {
          case 1: return 'يس (1-71)';
          case 2: return 'يس (72-142)';
          case 3: return 'يس (143-213)';
          case 4: return 'يس (214-286)';
        }
        break;
      case 24:
        switch (quarterNumber) {
          case 1: return 'الزمر (1-71)';
          case 2: return 'الزمر (72-142)';
          case 3: return 'الزمر (143-213)';
          case 4: return 'الزمر (214-286)';
        }
        break;
      case 25:
        switch (quarterNumber) {
          case 1: return 'فصلت (1-71)';
          case 2: return 'فصلت (72-142)';
          case 3: return 'فصلت (143-213)';
          case 4: return 'فصلت (214-286)';
        }
        break;
      case 26:
        switch (quarterNumber) {
          case 1: return 'الأحقاف (1-71)';
          case 2: return 'الأحقاف (72-142)';
          case 3: return 'الأحقاف (143-213)';
          case 4: return 'الأحقاف (214-286)';
        }
        break;
      case 27:
        switch (quarterNumber) {
          case 1: return 'الذاريات (1-71)';
          case 2: return 'الذاريات (72-142)';
          case 3: return 'الذاريات (143-213)';
          case 4: return 'الذاريات (214-286)';
        }
        break;
      case 28:
        switch (quarterNumber) {
          case 1: return 'المجادلة (1-71)';
          case 2: return 'المجادلة (72-142)';
          case 3: return 'المجادلة (143-213)';
          case 4: return 'المجادلة (214-286)';
        }
        break;
      case 29:
        switch (quarterNumber) {
          case 1: return 'الملك (1-71)';
          case 2: return 'الملك (72-142)';
          case 3: return 'الملك (143-213)';
          case 4: return 'الملك (214-286)';
        }
        break;
      case 30:
        switch (quarterNumber) {
          case 1: return 'النبأ (1-71)';
          case 2: return 'النبأ (72-142)';
          case 3: return 'النبأ (143-213)';
          case 4: return 'النبأ (214-286)';
        }
        break;
    }
    
    return 'سورة غير محددة';
  }

  /// Get Juz name
  static String getJuzName(int juzNumber) {
    switch (juzNumber) {
      case 29:
        return 'Tabarak';
      case 30:
        return 'Amma';
      default:
        return 'Juz\' $juzNumber';
    }
  }
}

