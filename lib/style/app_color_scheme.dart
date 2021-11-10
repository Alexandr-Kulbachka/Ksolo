import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

enum AppColorScheme { teal, purple }

extension MainColorSchemeInfoExtension on AppColorScheme {
  Color get mainColor {
    switch (this) {
      case AppColorScheme.teal:
        return Colors.teal[800];
      case AppColorScheme.purple:
        return Color(0xff502a9e);
      default:
        return null;
    }
  }

  String get name {
    switch (this) {
      case AppColorScheme.teal:
        return 'Teal mode';
      case AppColorScheme.purple:
        return 'Purple mode';
      default:
        return null;
    }
  }

  String nameLabel(BuildContext context) {
    switch (this) {
      case AppColorScheme.teal:
        return AppLocalizations.of(context).teal;
      case AppColorScheme.purple:
        return AppLocalizations.of(context).purple;
      default:
        return null;
    }
  }
}

AppColorScheme getAppColorSchemeByName(String appColorSchemeName) {
  switch (appColorSchemeName) {
    case 'Teal mode':
      return AppColorScheme.teal;
    case 'Purple mode':
      return AppColorScheme.purple;
    default:
      return null;
  }
}

extension AppElementsExtension on AppElements {
  Color color({AppColorScheme colorScheme}) {
    switch (colorScheme ?? AppColorService.currentAppColorScheme) {
      case AppColorScheme.teal:
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
              return Colors.teal[800];
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
              return AppColorScheme.teal.mainColor;
          }
        }
        break;
      case AppColorScheme.purple:
        {
          switch (this) {
            case AppElements.background:
              return Color(0xff21244a);
            case AppElements.basicText:
            case AppElements.textOnBackground:
              return Colors.white;
            case AppElements.appbarButton:
            case AppElements.gradientBackgroundStart:
              return Color(0xff21244a);
            case AppElements.disabledButton:
            case AppElements.textFieldDisabled:
              return Color(0xff502a9e);
            case AppElements.appbar:
            case AppElements.bottomNavigationBar:
              return Color(0xff2b2a65);
            case AppElements.gradientBackgroundEnd:
              return Color(0xff623dd5);
            case AppElements.enabledButton:
            case AppElements.simpleCard:
              return Color(0xff5f3ed6);
            case AppElements.textFieldEnabled:
            case AppElements.bottomNavigationBarItem:
              return Colors.white;
            default:
              return AppColorScheme.purple.mainColor;
          }
        }
        break;
      default:
        return null;
    }
  }
}

Brightness getCurrentAppBarBrightness({AppColorScheme colorScheme}) {
  switch (colorScheme ?? AppColorService.currentAppColorScheme) {
    case AppColorScheme.teal:
    case AppColorScheme.purple:
      return Brightness.dark;
    default:
      return Brightness.dark;
  }
}
