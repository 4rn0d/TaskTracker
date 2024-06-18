import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:tp1/app/DTO/add_task.dart';
import 'package:tp1/app/DTO/signin_request.dart';
import 'package:tp1/app/DTO/signin_response.dart';
import 'package:tp1/app/DTO/signup_request.dart';
import 'package:tp1/app/models/task.dart';

String user = "erreur";
String serverAddress = "http://10.0.2.2:8080";
String renderAddress = "https://kickmya-sserver.onrender.com";
bool isLoading = false;
final db = FirebaseFirestore.instance;

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

Future<void> update(String id, int value) async {
  final taskRef = db.collection("Tasks").doc(id);
  taskRef.update({"Progression": value}).then(
          (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
  // CollectionReference taskReference = db.collection('Tasks');
  // DocumentReference taskDoc = taskReference.doc(id);
  // taskDoc.set({
  //   'Progression': value.toString()
  // });
  // print(taskDoc);
}

Future<List<Task>> getTasks() async {
  isLoading = true;
  List<Task> taskList = [];
  final ref = db.collection("Tasks").withConverter(
      fromFirestore: Task.fromFirestore, toFirestore: (Task task, _) => task.toFirestore()
  );
  var querySnapshot = await ref.get();

  print("Successfully completed");
  for (var docSnapshot in querySnapshot.docs) {
    taskList.add(docSnapshot.data());
  }

  isLoading = false;
  print(taskList);
  return taskList;
}

Future<Task?> getDetail(String id) async {
  isLoading = true;
  final ref = db.collection("Tasks").doc(id).withConverter(
      fromFirestore: Task.fromFirestore, toFirestore: (Task task, _) => task.toFirestore()
  );
  final docSnap = await ref.get();
  final task = docSnap.data();
  if (task != null) {
    isLoading = false;
    return task;
  }
  print("No such document.");
  return task;
}

Future<void> addTask(AddTask req) async {
  CollectionReference taskReference = db.collection('Tasks');
  taskReference.add({
    'Name': req.name,
    'Deadline': DateTime.parse(req.deadline),
    'Progression': 0,
    'TimeSpent': 0,
    'PhotoId': 0,
  });
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