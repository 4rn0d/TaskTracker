class SignupRequest {
  late String username;
  late String password;

  SignupRequest({username, password});

  SignupRequest.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}