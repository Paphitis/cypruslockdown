import 'dart:convert';

import 'package:flutter/services.dart';

enum Language {
  greek,
  english,
}

class Localise {
  static Map<String, dynamic> strings;
  static Language language;

  static setLang(Language lang) async {
    language = lang;
    print("Setting lan-> ${lang.toString()}");
    switch (lang) {
      case Language.greek:
        rootBundle.loadString("assets/Greek.json").then((values) {
          strings = json.decode(values.toString());
        });
        break;
      case Language.english:
        rootBundle.loadString("assets/English.json").then((values) {
          strings = json.decode(values.toString());
        });
        break;
    }
  }

  static String getString(String tag) {
    print(
        "Strings is null or empty -> ${(strings != null && strings.isNotEmpty)}");

    if (strings != null && strings.isNotEmpty) {
      return strings[tag];
    } else {
      return '';
    }
  }
}
