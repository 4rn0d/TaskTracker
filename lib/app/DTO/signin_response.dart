class SigninResponse {
  late String username;

  SigninResponse.fromJson(Map<String, dynamic> json)
      : username = json['username'];
}