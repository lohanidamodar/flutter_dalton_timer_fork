import 'package:dalton_timer/intl/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class AppInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    TextStyle labelStyle = textTheme.subhead;
    TextStyle valueStyle = textTheme.body2;
    TimerAppLocalizations localizations = TimerAppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.aboutApp),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              localizations.author,
              style: labelStyle,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              "Łukasz Huculak",
              style: valueStyle,
            ),
            Divider(),
            InkWell(
              child: SizedBox(
                height: 56.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(localizations.contactMe, style: labelStyle,),
                      Text('ukasz.apps@gmail.com'),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                ),
              ),
              onTap: _messageAuthor,
            )
            // TODO add legal informations
            // TODO add COPPA informations
          ],
        ),
      ),
    );
  }

  void _messageAuthor() {
    Email email = Email(
      recipients: ["ukasz.apps@gmail.com"],
      subject: 'Message from Dalton Timer'
    );
    FlutterEmailSender.send(email);
  }
}
