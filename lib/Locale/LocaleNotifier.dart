import 'package:cypruslockdown/Locale/Languages.dart';
import 'package:cypruslockdown/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleNotifier extends ChangeNotifier {
  LocaleNotifier(Language locale) {
    language = locale;
  }

  Language _language;

  Language get language => _language;

  set language(Language newState) {
    if (newState != _language) {
      _language = newState;
      Localise.setLang(_language);
      saveState(_language);
      notifyListeners();
    }
  }

  void toggle() {
    if (_language == Language.greek) {
      _language = Language.english;
    } else {
      _language = Language.greek;
    }
    Localise.setLang(_language);
    saveState(_language);
    notifyListeners();
  }

  void saveState(Language language) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(pref_lang, language == Language.greek ? "GR" : "EN");
  }
}
