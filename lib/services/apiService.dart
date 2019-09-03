import 'dart:convert';
import 'dart:io';
import 'package:flutter_boilerplate/blocs/authBloc.dart';
import 'package:flutter_boilerplate/blocs/mainBloc.dart';
import 'package:flutter_boilerplate/services/authService.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// Type definition to give the original request function to the error handler
typedef RequestFunction = Future<http.Response> Function(String token);

// Local secure storage instance
final FlutterSecureStorage _storage = FlutterSecureStorage();

// Simple POST request to the path given and the body given
Future<http.Response> post(String path, Map<String, dynamic> body) {
  return http.post(
    path,
    body: json.encode(_createRequestBody(body)),
    headers: _getSimpleHeaders(),
  );
}

// POST request with user token includes
// To the path given and the body given
Future<http.Response> postWithToken(
  String path,
  Map<String, dynamic> body,
) async {
  final String token = await _storage.read(key: 'token');

  final RequestFunction requestFunction = (String token) {
    return http.post(
      path,
      body: json.encode(_createRequestBody(body)),
      headers: _getAuthHeaders(token),
    );
  };

  final http.Response response = await requestFunction(token);
  return _handle401AndGetResponse(response, requestFunction);
}

// Simple GET request to the path given
Future<http.Response> get(String path) {
  return http.get(
    path,
    headers: _getSimpleHeaders(),
  );
}

// GET request with user token includes to the path given
Future<http.Response> getWithToken(String path) async {
  final String token = await _storage.read(key: 'token');

  final RequestFunction requestFunction = (String token) {
    return http.get(
      path,
      headers: _getAuthHeaders(token),
    );
  };

  final http.Response response = await requestFunction(token);
  return _handle401AndGetResponse(response, requestFunction);
}

// Simple PUT request to the path given and the body given
Future<http.Response> put(String path, Map<String, dynamic> body) {
  return http.put(
    path,
    body: json.encode(_createRequestBody(body)),
    headers: _getSimpleHeaders(),
  );
}

// PUT request with user token includes
// To the path given and the body given
Future<http.Response> putWithToken(
  String path,
  Map<String, dynamic> body,
) async {
  final String token = await _storage.read(key: 'token');

  final RequestFunction requestFunction = (String token) {
    return http.put(
      path,
      body: json.encode(_createRequestBody(body)),
      headers: _getAuthHeaders(token),
    );
  };

  final http.Response response = await requestFunction(token);
  return _handle401AndGetResponse(response, requestFunction);
}

// Simple DELETE request to the path given
Future<http.Response> delete(String path) {
  return http.delete(
    path,
    headers: _getSimpleHeaders(),
  );
}

// DELETE request with user token includes to the path given
Future<http.Response> deleteWithToken(String path) async {
  final String token = await _storage.read(key: 'token');

  final RequestFunction requestFunction = (String token) {
    return http.delete(
      path,
      headers: _getAuthHeaders(token),
    );
  };

  final http.Response response = await requestFunction(token);
  return _handle401AndGetResponse(response, requestFunction);
}

// Return the basic request headers
Map<String, String> _getSimpleHeaders() {
  return <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
}

// Return the headers with the user token
Map<String, String> _getAuthHeaders(String token) {
  return <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  };
}

// Refresh the user token by re-login him
Future<bool> _refreshLogin() async {
  final String login = await _storage.read(key: 'login');
  final String password = await _storage.read(key: 'password');

  try {
    final String token = await AuthService.instance.login(login, password);
    _storage.write(key: 'token', value: token);
    return true;
  } on Exception catch (error) {
    // Impossible to re-login the user so we logout
    mainBloc.logger.e(error);
    authBloc.logout(mainBloc.currentContext, mainBloc.mainState);
    return false;
  }
}

// Generate the request body by removing all the empty entries
Map<String, dynamic> _createRequestBody(Map<String, dynamic> jsonData) {
  final Map<String, dynamic> body = <String, dynamic>{};

  jsonData.forEach((String key, dynamic value) {
    if (value != null && value != '') {
      body.putIfAbsent(key, () => value);
    }
  });

  return body;
}

// Handle errors for request with token
// If there is a 401 error we refresh the user token
// And resend the request
Future<http.Response> _handle401AndGetResponse(
    http.Response response, RequestFunction originalRequestFct) async {
  if (response.statusCode == 401) {
    final bool isLogged = await _refreshLogin();
    if (isLogged) {
      final String token = await _storage.read(key: 'token');
      // Send again the original request
      return originalRequestFct(token);
    }
    return null;
  } else {
    return response;
  }
}

// Check the status of a request response
void checkErrors(http.Response response) {
  if (response.statusCode < 200 || response.statusCode >= 400) {
    final Map<String, dynamic> body = json.decode(response.body);
    mainBloc.logger.e(body);
    throw Exception(body['message']);
  }
}
