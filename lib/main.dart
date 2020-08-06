import 'dart:async';
import 'package:flutter_boilerplate/blocs/authBloc.dart';
import 'package:flutter_boilerplate/blocs/mainBloc.dart';
import 'package:flutter_boilerplate/screens/home/homePage.dart';
import 'package:flutter_boilerplate/screens/login/loginPage.dart';
import 'package:flutter_boilerplate/utils/colorsUtil.dart';
import 'package:flutter_boilerplate/utils/helpers.dart';
import 'package:flutter_boilerplate/utils/sentry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Entry point of the application
Future<void> main() async {
  // We load the environments variables
  await DotEnv().load('.env');

  // We choose which page should be shown first to the user,
  // If there is no Token we go to the login page
  // If there is a Token we go the home page
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final String token = await storage.read(key: 'token');
  Widget firstPage = LoginPage();
  if (token != null) {
    firstPage = HomePage();
  }

  runZoned<Future<void>>(() async {
    // Launch the app
    runApp(MyApp(
      firstPage: firstPage,
    ));
  }, onError: (dynamic error, dynamic stackTrace) {
    // Whenever an error occurs, call the `reportError` function. This sends
    // Dart errors to the dev console or Sentry depending on the environment.
    reportError(error, stackTrace);
  });

  // This captures errors reported by the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      // In development mode, simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode, report to the application zone to report to
      // Sentry.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
}

class MyApp extends StatefulWidget {
  const MyApp({this.firstPage});

  final Widget firstPage;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Instanciate the main BLoC so it is accessible everywhere
    mainBloc = MainBloc(mainState: this);
    // Instanciate the authentication BLoC so it is accessible everywhere
    authBloc = AuthBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boilerplate',
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color(0xFF8e30db)),
        accentColor: createMaterialColor(const Color(0xFFd111db)),
        primaryTextTheme: Typography().white,
        accentTextTheme: Typography().white,
        primaryIconTheme: const IconThemeData.fallback().copyWith(
          color: Colors.white,
        ),
      ),
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        mainBloc.newLocaleDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: mainBloc.supportedLocales(),
      home: widget.firstPage,
    );
  }
}
