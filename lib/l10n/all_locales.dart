import "package:flutter/material.dart";

class AppLocales {
  AppLocales();

  static Locale getLocale(String localeName) {
    return allLocales[localeName] ?? const Locale("en", "US");
  }

  static final allLocales = {
    "en": const Locale("en", "US"),
    "ru": const Locale("ru", "RU"),
  };

  static final names = {
    "en": "English",
    "ru": "Русский",
  };
}
