import 'package:cypruslockdown/AppEntrie.dart';
import 'package:cypruslockdown/Theme/ThemeNotifier.dart';
import 'package:cypruslockdown/Theme/ThemeStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Preferences.dart';
import 'Preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  runApp(MyApp(type: type));
}

class MyApp extends StatelessWidget {
  themeType type;

  MyApp({this.type});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeNotifier(type),
        )
      ],
      child: IntermitateWidget(),
    );
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
