import 'package:flutter/material.dart';

typedef ThemeData ThemeBuilder({Brightness brightness});

ThemeBuilder appThemeBuilder = ({brightness = Brightness.dark}) {
  bool isLight = brightness == Brightness.light;
  return ThemeData(
      primarySwatch: Colors.blueGrey,
      primaryColor: isLight ? null : Colors.blueGrey[900],
      backgroundColor: isLight ? null : Colors.grey[800],
      accentColor: Colors.cyanAccent.shade200,
      brightness: isLight ? Brightness.light : Brightness.dark);
};
