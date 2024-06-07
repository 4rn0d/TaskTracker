import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:tp1/app/DTO/add_task.dart';
import 'package:tp1/app/DTO/signin_request.dart';
import 'package:tp1/app/DTO/signin_response.dart';
import 'package:tp1/app/DTO/signup_request.dart';
import 'package:tp1/app/models/task.dart';

String user = "erreur";

Future<SigninResponse> signup(SignupRequest req) async {
  try {
    var response = await SingletonDio.getDio()
        .post('http://10.0.2.2:8080/api/id/signup', data: req.toJson());
    print(response);
    var text = response.toString();
    user = text.split(":")[1].split("}")[0].replaceAll("\"", "");
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
    var text = response.toString();
    user = text.split(":")[1].split("}")[0].replaceAll("\"", "");
    print(response);
    return SigninResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<void> signout() async {
  try {
    var response = await SingletonDio.getDio()
        .post('http://10.0.2.2:8080/api/id/signout');
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<void> update(int id, int value) async {
  try {
    var response = await SingletonDio.getDio()
        .get('http://10.0.2.2:8080/api/progress/$id/$value');
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<List<Task>> getTasks() async {
  try {
    var response = await SingletonDio.getDio()
        .get('http://10.0.2.2:8080/api/home');
    List<Task> test = [];
    for (var task in response.data){
      test.add(Task.fromJson(task));
    }
    return test;
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<Task> getDetail(int id) async {
  try {
    var response = await SingletonDio.getDio()
        .get('http://10.0.2.2:8080/api/detail/$id');
    return Task.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<void> addTask(AddTask req) async {
  try {
    var response = await SingletonDio.getDio()
        .post('http://10.0.2.2:8080/api/add', data: req.toJson());
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