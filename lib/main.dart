import 'dart:ui';

import 'package:dalton_timer/constants.dart';
import 'package:dalton_timer/intl/localizations.dart';
import 'package:dalton_timer/sound_manager.dart';
import 'package:dalton_timer/widgets/instance_provider.dart';
import 'package:dalton_timer/widgets/theme_switcher.dart';
import 'package:dalton_timer/theme_builder.dart';
import 'package:dalton_timer/pages/time_selection.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp(this.prefs) : super();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(window),
      child: Builder(
        builder: (builderContext) => SoundsProvider(
              child: InstanceProvider<SharedPreferences>(
                value: prefs,
                child: ThemeSwitcher(
                  childBuilder: (c) => ThemedApp(),
                  initialTheme: appThemeBuilder(builderContext,
                      brightness: prefs.getBool(SETTINGS_LIGHT_THEME) ?? false
                          ? Brightness.light
                          : Brightness.dark),
                ),
              ),
              sounds: SoundsManager(builderContext),
            ),
      ),
    );
  }
}

class ThemedApp extends StatelessWidget {
  const ThemedApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: kSupportedLocales,
      localizationsDelegates: [
        TimerAppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Dalton Timer',
      theme: ChangeTheme.of(context).getTheme(),
      home: TimeSelectionPage(),
    );
  }
}
