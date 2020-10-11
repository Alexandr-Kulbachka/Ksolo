import 'dart:ui';

import 'package:flutter/material.dart';
import '../enums/app_elements.dart';

enum AppColorSchemes { standard, dark }

var currentAppColorScheme = AppColorSchemes.standard;

extension AppElementsExtension on AppElements {
  Color get color {
    Color result;
    switch (currentAppColorScheme) {
      case AppColorSchemes.standard:
        {
          switch (this) {
            case AppElements.bottomNavigationBar:
            case AppElements.appBar:
              result = Colors.teal[800];
              break;
            case AppElements.bottomNavigationBarItem:
              result = Colors.white;
              break;
            default:
              result = Colors.teal[800];
              break;
          }
          return result;
        }
        break;
      case AppColorSchemes.dark:
        {
          switch (this) {
            case AppElements.bottomNavigationBar:
            case AppElements.appBar:
              result = Colors.blueGrey;
              break;
            default:
              result = Colors.green;
              break;
          }
          return result;
        }
        break;
      default:
        return null;
    }
  }
}
