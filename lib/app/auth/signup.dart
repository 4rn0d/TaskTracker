import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1/app/DTO/signup_request.dart';
import 'package:tp1/app/auth/signin.dart';
import 'package:tp1/app/home.dart';
import 'package:tp1/app/services/api_service.dart' as api;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tp1/app/utils/app_theme.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  SignupRequest signupRequest = SignupRequest();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validateUsername = false;
  bool _validatePassword = false;
  bool _validateConfPassword = false;
  bool _validatePasswordsAreEqual = true;
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.title_signup),
        ),
        body: !api.isLoading
        ? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column( //text fields
                  children: [
                    Row( //username field
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _usernameController,
                            obscureText: false,
                            enabled: !_isButtonDisabled,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: AppLocalizations.of(context)!.hint_username,
                                errorText: _validateUsername ? AppLocalizations.of(context)!.validation_empty : null
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    Row( //password field
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _passwordController,
                            enabled: !_isButtonDisabled,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: AppLocalizations.of(context)!.hint_password,
                              errorText: _validatePassword ? AppLocalizations.of(context)!.validation_empty : null
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    Row( //password field
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            enabled: !_isButtonDisabled,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: AppLocalizations.of(context)!.hint_confirmPassword,
                                errorText: _validateConfPassword ? AppLocalizations.of(context)!.validation_empty :
                                !_validatePasswordsAreEqual ? AppLocalizations.of(context)!.validation_differentPasswords :
                                    null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: !_isButtonDisabled ? () async {
                              try{
                                setState(() {
                                  _isButtonDisabled = true;
                                  _validateUsername = _usernameController.text.isEmpty;
                                  _validatePassword = _passwordController.text.isEmpty;
                                  _validateConfPassword = _confirmPasswordController.text.isEmpty;
                                  if (_passwordController.text == _confirmPasswordController.text){
                                    _validatePasswordsAreEqual = true;
                                  }
                                  else{
                                   _validatePasswordsAreEqual = false;
                                  }
                                });
                                signupRequest.username = _usernameController.text;
                                signupRequest.password = _passwordController.text;
                                if (!_validatePassword && !_validateUsername && !_validateConfPassword){
                                  if (_passwordController.text == _confirmPasswordController.text) {
                                    var response = await api.signup(signupRequest);
                                    if (response.username != null){
                                      _isButtonDisabled = false;
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => const Home(),
                                          )
                                      );
                                    }
                                  }
                                }
                                _isButtonDisabled = false;
                              }on DioException catch (e) {
                                setState(() {
                                  _isButtonDisabled = false;
                                });
                                if (e.message!.contains('connection errored')) {
                                  var snackBar = SnackBar(
                                    content: Text(AppLocalizations.of(context)!.error_connection, style: const TextStyle(color: Colors.white),),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  return;
                                }
                                String message = e.response!.data;
                                if (message == "UsernameAlreadyTaken") {
                                  var snackBar = SnackBar(
                                    content: Text(AppLocalizations.of(context)!.error_usernameTaken, style: const TextStyle(color: Colors.white),),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                                else {
                                  print(message);
                                }
                              }
                            }: null,
                            child: Text(AppLocalizations.of(context)!.button_signup),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        SizedBox(
                          child: OutlinedButton(
                            onPressed: !_isButtonDisabled ? () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const Signin(),
                                )
                              );
                            }: null,
                            child: Text(AppLocalizations.of(context)!.button_login),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ):
            const LinearProgressIndicator()
    );
  }
}