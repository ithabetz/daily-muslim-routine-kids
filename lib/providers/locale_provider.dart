import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('ar');
  static const String _localeKey = 'app_locale';

  Locale get locale => _locale;

  LocaleProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localeCode = prefs.getString(_localeKey);
      
      if (localeCode != null) {
        _locale = Locale(localeCode);
      } else {
        // Default to Arabic if no saved locale
        _locale = const Locale('ar');
        // Save the default locale
        await prefs.setString(_localeKey, 'ar');
      }
      notifyListeners();
    } catch (e) {
      // Failed to load locale
      // Fallback to Arabic on error
      _locale = const Locale('ar');
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    
    _locale = locale;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
    } catch (e) {
      // Failed to save locale
    }
  }

  bool get isArabic => _locale.languageCode == 'ar';
}

