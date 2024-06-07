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
    return const MaterialApp(
      home: Signin(),
    );
  }
}