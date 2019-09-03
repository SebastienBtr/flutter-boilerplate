import 'dart:async';
import 'dart:convert';
import 'package:flutter_boilerplate/blocs/mainBloc.dart';
import 'package:flutter_boilerplate/services/apiService.dart';
import 'package:flutter_boilerplate/utils/unauthorizedException.dart';
import 'package:flutter_boilerplate/utils/urls.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// Service for the authentication
class AuthService {
  AuthService._();

  // Singleton instance of the service
  static final AuthService instance = AuthService._();

  // User login
  Future<String> login(String login, String password) async {
    final http.Response response = await post(authUrl, <String, dynamic>{
      'email': login,
      'password': password,
    });

    final Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 401) {
      mainBloc.logger.e(responseBody);
      throw UnauthorizedException(responseBody['message']);
    }

    checkErrors(response);

    return responseBody['access_token'];
  }

  // User logout
  Future<void> logout() async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
    await storage.delete(key: 'login');
    await storage.delete(key: 'password');
  }

  // Request a new password, this will send an email to the user
  Future<bool> requestResetPassword(String login) async {
    final http.Response response =
        await put(requestPasswordUrl, <String, dynamic>{
      'email': login,
    });

    if (response.statusCode < 200 || response.statusCode >= 400) {
      return false;
    }
    return true;
  }
}
