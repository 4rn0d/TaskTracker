import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tp1/app/task/create.dart';
import 'package:tp1/app/task/details.dart';
import 'package:tp1/app/utils/app_theme.dart';
import 'package:tp1/generated/l10n.dart';
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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Signin(),
    );
  }
}