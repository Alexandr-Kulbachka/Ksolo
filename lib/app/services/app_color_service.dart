import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../style/app_color_scheme.dart';

class AppColorService extends ChangeNotifier {
  static AppColorScheme currentAppColorScheme;
  SharedPreferences _sharedPreferences;

  AppColorService() {
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    currentAppColorScheme = _loadAppColorScheme();
    notifyListeners();
  }

  AppColorScheme _loadAppColorScheme() {
    String currentAppColorSchemeName = _sharedPreferences.getString('currentAppColorScheme');
    if (currentAppColorSchemeName != null) {
      return getAppColorSchemeByName(currentAppColorSchemeName);
    } else {
      return AppColorScheme.teal;
    }
  }

  AppColorScheme get currentColorScheme {
    if (currentAppColorScheme != null) {
      return currentAppColorScheme;
    } else {
      return _loadAppColorScheme();
    }
  }

  set currentColorScheme(AppColorScheme scheme) {
    _sharedPreferences.setString('currentAppColorScheme', scheme.name);
    currentAppColorScheme = scheme;
    notifyListeners();
  }
}
