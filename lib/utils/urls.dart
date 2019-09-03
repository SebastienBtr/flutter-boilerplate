import 'package:flutter_dotenv/flutter_dotenv.dart';

// List of the server endpoints
// TODO: add your own enpoints
final String baseUrl = DotEnv().env['API_URL'];
final String authUrl = baseUrl + '/auth';
final String requestPasswordUrl = baseUrl + '/password'; 
final String usersUrl = baseUrl + '/users';