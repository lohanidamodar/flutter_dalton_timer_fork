import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ThemeData ThemeBuilder(BuildContext context, {Brightness brightness});

ThemeBuilder appThemeBuilder = (context, {brightness = Brightness.dark}) {
  bool isLight = brightness == Brightness.light;
  Typography platformTypography = Typography(platform: defaultTargetPlatform);
  TextTheme defaultTheme =
      isLight ? platformTypography.black : platformTypography.white;
  double screenSide = MediaQuery.of(context).size.shortestSide;
  print("Screen side = $screenSide ${MediaQuery.of(context).textScaleFactor}");
  if (screenSide >= 600) {
    print("Building theme for tablets");
    defaultTheme = defaultTheme.copyWith(
        headline: defaultTheme.headline.copyWith(fontSize: 35.0));
  }
  return ThemeData(
    primarySwatch: Colors.blueGrey,
    primaryColor: isLight ? null : Colors.blueGrey[900],
    backgroundColor: isLight ? null : Colors.grey[800],
    accentColor: Colors.cyanAccent.shade700,
    brightness: isLight ? Brightness.light : Brightness.dark,
    textTheme: defaultTheme,
  );
};
