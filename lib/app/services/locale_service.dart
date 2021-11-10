import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../l10n/all_locales.dart';

class LocaleService extends ChangeNotifier {
  static Locale _currentLocale;
  SharedPreferences _sharedPreferences;

  LocaleService() {
    _initLocale();
  }

  void _initLocale() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    currentLocale = _loadLocale();
    notifyListeners();
  }

  Locale _loadLocale() {
    String currentLocaleName = _sharedPreferences.getString('currentLocale');
    if (currentLocaleName != null && currentLocaleName.isNotEmpty) {
      return AllLocales.all[currentLocaleName];
    } else {
      return AllLocales.all['en'];
    }
  }

  Locale get currentLocale {
    if (_currentLocale != null) {
      return _currentLocale;
    } else if (_sharedPreferences != null) {
      return _loadLocale();
    }
    return null;
  }

  set currentLocale(Locale locale) {
    _sharedPreferences.setString('currentLocale', locale.languageCode);
    _currentLocale = locale;
    notifyListeners();
  }
}
