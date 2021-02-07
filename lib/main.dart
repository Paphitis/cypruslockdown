import 'package:cypruslockdown/AppEntrie.dart';
import 'package:cypruslockdown/Locale/Languages.dart';
import 'package:cypruslockdown/Locale/LocaleNotifier.dart';
import 'package:cypruslockdown/Models/PreConfig.dart';
import 'package:cypruslockdown/Theme/ThemeNotifier.dart';
import 'package:cypruslockdown/Theme/ThemeStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Preferences.dart';
import 'Preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PreConfig>(
        future: _getPreConfig(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(
                "Snap shot -> ${snapshot.data.theme.toString()} ${snapshot.data.language.toString()}");

            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => ThemeNotifier(snapshot.data.theme),
                ),
                ChangeNotifierProvider(
                    create: (context) =>
                        LocaleNotifier(snapshot.data.language)),
              ],
              child: IntermitateWidget(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<PreConfig> _getPreConfig() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    themeType type;
    if (_prefs.containsKey(pref_theme)) {
      bool dark = _prefs.getBool(pref_theme);

      if (dark) {
        type = themeType.Dark;
      } else {
        type = themeType.Light;
      }
    } else {
      type = themeType.Light;
    }

    Language language;

    if (_prefs.containsKey(pref_lang)) {
      language = _prefs.getString(pref_lang) == 'GR'
          ? Language.greek
          : Language.english;
    } else {
      language = Language.greek;
    }

    return PreConfig(theme: type, language: language);
  }
}

class IntermitateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeNotifier>(context, listen: true).type ==
              themeType.Dark
          ? ThemeStyle().Dark
          : ThemeStyle().Light,
      home: MyHomePage(),
    );
  }
}
