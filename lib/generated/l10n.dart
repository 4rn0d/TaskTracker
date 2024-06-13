// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `en`
  String get code {
    return Intl.message(
      'en',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get title_login {
    return Intl.message(
      'Login',
      name: 'title_login',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get hint_username {
    return Intl.message(
      'Username',
      name: 'hint_username',
      desc: '',
      args: [],
    );
  }

  /// `The field cannot be empty`
  String get validation_empty {
    return Intl.message(
      'The field cannot be empty',
      name: 'validation_empty',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get hint_password {
    return Intl.message(
      'Password',
      name: 'hint_password',
      desc: '',
      args: [],
    );
  }

  /// `A connection error as occured`
  String get error_connection {
    return Intl.message(
      'A connection error as occured',
      name: 'error_connection',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get button_login {
    return Intl.message(
      'Login',
      name: 'button_login',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get button_signup {
    return Intl.message(
      'Signup',
      name: 'button_signup',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get title_signup {
    return Intl.message(
      'Sign Up',
      name: 'title_signup',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get hint_confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'hint_confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `The passwords do not match`
  String get validation_differentPasswords {
    return Intl.message(
      'The passwords do not match',
      name: 'validation_differentPasswords',
      desc: '',
      args: [],
    );
  }

  /// `The username is already taken`
  String get error_usernameTaken {
    return Intl.message(
      'The username is already taken',
      name: 'error_usernameTaken',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get title_home {
    return Intl.message(
      'Home',
      name: 'title_home',
      desc: '',
      args: [],
    );
  }

  /// `Task progression : `
  String get task_progress {
    return Intl.message(
      'Task progression : ',
      name: 'task_progress',
      desc: '',
      args: [],
    );
  }

  /// `Deadline : `
  String get task_deadline {
    return Intl.message(
      'Deadline : ',
      name: 'task_deadline',
      desc: '',
      args: [],
    );
  }

  /// `Time progression : `
  String get task_timeProgression {
    return Intl.message(
      'Time progression : ',
      name: 'task_timeProgression',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get error_tryAgain {
    return Intl.message(
      'Try again',
      name: 'error_tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `New task`
  String get title_create {
    return Intl.message(
      'New task',
      name: 'title_create',
      desc: '',
      args: [],
    );
  }

  /// `Task name`
  String get hint_taskName {
    return Intl.message(
      'Task name',
      name: 'hint_taskName',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get button_create {
    return Intl.message(
      'Create',
      name: 'button_create',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get title_details {
    return Intl.message(
      'Details',
      name: 'title_details',
      desc: '',
      args: [],
    );
  }

  /// `Update task`
  String get button_update {
    return Intl.message(
      'Update task',
      name: 'button_update',
      desc: '',
      args: [],
    );
  }

  /// `Signout`
  String get title_signout {
    return Intl.message(
      'Signout',
      name: 'title_signout',
      desc: '',
      args: [],
    );
  }

  /// `Task's name :`
  String get task_name {
    return Intl.message(
      'Task\'s name :',
      name: 'task_name',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
