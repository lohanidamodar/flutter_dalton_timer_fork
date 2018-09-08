import 'package:dalton_timer/constants.dart';
import 'package:dalton_timer/intl/localizations.dart';
import 'package:dalton_timer/pages/about_app.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildAppearanceSettings(
              context, localizations, currentTheme)
          ..add(
            SizedBox(height: 16.0,))
            ..addAll(_buildOtherSettings(context, localizations, currentTheme)),
        ),
      ),
    );
  }

  List<Widget> _buildAppearanceSettings(BuildContext context,
      TimerAppLocalizations localizations, ThemeData currentTheme) {
    final changeTheme = ChangeTheme.of(context);
    return <Widget>[
      Text(
        localizations.appearanceSection.toUpperCase(),
        style: currentTheme.textTheme.subhead,
      ),
      Divider(),

      _buildThemeOptionRow(localizations, currentTheme, changeTheme, context)
    ];
  }

  Widget _buildThemeOptionRow(TimerAppLocalizations localizations,
      ThemeData currentTheme, ChangeTheme changeTheme, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            localizations.brightness,
            style: currentTheme.textTheme.body2,
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
                      brightness: isLight ? Brightness.light : Brightness.dark));
                  InstanceProvider
                      .of<SharedPreferences>(context)
                      .setBool(SETTINGS_LIGHT_THEME, isLight);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOtherSettings(BuildContext context,
      TimerAppLocalizations localizations, ThemeData currentTheme) {
    return <Widget>[
      Text(
        localizations.otherSettings.toUpperCase(),
        style: currentTheme.textTheme.subhead,
      ),
      Divider(),
      ListTile(
        title: Text(localizations.about),
        trailing: Icon(Icons.info),
        onTap: () {
          _routeToAboutPage(context);
        },
      )
    ];
  }

  void _routeToAboutPage(BuildContext context) {
    Navigator
        .of(context)
        .push(MaterialPageRoute<AppInfo>(builder: (c) => AppInfo()));
  }
}
