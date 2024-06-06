import 'package:tp1/app/DTO/signup_request.dart';

class SigninRequest {
  late String username;
  late String password;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}