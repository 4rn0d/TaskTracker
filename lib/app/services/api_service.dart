import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:tp1/app/DTO/signin_request.dart';
import 'package:tp1/app/DTO/signin_response.dart';
import 'package:tp1/app/DTO/signup_request.dart';

Future<SigninResponse> signup(SignupRequest req) async {
  try {
    var response = await SingletonDio.getDio()
        .post('http://10.0.2.2:8080/api/id/signup', data: req.toJson());
    print(response);
    return SigninResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<SigninResponse> signin(SigninRequest req) async {
  try {
    var response = await SingletonDio.getDio()
        .post('http://10.0.2.2:8080/api/id/signin', data: req.toJson());
    print(response);
    return SigninResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<void> signout(SigninRequest req) async {
  try {
    var response = await SingletonDio.getDio()
        .post('http://10.0.2.2:8080/api/id/signout');
  } catch (e) {
    print(e);
    rethrow;
  }
}

class SingletonDio {

  static var cookiemanager = CookieManager(CookieJar());

  static Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(cookiemanager);
    dio.options.headers['content-Type'] = 'application/json';
    return dio;
  }
}