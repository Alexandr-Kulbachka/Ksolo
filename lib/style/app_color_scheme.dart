import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import '../app/services/app_color_service.dart';

enum AppElements {
  appbar,
  appbarText,
  bottomNavigationBar,
  bottomNavigationBarItem,
  basicText,
  textOnBackground,
  textFieldEnabled,
  textFieldDisabled,
  simpleCard,
  enabledButton,
  disabledButton,
  disabledBorderColor,
  background,
  gradientBackgroundStart,
  gradientBackgroundEnd,
  border,
  appbarButton,
  cursor,
  selectionHandle,
  selection
}

enum AppColorScheme { teal, purple }

extension MainColorSchemeInfoExtension on AppColorScheme {
  Color get mainColor {
    switch (this) {
      case AppColorScheme.teal:
        return const Color(0xff00685b);
      case AppColorScheme.purple:
        return const Color(0xff502a9e);
      default:
        return Colors.white;
    }
  }

  String get name {
    switch (this) {
      case AppColorScheme.teal:
        return 'Teal mode';
      case AppColorScheme.purple:
        return 'Purple mode';
      default:
        return '';
    }
  }

  String? nameLabel(BuildContext context) {
    switch (this) {
      case AppColorScheme.teal:
        return AppLocalizations.of(context)?.teal;
      case AppColorScheme.purple:
        return AppLocalizations.of(context)?.purple;
      default:
        return '';
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
      return AppColorScheme.teal;
  }
}

extension AppElementsExtension on AppElements {
  Color color({AppColorScheme? colorScheme}) {
    switch (colorScheme ?? AppColorService.currentColorScheme) {
      case AppColorScheme.teal:
        {
          switch (this) {
            case AppElements.background:
            case AppElements.appbarText:
            case AppElements.basicText:
            case AppElements.bottomNavigationBarItem:
              return Colors.white;
            case AppElements.gradientBackgroundStart:
            case AppElements.textOnBackground:
            case AppElements.bottomNavigationBar:
            case AppElements.appbar:
            case AppElements.enabledButton:
            case AppElements.textFieldEnabled:
            case AppElements.cursor:
            case AppElements.selectionHandle:
              return const Color(0xff00685b);
            case AppElements.gradientBackgroundEnd:
            case AppElements.appbarButton:
            case AppElements.simpleCard:
              return const Color(0xff4cb5ab);
            case AppElements.selection:
              return const Color(0xffa7d1cc);
            case AppElements.disabledButton:
            case AppElements.disabledBorderColor:
            case AppElements.textFieldDisabled:
              return const Color(0xffbcbcbc);
            default:
              return AppColorScheme.teal.mainColor;
          }
        }
      case AppColorScheme.purple:
        {
          switch (this) {
            case AppElements.background:
              return const Color(0xff21244a);
            case AppElements.appbarText:
            case AppElements.basicText:
            case AppElements.textOnBackground:
            case AppElements.textFieldEnabled:
            case AppElements.bottomNavigationBarItem:
            case AppElements.cursor:
            case AppElements.selectionHandle:
              return Colors.white;
            case AppElements.appbarButton:
            case AppElements.gradientBackgroundStart:
              return const Color(0xff21244a);
            case AppElements.disabledButton:
            case AppElements.textFieldDisabled:
              return const Color(0xff502a9e);
            case AppElements.appbar:
            case AppElements.bottomNavigationBar:
              return const Color(0xff2b2a65);
            case AppElements.gradientBackgroundEnd:
              return const Color(0xff623dd5);
            case AppElements.enabledButton:
            case AppElements.simpleCard:
            case AppElements.selection:
              return const Color(0xff5f3ed6);
            case AppElements.disabledBorderColor:
              return const Color(0xffbcbcbc);
            default:
              return AppColorScheme.purple.mainColor;
          }
        }
      default:
        return AppColorScheme.purple.mainColor;
    }
  }
}

Brightness getCurrentAppBarBrightness({AppColorScheme? colorScheme}) {
  switch (colorScheme ?? AppColorService.currentColorScheme) {
    case AppColorScheme.teal:
    case AppColorScheme.purple:
      return Brightness.dark;
    default:
      return Brightness.dark;
  }
}
