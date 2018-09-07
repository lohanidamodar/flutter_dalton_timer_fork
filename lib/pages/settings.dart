import 'package:dalton_timer/constants.dart';
import 'package:dalton_timer/intl/localizations.dart';
import 'package:dalton_timer/widgets/instance_provider.dart';
import 'package:dalton_timer/widgets/theme_switcher.dart';
import 'package:dalton_timer/theme_builder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = TimerAppLocalizations.of(context);
    final currentTheme = Theme.of(context);
    final changeTheme = ChangeTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              localizations.brightness,
              style: currentTheme.textTheme.subhead,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(localizations.brightnessUseLightTheme),
                ),
                Switch(
                  value: currentTheme.brightness == Brightness.light,
                  onChanged: (isLight) {
                    changeTheme.setTheme(appThemeBuilder(
                        brightness:
                            isLight ? Brightness.light : Brightness.dark));
                    InstanceProvider
                        .of<SharedPreferences>(context)
                        .setBool(SETTINGS_LIGHT_THEME, isLight);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
