import 'dart:ui';

import 'package:flutter/material.dart';
import '../app/services/app_color_service.dart';
import '../enums/app_elements.dart';

enum AppColorSchemes { standard, dark }

extension MainColorSchemeInfoExtension on AppColorSchemes {
  Color get mainColor {
    switch (this) {
      case AppColorSchemes.standard:
        return Colors.teal[800];
      case AppColorSchemes.dark:
        return Colors.white12;
      default:
        return null;
    }
  }

  String get name {
    switch (this) {
      case AppColorSchemes.standard:
        return 'Standard mode';
      case AppColorSchemes.dark:
        return 'Dark mode';
      default:
        return null;
    }
  }
}

extension AppElementsExtension on AppElements {
  Color color({AppColorSchemes colorScheme}) {
    switch (colorScheme ?? AppColorService.currentAppColorScheme) {
      case AppColorSchemes.standard:
        {
          switch (this) {
            case AppElements.background:
              return Colors.white;
            case AppElements.basicText:
              return Colors.white;
            case AppElements.bottomNavigationBar:
            case AppElements.appbar:
            case AppElements.button:
            case AppElements.textFieldEnabled:
              return AppColorSchemes.standard.mainColor;
            case AppElements.bottomNavigationBarItem:
              return Colors.white;
            case AppElements.appbarButton:
            case AppElements.simpleCard:
              return Colors.teal[300];
            case AppElements.textFieldDisabled:
              return Colors.grey[400];
            default:
              return AppColorSchemes.standard.mainColor;
          }
        }
        break;
      case AppColorSchemes.dark:
        {
          switch (this) {
            case AppElements.background:
              return Colors.grey[900];
            case AppElements.basicText:
              return Colors.white;
            case AppElements.bottomNavigationBar:
            case AppElements.appbar:
            case AppElements.button:
            case AppElements.appbarButton:
            case AppElements.simpleCard:
              return Colors.grey[800];
            case AppElements.textFieldEnabled:
            case AppElements.bottomNavigationBarItem:
              return Colors.white;
            case AppElements.textFieldDisabled:
              return Colors.blue;
            default:
              return AppColorSchemes.dark.mainColor;
          }
        }
        break;
      default:
        return null;
    }
  }
}
