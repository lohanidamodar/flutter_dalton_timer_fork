import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    TextStyle labelStyle = textTheme.subhead;
    TextStyle valueStyle = textTheme.body2;
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                "Dalton Timer",
                style: textTheme.display2,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              "Author",
              style: labelStyle,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              "Łukasz Huculak",
              style: valueStyle,
            ),
            // TODO add legal informations
            // TODO add COPPA informations
          ],
        ),
      ),
    );
  }
}
