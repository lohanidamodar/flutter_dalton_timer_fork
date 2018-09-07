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

  // TRANSLATIONS
  static Map<String, Map<String, String>> _translations = {
    'en': {
      'pickTime': "Pick time",
      'enterTimeInMinutes': 'Enter time in minutes',
      'settings' : 'Settings',
      'brightness' : 'Brightness',
      'brightnessUseLightTheme': 'Use light theme',
    },
    'pl': {
      'pickTime': "Wybierz czas",
      'enterTimeInMinutes': 'Wpisz liczbę minut',
      'settings' : 'Ustawienia',
      'brightness' : 'Jasność',
      'brightnessUseLightTheme': 'Użyj jasnego motywu',
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