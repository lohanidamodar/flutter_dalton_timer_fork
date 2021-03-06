import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';

const _kSupportedLanguages = [
  'en',
  'pl',
];

final kSupportedLocales = _kSupportedLanguages.map((lang) => Locale(lang));

/// This is the simple localizations provider
///
/// Skipping `intl` package because small amount of strings that will be used within the app
class TimerAppLocalizations {
  final Locale locale;

  TimerAppLocalizations(this.locale);

  static TimerAppLocalizations of(BuildContext context) {
    return Localizations.of<TimerAppLocalizations>(
        context, TimerAppLocalizations);
  }

  // internal utilities
  Map<String, String> get _translate => _translations[locale.languageCode] ?? _translations['en'];

  // DECLARED RESOURCES
  String get pickTime => _translate['pickTime'];

  String get enterTimeInMinutesHint => _translate['enterTimeInMinutes'];

  String get settings => _translate['settings'];

  String get brightness => _translate['brightness'];

  String get brightnessUseLightTheme => _translate['brightnessUseLightTheme'];

  String get appearanceSection => _translate['appearanceSection'];

  String get otherSettings => _translate['otherSettings'];

  String get about => _translate['about'];

  String get aboutApp => _translate['aboutApp'];

  String get author => _translate['author'];

  String get contactMe => _translate['contactMe'];

  String get pickFace => _translate['pickFace'];

  String get defaultFace => _translate['defaultFace'];

  String get classicFace => _translate['classicFace'];

  String get licencesInformation => _translate['licencesInformation'];

  String get privacyPolicy => _translate['privacyPolicy'];

  String get policyUnavailableMessage => _translate['policyUnavailableMessage'];

  // TRANSLATIONS
  static Map<String, Map<String, String>> _translations = {
    'en': {
      'pickTime': "Pick time",
      'enterTimeInMinutes': 'Enter time in minutes',

      // settings
      'settings' : 'Settings',
      'appearanceSection': 'Appearance',
      'brightness' : 'Brightness',
      'brightnessUseLightTheme': 'Use light theme',
      'otherSettings': 'Other',
      'pickFace': 'Pick face',
      'defaultFace': 'Default',
      'classicFace': 'Classic',

      // about
      'about': 'About',
      'aboutApp': 'About application',
      'author': 'Author',
      'contactMe': 'Contact me',
      'licencesInformation': 'Licences',
      // privacy policy
      'privacyPolicy': 'Privacy policy',
      'policyUnavailableMessage':'Unable to load privacy policy.',
    },
    'pl': {
      'pickTime': "Wybierz czas",
      'enterTimeInMinutes': 'Wpisz liczbę minut',

      // settings
      'settings' : 'Ustawienia',
      'appearanceSection': 'Wygląd',
      'brightness' : 'Jasność',
      'brightnessUseLightTheme': 'Użyj jasnego motywu',
      'otherSettings': 'Inne',
      'pickFace': 'Wybierz tarczę',
      'defaultFace': 'Domyślna',
      'classicFace': 'Klasyczna',

      // about
      'about': 'O aplikacji',
      'aboutApp': 'O aplikacji',
      'author': 'Autor',
      'contactMe': 'Wyślij wiadomość',
      'licencesInformation': 'Wykorzystywane licencje',
      // privacy policy
      'privacyPolicy': 'Polityka prywatności',
      'policyUnavailableMessage': 'Obecnie nie można pobrać polityki prywatności.',
    },
  };
}

class TimerAppLocalizationsDelegate extends LocalizationsDelegate<TimerAppLocalizations>{
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<TimerAppLocalizations> load(Locale locale) =>
    Future.value(TimerAppLocalizations(locale));


  @override
  bool shouldReload(LocalizationsDelegate<TimerAppLocalizations> old) => false;

}