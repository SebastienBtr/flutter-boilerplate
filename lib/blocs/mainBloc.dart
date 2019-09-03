import 'package:flutter_boilerplate/blocs/settingBloc.dart';
import 'package:flutter_boilerplate/translations.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MainBloc extends SettingBloc {
  MainBloc({@required this.mainState});

  // Init the app logger
  Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  // List of the language code supported by the app
  final List<String> supportedLanguages = <String>['fr', 'en'];
  // The locale language delegate
  TranslationsDelegate newLocaleDelegate =
      TranslationsDelegate(newLocale: null);
  // Main state of the app, call set state on it will rebuild everything
  State mainState;
  // The key of the current shown scaffold
  GlobalKey<ScaffoldState> _currentScaffoldKey;

  // Returns the list of supported Locales
  Iterable<Locale> supportedLocales() =>
      supportedLanguages.map<Locale>((String lang) => Locale(lang, ''));

  //function to be invoked when changing the language
  void onLocaleChanged(Locale locale) {
    newLocaleDelegate = TranslationsDelegate(newLocale: locale);
    rebuildWidgets(states: <State>[mainState]);
  }

  // Set the current scaffold key
  set currentScaffoldKey(GlobalKey<ScaffoldState> key) {
    _currentScaffoldKey = key;
  }

  // Get the current context of the app
  BuildContext get currentContext => _currentScaffoldKey.currentContext;

  // Show a toast alert in the current page with the text and duration given
  void showToast(String text, [int millisecondsDuration = 2000]) {
    _currentScaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: millisecondsDuration),
        content: Text(text),
      ),
    );
  }
}

MainBloc mainBloc;
