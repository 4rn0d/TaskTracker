import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tp1/app/DTO/signup_request.dart';
import 'package:tp1/app/auth/signin.dart';
import 'package:tp1/app/home.dart';
import 'package:tp1/app/services/api_service.dart' as api;
import 'package:tp1/generated/l10n.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
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
          title: Text(S.of(context).title_signup),
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
                              labelText: S.of(context).hint_username,
                                errorText: _validateUsername ? S.of(context).validation_empty : null
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
                              labelText: S.of(context).hint_password,
                              errorText: _validatePassword ? S.of(context).validation_empty : null
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
                              labelText: S.of(context).hint_confirmPassword,
                                errorText: _validateConfPassword ? S.of(context).validation_empty :
                                !_validatePasswordsAreEqual ? S.of(context).validation_differentPasswords :
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
                                if (!_validatePassword && !_validateUsername && !_validateConfPassword){
                                  if (_passwordController.text == _confirmPasswordController.text) {
                                    var response = await api.signup(_usernameController.text, _passwordController.text);
                                    FirebaseAuth.instance
                                        .authStateChanges()
                                        .listen((User? user) {
                                      if (user == null) {
                                        setState(() {
                                          _isButtonDisabled = false;
                                        });
                                      } else {
                                        _isButtonDisabled = false;
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) => const Home(),
                                            )
                                        );
                                      }
                                    });
                                  }
                                }
                                _isButtonDisabled = false;
                              }on DioException catch (e) {
                                setState(() {
                                  _isButtonDisabled = false;
                                });
                                if (e.message!.contains('connection errored')) {
                                  var snackBar = SnackBar(
                                    content: Text(S.of(context).error_connection, style: const TextStyle(color: Colors.white),),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  return;
                                }
                                String message = e.response!.data;
                                if (message == "UsernameAlreadyTaken") {
                                  var snackBar = SnackBar(
                                    content: Text(S.of(context).error_usernameTaken, style: const TextStyle(color: Colors.white),),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                                else {
                                  print(message);
                                }
                              }
                            }: null,
                            child: Text(S.of(context).button_signup),
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
                            child: Text(S.of(context).button_login),
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