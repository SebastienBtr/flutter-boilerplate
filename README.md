# Flutter boilerplate

## Installation

* You need flutter installed, see https://flutter.dev/docs/get-started/install
* Run ```flutter pub get``` (install dependencies)
* Create a .env file by copying the .env.default file and complete the different fields
* Use ```flutter run``` to launch the project on an emulator

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

## Update the icon app

change the files in assets directory and run:

```flutter pub pub run flutter_launcher_icons:main```