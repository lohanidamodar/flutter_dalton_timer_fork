import 'package:dalton_timer/widgets/theme_switcher.dart';
import 'package:dalton_timer/theme_builder.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    final changeTheme = ChangeTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Brightness",
              style: currentTheme.textTheme.subhead,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("Use light theme"),
                ),
                Switch(
                  value: currentTheme.brightness == Brightness.light,
                  onChanged: (isLight) {
                    changeTheme.setTheme(appThemeBuilder(brightness : isLight ? Brightness.light : Brightness.dark));
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
