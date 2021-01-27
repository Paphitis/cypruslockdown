import 'package:flutter/widgets.dart';

enum themeType { Light, Dark }

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier(themeType type) {
    _type = type;
  }

  themeType _type;

  themeType get type => _type;

  set type(themeType newState) {
    if (newState != _type) {
      _type = newState;
      notifyListeners();
    }
  }

  void toggle() {
    if (_type == themeType.Dark) {
      _type = themeType.Light;
    } else {
      _type = themeType.Dark;
    }

    notifyListeners();
  }
}
