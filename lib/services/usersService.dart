import 'dart:convert';
import 'package:flutter_boilerplate/models/user.dart';
import 'package:flutter_boilerplate/services/apiService.dart';
import 'package:flutter_boilerplate/utils/urls.dart';
import 'package:http/http.dart' as http;

class UsersService {
  UsersService._();

  // Singleton instance of the service
  static final UsersService instance = UsersService._();
  // URL of the users endpoint
  static final String _url = usersUrl;

  Future<User> getCurrentUser() async {
    final http.Response response = await getWithToken('$_url');
    checkErrors(response);
    return User.fromJson(json.decode(response.body));
  }
}
