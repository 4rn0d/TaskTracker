import 'package:flutter/material.dart';
import 'package:tp1/app/task/create.dart';
import 'package:tp1/app/task/details.dart';
import 'package:tp1/app/utils/app_theme.dart';
import 'app/auth/signin.dart';
import 'app/auth/signup.dart';
import 'app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Signin(),
      routes: routes(),
    );
  }

  Map<String, WidgetBuilder> routes() {
    return {
      '/login': (context) => const Signin(),
      '/signup': (context) => const Signup(),
      '/home': (context) => const Home(),
      '/details': (context) => const Details(),
      '/create': (context) => const Create(),
    };
  }
}