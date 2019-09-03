import 'dart:async';
import 'dart:convert';
import 'package:flutter_boilerplate/blocs/mainBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Class for the usage of translations
// To get the translations of a key use the Translations `text` function
// Code: Translations.of(context).text('your key');
// To change the current language use the mainBloc function
// Code: mainBloc.onLocaleChanged(Locale('language ISO code'));
// It will replace the main TranslationsDelegate instance 
// By a new instance with the new Language
class Translations {
  Translations({this.locale}) {
    _localizedValues = null;
  }

  // Current language
  Locale locale;
  // Key value Map of the translations
  static Map<dynamic, dynamic> _localizedValues;

  // Get the translations instance of the context
  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  // Return the translations of the given key
  String text(String key) {
    if (_localizedValues == null) {
      return '';
    } else {
      return _localizedValues[key] ?? '$key missing';
    }
  }

  // Load the good translation file according to the current language
  // And initiate the 'localizedValues' Map
  static Future<Translations> load(Locale locale) async {
    final Translations translations = Translations(locale: locale);
    final String jsonContent = await rootBundle
        .loadString('assets/locale/i18n_${locale.languageCode}.json');
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  // Return the current language ISO code
  String get currentLanguage => locale.languageCode;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  TranslationsDelegate({this.newLocale}) {
    if (newLocale == null) {
      loadLang();
    }
  }

  // The new Language to use
  Locale newLocale;
  // Local secure storage to save the current language setting
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Load the language saved in the secure storage
  // Or the default language available for the device
  Future<void> loadLang() async {
    final String language = await _storage.read(key: 'language');
    if (language != null) {
      newLocale = Locale(language, '');
      load(null);
    }
  }

  // Check if the new language is supported by the app
  @override
  bool isSupported(Locale locale) =>
      mainBloc.supportedLanguages.contains(locale.languageCode);

  // Load the translations of the new language
  @override
  Future<Translations> load(Locale locale) =>
      Translations.load(newLocale ?? locale);

  // Reload to view the new translations
  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) {
    return true;
  }
}
