import 'package:dalton_timer/sound_manager.dart';
import 'package:dalton_timer/widgets/theme_switcher.dart';
import 'package:dalton_timer/theme_builder.dart';
import 'package:flutter/material.dart';
import 'package:dalton_timer/pages/time_selection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SoundsProvider(
      child: ThemeSwitcher(
        childBuilder: (c) => ThemedApp(),
        initialTheme: appThemeBuilder(),
      ),
      sounds: SoundsManager(context),
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
      title: 'Dalton Timer',
      theme: ChangeTheme.of(context).getTheme(),
      home: TimeSelectionPage(),
    );
  }
}
