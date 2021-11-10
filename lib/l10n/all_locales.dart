import "package:flutter/material.dart";

class AllLocales{
  AllLocales();

  static final all = {
    "en": const Locale("en", "US"),
    "ru" : const Locale("ru", "RU"),
  };

  static final names = {
    "en": "English",
    "ru" : "Русский",
  };
}