/// Utility class to format numbers to always use English/Western numerals (0-9)
/// even when the app is in Arabic locale
class NumberFormatter {
  /// Converts Arabic-Indic numerals to English numerals
  static String toEnglishNumbers(String input) {
    const arabicNumerals = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const englishNumerals = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    
    String result = input;
    for (int i = 0; i < arabicNumerals.length; i++) {
      result = result.replaceAll(arabicNumerals[i], englishNumerals[i]);
    }
    return result;
  }

  /// Formats a number to string using English numerals
  static String format(num number) {
    return toEnglishNumbers(number.toString());
  }

  /// Formats a double with specified decimal places using English numerals
  static String formatDecimal(double number, {int decimalPlaces = 1}) {
    return toEnglishNumbers(number.toStringAsFixed(decimalPlaces));
  }

  /// Formats an integer using English numerals
  static String formatInt(int number) {
    return toEnglishNumbers(number.toString());
  }

  /// Pads a number with leading zeros using English numerals
  static String padLeft(int number, int width, [String padding = '0']) {
    return toEnglishNumbers(number.toString().padLeft(width, padding));
  }
}

