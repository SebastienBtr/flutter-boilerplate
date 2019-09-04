# Flutter boilerplate

## Installation

* You need flutter installed, see https://flutter.dev/docs/get-started/install
* Run ```flutter pub get``` (install dependencies)
* Create a .env file by copying the .env.default file and complete the different fields
* Use ```flutter run``` to launch the project on an emulator

## Adapt the boilerplate for your project

* Replace all the occurence of `flutter_boilerplate` by the name of your package
* Replace all the occurence of `example.boilerplate.app` by your app id
* In ios/Runner/Info.plist replace `Boilerplate` by the name of your app
* In andoir/app/src/main/AndroidManifest.xml replace `Boilerplate` by the name of your app
* In lib/utils/urls.dart edit the enpoints routes
* In lib/bloc/authBloc.dart and lib/bloc/passwordForgotBloc.dart look for the TODOS to uncomment the API calls
* In assets replace the images

## Project structure

```
lib
│
├── blocs // Contains all the states management and business logic (BLoC = Business Logic Component)
│   │
│   ├── example // All the blocs for the example screen
│   ├── authBloc.dart // Authentification bloc, accessible by all the widgets
│   ├── blocSetting.dart // File use by all blocs to rebuild widgets
│   └── mainBloc.dart // Main variables that can be use everywhere because this bloc is initialized in main.dart
│
├── models // The models of the app
│
├── screens // Pages of the applications
│   │
│   └── example // The example page directory
│       ├── widgets // Small parts that are use in the exmaple page
│       └── examplePage.dart // The example screen widget
│
├── services // API calls
│
├── utils // Some util functions
│
├── widgets // Small parts that are use in screens
│
├── main.dart // The app bootstrap
│
└── translations.dart // File to init translation mechanism

```

## Local Data

For small data that we need to save (settings, token...) the project uses the package https://pub.dev/packages/flutter_secure_storage. The availables keys are:

* 'token': the user access token
* 'login': the user login
* 'password': the user password
* 'language': the language code setting

## Add/Edit available languages

* Add a new translation file in assets/local
* Add the language code in the `supportedLanguages` list in lib/bloc/mainBloc.dart
* In ios/Runner/Info.plist add the language code in the array of the `CFBundleLocalizations` key

## Update the app icon

change the files in assets directory and run:

```flutter pub pub run flutter_launcher_icons:main```