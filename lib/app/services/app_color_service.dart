import 'package:flutter/cupertino.dart';
import '../../style/app_color_scheme.dart';

class AppColorService extends ChangeNotifier {
  static var currentAppColorScheme = AppColorSchemes.standard;

  get currentColorScheme => currentAppColorScheme;

  set currentColorScheme(AppColorSchemes scheme) {
    currentAppColorScheme = scheme;
    notifyListeners();
  }
}
