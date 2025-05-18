import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../l10n/all_locales.dart';

class LocaleService extends ChangeNotifier {
  // Future<bool> _loaded = false as Future<bool>;
  //
  // Future<bool> get loaded => _loaded;

  late FlutterSecureStorage _secureStorage;

  static Locale currentLocale = AppLocales.getLocale('en');

  // LocaleService() {
  //   _initLocale();
  // }

  Future<bool> initLocale() async {
    _secureStorage = const FlutterSecureStorage();
    currentLocale = (await _loadLocale())!;
    //notifyListeners();
    return Future.value(true);
  }

  Future<Locale?> _loadLocale() async {
    Locale? result;
    String? currentLocaleName = await _secureStorage.read(key: 'currentLocale');

    result = currentLocaleName != null && currentLocaleName.isNotEmpty
        ? AppLocales.getLocale(currentLocaleName)
        : AppLocales.getLocale('en');

    //_loaded = true as Future<bool>;
    return result;
  }

  Locale get currentAppLocale => currentLocale;

  set currentAppLocale(Locale locale) {
    _secureStorage.write(key: 'currentLocale', value: locale.languageCode);
    currentLocale = locale;
    notifyListeners();
  }
}
