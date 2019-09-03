import 'package:flutter_boilerplate/models/name.dart';

// User model for the current user
class User {
  User._({
    this.id,
    this.email,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User._(
      id: jsonData['id'] ?? '',
      email: jsonData['email'] ?? '',
      name: Name(
          firstName: jsonData['first_name'], lastName: jsonData['last_name']),
    );
  }

  // Id of the user
  int id;
  // Email of the user
  String email;
  // Name of the user
  Name name;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'first_name': name.firstName,
      'last_name': name.lastName,
    };
  }
}
