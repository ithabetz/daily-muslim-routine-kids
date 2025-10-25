import 'package:flutter/material.dart';

/// Kid-friendly theme colors and styling for the Muslim routine app
class KidTheme {
  // Bright, cheerful colors for kids
  static const Color primaryBlue = Color(0xFF4A90E2);
  static const Color primaryGreen = Color(0xFF7ED321);
  static const Color primaryOrange = Color(0xFFFF9500);
  static const Color primaryPink = Color(0xFFFF6B9D);
  static const Color primaryPurple = Color(0xFF9013FE);
  static const Color primaryYellow = Color(0xFFFFD700);
  
  // Background colors
  static const Color lightBlueBg = Colors.white;
  static const Color lightGreenBg = Color(0xFFE8F5E8);
  static const Color lightOrangeBg = Color(0xFFFFF3E0);
  static const Color lightPinkBg = Color(0xFFFFF0F5);
  static const Color lightPurpleBg = Color(0xFFF3E5F5);
  static const Color lightYellowBg = Color(0xFFFFFDE7);
  
  // Text colors
  static const Color darkBlue = Color(0xFF1565C0);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color darkOrange = Color(0xFFE65100);
  static const Color darkPink = Color(0xFFC2185B);
  static const Color darkPurple = Color(0xFF4A148C);
  
  // Success and completion colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color errorRed = Color(0xFFE53E3E);
  
  // Shadow colors
  static const Color lightShadow = Color(0x1A000000);
  static const Color mediumShadow = Color(0x33000000);
  
  /// Get kid-friendly theme data
  static ThemeData get kidTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        brightness: Brightness.light,
        primary: primaryBlue,
        secondary: primaryGreen,
        tertiary: primaryOrange,
        surface: Colors.white,
        background: Colors.white,
        error: errorRed,
      ),
      useMaterial3: true,
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        shadowColor: mediumShadow,
      ),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryBlue,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Icon Button Theme
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: primaryBlue,
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      
      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryGreen;
          }
          return Colors.grey.shade300;
        }),
        checkColor: MaterialStateProperty.all(Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        side: BorderSide(
          color: Colors.grey.shade400,
          width: 2,
        ),
      ),
      
      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryBlue,
        linearTrackColor: lightBlueBg,
        circularTrackColor: lightBlueBg,
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryOrange,
        foregroundColor: Colors.white,
        elevation: 8,
        shape: CircleBorder(),
      ),
      
      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: darkBlue,
        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 6,
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: darkBlue,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: darkBlue,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: darkBlue,
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: darkBlue,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: darkBlue,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: darkBlue,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: darkBlue,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: darkBlue,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: darkBlue,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black87,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black87,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.black54,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }
  
  /// Get gradient decorations for different sections
  static BoxDecoration get prayerGradient => BoxDecoration(
    gradient: const LinearGradient(
      colors: [Colors.white, Colors.white],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
  
  static BoxDecoration get quranGradient => BoxDecoration(
    gradient: const LinearGradient(
      colors: [lightGreenBg, Colors.white],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
  
  static BoxDecoration get azkarGradient => BoxDecoration(
    gradient: const LinearGradient(
      colors: [lightOrangeBg, Colors.white],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
  
  /// Get card decorations with different colors
  static BoxDecoration getCardDecoration(Color color, {bool isCompleted = false}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [
          color.withOpacity(isCompleted ? 0.15 : 0.08),
          color.withOpacity(isCompleted ? 0.08 : 0.04),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(
        color: color.withOpacity(isCompleted ? 0.3 : 0.2),
        width: 2,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
  
  /// Get section header decoration
  static BoxDecoration getSectionHeaderDecoration(Color color) {
    return BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withOpacity(0.2)),
    );
  }
  
  /// Get celebration animation colors
  static List<Color> get celebrationColors => [
    primaryYellow,
    primaryOrange,
    primaryPink,
    primaryPurple,
    primaryBlue,
    primaryGreen,
  ];

  // Standardized card dimensions and colors for prayer page
  static const double standardCardHeight = 140.0;
  static const double standardCardPadding = 16.0;
  static const double standardCardBorderRadius = 16.0;
  static const double standardIconSize = 28.0;
  static const double standardIconPadding = 12.0;
  
  // Base color for all prayer elements (white)
  static const Color basePrayerColor = Colors.white;
  static const Color basePrayerBorderColor = Color(0xFFBBDEFB);
  
  // Highlight color for completed elements (green)
  static const Color highlightPrayerColor = Color(0xFFE8F5E8);
  static const Color highlightPrayerBorderColor = Color(0xFFC8E6C9);
  
  /// Get standardized card decoration for prayer elements
  static BoxDecoration getStandardCardDecoration({bool isCompleted = false}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(standardCardBorderRadius),
      color: Colors.white,
      border: Border.all(
        color: isCompleted ? highlightPrayerBorderColor : Colors.grey.shade300,
        width: 1,
      ),
    );
  }
  
  /// Get standardized icon decoration for prayer elements
  static BoxDecoration getStandardIconDecoration({bool isCompleted = false}) {
    return BoxDecoration(
      color: isCompleted ? successGreen : Colors.grey.shade400,
      borderRadius: BorderRadius.circular(12),
    );
  }
  
  /// Get standardized points indicator decoration
  static BoxDecoration getStandardPointsDecoration({bool isCompleted = false}) {
    return BoxDecoration(
      color: isCompleted ? successGreen : Colors.grey.shade400,
      borderRadius: BorderRadius.circular(16),
    );
  }
}
