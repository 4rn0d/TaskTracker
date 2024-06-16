import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tp1/app/DTO/signin_request.dart';
import 'package:tp1/app/auth/signup.dart';
import 'package:tp1/app/home.dart';
import 'package:tp1/app/services/api_service.dart' as api;
import 'package:tp1/generated/l10n.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => SigninState();
}

class SigninState extends State<Signin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateUsername = false;
  bool _validatePassword = false;
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).title_login),
      ),
      body: SingleChildScrollView(
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
                          controller: _emailController,
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
                  Column(
                    children: [
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: !_isButtonDisabled ? () async {
                            try{
                              setState(() {
                                _isButtonDisabled = true;
                                _validateUsername = _emailController.text.isEmpty;
                                _validatePassword = _passwordController.text.isEmpty;
                              });
                              if (!_validatePassword && !_validateUsername) {
                                var response = await api.signin(_emailController.text, _passwordController.text);
                                FirebaseAuth.instance
                                    .authStateChanges()
                                    .listen((User? user) {
                                  if (user == null) {
                                    setState(() {
                                      _isButtonDisabled = false;
                                    });
                                  } else {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => const Home(),
                                        )
                                    );
                                  }
                                });
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
                            }
                          }: null,
                          child: Text(S.of(context).button_login),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      SizedBox(
                        child: OutlinedButton(
                          onPressed: !_isButtonDisabled ? () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Signup(),
                              )
                            );
                          }: null,
                          child: Text(S.of(context).button_signup,),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: (){
                api.getTasks();
              },
                  child: Text("testetstset")
              )
            ],
          ),
        ),
      )
    );
  }
}