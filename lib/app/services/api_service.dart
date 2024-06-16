import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tp1/app/DTO/add_task.dart';
import 'package:tp1/app/DTO/signin_request.dart';
import 'package:tp1/app/DTO/signin_response.dart';
import 'package:tp1/app/DTO/signup_request.dart';
import 'package:tp1/app/models/task.dart';

String user = "erreur";
String serverAddress = "http://10.0.2.2:8080";
String renderAddress = "https://kickmya-sserver.onrender.com";
bool isLoading = false;

Future<UserCredential?> signup(String email, String password) async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  return null;
}

Future<UserCredential?> signin(String email, String password) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    return credential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
  return null;
}

Future<void> signout() async {
  await FirebaseAuth.instance.signOut();
}

Future<void> update(int id, int value) async {
  try {
    var response = await SingletonDio.getDio()
        .get('$renderAddress/api/progress/$id/$value');
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<List<QueryDocumentSnapshot<Task>>> getTasks() async {
  final ref = FirebaseFirestore.instance.collection("Tasks").withConverter(
      fromFirestore: Task.fromFirestore, toFirestore: (Task task, _) => task.toFirestore()
  );
  final docSnap = await ref.get();
  print(docSnap.docs[0].id);
  return docSnap.docs;
}

Future<DocumentSnapshot<Task>> getDetail(String id) async {
  final ref = FirebaseFirestore.instance.collection("Tasks").doc(id).withConverter(
      fromFirestore: Task.fromFirestore, toFirestore: (Task task, _) => task.toFirestore()
  );
  final docSnap = await ref.get();
  // final task = docSnap.data();
  return docSnap;
}

Future<void> addTask(AddTask req) async {
  try {
    var response = await SingletonDio.getDio()
        .post('$renderAddress/api/add', data: req.toJson());
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