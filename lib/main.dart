import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:json_theme/json_theme.dart';
import 'package:tp1/app/task/create.dart';
import 'package:tp1/app/task/details.dart';
import 'package:tp1/app/utils/app_theme.dart';
import 'package:tp1/generated/l10n.dart';
import 'app/auth/signin.dart';
import 'app/auth/signup.dart';
import 'app/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr = await rootBundle.loadString("lib/app/assets/themes/appainter_theme.json");
  final themeJson = jsonDecode(themeStr);
  final ThemeData theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Signin(),
    );
  }
}