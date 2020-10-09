import 'dart:ui';

import 'package:flutter/material.dart';

enum AppColorSchemes { standard, dark }

var currentAppColorScheme = AppColorSchemes.dark;

enum AppElementsColors { appBar }

extension AppElementsExtension on AppElementsColors {
  Color get color {
    Color result;
    switch (this) {
      case AppElementsColors.appBar:
        {
          switch (currentAppColorScheme) {
            case AppColorSchemes.dark:
              {
                result = Colors.blueGrey;
              }
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
