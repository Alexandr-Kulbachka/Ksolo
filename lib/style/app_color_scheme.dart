import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:list_manager/app/services/app_color_service.dart';
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
        return 'Standard scheme';
      case AppColorSchemes.dark:
        return 'Dark scheme';
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
            case AppElements.appBar:
            case AppElements.button:
              return AppColorSchemes.standard.mainColor;
            case AppElements.bottomNavigationBarItem:
              return Colors.white;
            case AppElements.simpleCard:
              return Colors.teal[300];
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
            case AppElements.appBar:
            case AppElements.button:
            case AppElements.simpleCard:
              return Colors.grey[800];
            case AppElements.bottomNavigationBarItem:
              return Colors.white;
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
