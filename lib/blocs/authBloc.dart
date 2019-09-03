import 'dart:io';
import 'package:flutter_boilerplate/blocs/mainBloc.dart';
import 'package:flutter_boilerplate/blocs/settingBloc.dart';
import 'package:flutter_boilerplate/models/user.dart';
import 'package:flutter_boilerplate/screens/home/homePage.dart';
import 'package:flutter_boilerplate/screens/login/loginPage.dart';
import 'package:flutter_boilerplate/services/authService.dart';
import 'package:flutter_boilerplate/services/usersService.dart';
import 'package:flutter_boilerplate/translations.dart';
import 'package:flutter_boilerplate/utils/unauthorizedException.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthBloc extends SettingBloc {
  // Boolean to know we are waiting for a server response
  bool isLoading = false;
  // Error message to show to the suer
  String loginError = '';
  // Boolean to know we are processing the logout function
  bool isLogoutInProgress = false;
  // Instance of the local storage
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  // Current user of the app
  User _currentUser;

  // Login function
  Future<void> login(BuildContext context, dynamic state, String login,
      String password) async {
    isLoading = true;
    loginError = '';
    isLogoutInProgress = false;
    rebuildWidgets(states: <State>[state]);

    try {
      // TODO: uncomment this line to use real api call
      // final String token = await AuthService.instance.login(login, password);
      const String token = 'TEST';
      // We store the credentials to auto re-login the user 
      // When the token expires
      await _storage.write(key: 'token', value: token);
      await _storage.write(key: 'login', value: login);
      await _storage.write(key: 'password', value: password);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => HomePage(),
        ),
        (Route<dynamic> route) => false,
      );
    } on UnauthorizedException catch (error) {
      mainBloc.logger.e(error);
      loginError = Translations.of(context)
          .text('Invalid email and password combination');
    } on IOException catch (error) {
      mainBloc.logger.e(error);
      loginError =
          Translations.of(context).text('Your are not connected to internet');
      await clean();
    } on Exception catch (error) {
      mainBloc.logger.e(error);
      loginError =
          Translations.of(context).text('Sorry, an error has occurred');
      await clean();
    } finally {
      isLoading = false;
      rebuildWidgets(states: <State>[state]);
    }
  }

  // Reset stored credentials
  Future<void> clean() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'login');
    await _storage.delete(key: 'password');
  }

  // Logout function:
  // Call the logout function of the Authentication service.
  // Redirect to the login page
  Future<void> logout(BuildContext context, dynamic state) async {
    isLoading = true;
    isLogoutInProgress = true;
    rebuildWidgets(states: <State>[state]);

    await AuthService.instance.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => LoginPage(),
      ),
      (Route<dynamic> route) => false,
    );

    _currentUser = null;
    isLoading = false;
  }

  // Get the current user
  Future<User> get currentUser async {
    if (!isLogoutInProgress) {
      if (_currentUser != null) {
        return _currentUser;
      } else {
        _currentUser = await UsersService.instance.getCurrentUser();
        if (_currentUser == null) {
          logout(mainBloc.currentContext, mainBloc.mainState);
        }
        return _currentUser;
      }
    } else {
      return null;
    }
  }
}

AuthBloc authBloc;
