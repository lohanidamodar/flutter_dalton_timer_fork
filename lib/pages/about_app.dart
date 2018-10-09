import 'package:dalton_timer/intl/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      body: SingleChildScrollView(
        child: Padding(
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
                        Text(
                          localizations.contactMe,
                          style: labelStyle,
                        ),
                        Text('ukasz.apps@gmail.com'),
                      ],
                      mainAxisSize: MainAxisSize.min,
                    ),
                  ),
                ),
                onTap: _messageAuthor,
              ),
              Divider(),
              // licences informations
              InkWell(
                child: SizedBox(
                  height: 56.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(localizations.licencesInformation)),
                  ),
                ),
                onTap: () => _showLegal(context),
              ),

              Divider(),
              // licences informations
              InkWell(
                child: SizedBox(
                  height: 56.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(localizations.privacyPolicy)),
                  ),
                ),
                onTap: () => _showPrivacyPolicy(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _messageAuthor() {
    Email email = Email(
        recipients: ["ukasz.apps@gmail.com"],
        subject: 'Message from Dalton Timer');
    FlutterEmailSender.send(email);
  }

  void _showLegal(BuildContext context) async {
    final licenceText =
        await DefaultAssetBundle.of(context).loadString("LICENCE");
    showLicensePage(
        context: context,
        applicationName: "Dalton Timer",
        applicationLegalese: licenceText);
  }

  static const String _privacyPolicyUrlPart = 'https://ukasz-apps.bitbucket.io/policies/dalton_timer/privacy-policy-';
  static const String _privacyPolicyUrlSuffix = '.txt';
  _showPrivacyPolicy(BuildContext context) async{
    final l10n = TimerAppLocalizations.of(context);
    final url = _privacyPolicyUrlPart + Localizations.localeOf(context).languageCode+_privacyPolicyUrlSuffix;
    final policyResponse = await http.get(url);
    if (policyResponse.statusCode == 200){
      showDialog(context: context, builder: (c) => SimpleDialog(
        title: Text(l10n.privacyPolicy), children: [Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(utf8.decode(policyResponse.bodyBytes)),
        )],));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(l10n.policyUnavailableMessage),));
    }
  }
}
