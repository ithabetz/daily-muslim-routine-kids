import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'number_formatter.dart';

class DateFormatter {
  /// Formats a date using the appropriate locale and format
  static String formatDate(DateTime date, String formatPattern, BuildContext context) {
    final locale = Localizations.localeOf(context);
    
    // Use the system's locale for date formatting but force English numerals
    final formatter = DateFormat(formatPattern, locale.toString());
    String formattedDate = formatter.format(date);
    
    // Convert Arabic-Indic numerals to English numerals
    return NumberFormatter.toEnglishNumbers(formattedDate);
  }

  /// Formats a date with a predefined format pattern from localization
  static String formatDateWithPattern(DateTime date, String patternKey, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    
    // Get the format pattern from localization
    String formatPattern;
    switch (patternKey) {
      case 'dateFormat':
        formatPattern = l10n.dateFormat;
        break;
      case 'detailedDateFormat':
        formatPattern = l10n.detailedDateFormat;
        break;
      case 'shortDateFormat':
        formatPattern = l10n.shortDateFormat;
        break;
      default:
        formatPattern = 'EEEE, MMM d'; // Default fallback
    }
    
    final formatter = DateFormat(formatPattern, locale.toString());
    String formattedDate = formatter.format(date);
    
    // Convert Arabic-Indic numerals to English numerals
    return NumberFormatter.toEnglishNumbers(formattedDate);
  }

  /// Formats a date for display in history cards
  static String formatHistoryDate(DateTime date, BuildContext context) {
    return formatDateWithPattern(date, 'dateFormat', context);
  }

  /// Formats a date for detailed views
  static String formatDetailedDate(DateTime date, BuildContext context) {
    return formatDateWithPattern(date, 'detailedDateFormat', context);
  }

  /// Formats a date for short display
  static String formatShortDate(DateTime date, BuildContext context) {
    return formatDateWithPattern(date, 'shortDateFormat', context);
  }

  /// Formats a date for month/year display
  static String formatMonthYear(DateTime date, BuildContext context) {
    final locale = Localizations.localeOf(context);
    final formatter = DateFormat('MMMM yyyy', locale.toString());
    String formattedDate = formatter.format(date);
    
    // Convert Arabic-Indic numerals to English numerals
    return NumberFormatter.toEnglishNumbers(formattedDate);
  }
}
