import 'dart:ui';

import 'package:flutter/material.dart';
import '../app/services/app_color_service.dart';

enum AppElements {
  appbar,
  bottomNavigationBar,
  bottomNavigationBarItem,
  basicText,
  textOnBackground,
  textFieldEnabled,
  textFieldDisabled,
  simpleCard,
  enabledButton,
  disabledButton,
  background,
  gradientBackgroundStart,
  gradientBackgroundEnd,
  border,
  appbarButton
}

enum AppColorScheme { standard, dark }

extension MainColorSchemeInfoExtension on AppColorScheme {
  Color get mainColor {
    switch (this) {
      case AppColorScheme.standard:
        return Colors.teal[800];
      case AppColorScheme.dark:
        return Colors.white12;
      default:
        return null;
    }
  }

  String get name {
    switch (this) {
      case AppColorScheme.standard:
        return 'Standard mode';
      case AppColorScheme.dark:
        return 'Dark mode';
      default:
        return null;
    }
  }
}

AppColorScheme getAppColorSchemeByName(String appColorSchemeName) {
  switch (appColorSchemeName) {
    case 'Standard mode':
      return AppColorScheme.standard;
    case 'Dark mode':
      return AppColorScheme.dark;
    default:
      return null;
  }
}

extension AppElementsExtension on AppElements {
  Color color({AppColorScheme colorScheme}) {
    switch (colorScheme ?? AppColorService.currentAppColorScheme) {
      case AppColorScheme.standard:
        {
          switch (this) {
            case AppElements.background:
              return Colors.white;
            case AppElements.basicText:
              return Colors.white;
            case AppElements.gradientBackgroundStart:
            case AppElements.textOnBackground:
            case AppElements.bottomNavigationBar:
            case AppElements.appbar:
            case AppElements.enabledButton:
            case AppElements.textFieldEnabled:
              return AppColorScheme.standard.mainColor;
            case AppElements.bottomNavigationBarItem:
              return Colors.white;
            case AppElements.gradientBackgroundEnd:
            case AppElements.appbarButton:
            case AppElements.simpleCard:
              return Colors.teal[300];
            case AppElements.disabledButton:
            case AppElements.textFieldDisabled:
              return Colors.grey[400];
            default:
              return AppColorScheme.standard.mainColor;
          }
        }
        break;
      case AppColorScheme.dark:
        {
          switch (this) {
            case AppElements.background:
              return Colors.grey[900];
            case AppElements.basicText:
            case AppElements.textOnBackground:
              return Colors.white;
            case AppElements.bottomNavigationBar:
            case AppElements.appbar:
            case AppElements.enabledButton:
            case AppElements.appbarButton:
            case AppElements.simpleCard:
            case AppElements.textFieldDisabled:
            case AppElements.gradientBackgroundStart:
              return Colors.grey[800];
            case AppElements.gradientBackgroundEnd:
              return Colors.grey[400];
            case AppElements.enabledButton:
              return Colors.grey[400];
            case AppElements.textFieldEnabled:
            case AppElements.bottomNavigationBarItem:
              return Colors.white;
            default:
              return AppColorScheme.dark.mainColor;
          }
        }
        break;
      default:
        return null;
    }
  }
}
