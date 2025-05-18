import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../style/app_color_scheme.dart';

class AppColorService extends ChangeNotifier {
  // Future<bool> _loaded = false as Future<bool>;
  //
  // Future<bool> get loaded => _loaded;

  late FlutterSecureStorage _secureStorage;

  static AppColorScheme currentColorScheme = AppColorScheme.teal;

  // AppColorService() {
  //   _initSharedPreferences();
  // }

  Future<bool> initSharedPreferences() async {
    _secureStorage = const FlutterSecureStorage();
    currentColorScheme = await _loadAppColorScheme();
    //notifyListeners();
    return Future.value(true);
  }

  Future<AppColorScheme> _loadAppColorScheme() async {
    AppColorScheme result;
    String? currentAppColorSchemeName = await _secureStorage.read(key: 'currentAppColorScheme');

    result = currentAppColorSchemeName != null && currentAppColorSchemeName.isNotEmpty
        ? getAppColorSchemeByName(currentAppColorSchemeName)
        : AppColorScheme.teal;

    //_loaded = true as Future<bool>;
    return result;
  }

  AppColorScheme get currentAppColorScheme => currentColorScheme;

  set currentAppColorScheme(AppColorScheme scheme) {
    _secureStorage.write(key: 'currentAppColorScheme', value: scheme.name);
    currentColorScheme = scheme;
    notifyListeners();
  }
}
