import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1/app/DTO/signin_request.dart';
import 'package:tp1/app/auth/signup.dart';
import 'package:tp1/app/home.dart';
import 'package:tp1/app/services/api_service.dart' as api;

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => SigninState();
}

class SigninState extends State<Signin> {
  SigninRequest signinRequest = SigninRequest();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();
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
        title: const Text('Login'),
      ),
      body: Padding(
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
                        enabled: !_isButtonDisabled,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                            errorText: _validateUsername ? "Le champ ne peut pas être vide" : null
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
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                            errorText: _validatePassword ? "Le champ ne peut pas être vide" : null
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
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                        onPressed: !_isButtonDisabled ? () async {
                          try{
                            setState(() {
                              _isButtonDisabled = true;
                              _validateUsername = _usernameController.text.isEmpty;
                              _validatePassword = _passwordController.text.isEmpty;
                            });
                            signinRequest.username = _usernameController.text;
                            signinRequest.password = _passwordController.text;
                            if (!_validatePassword && !_validateUsername) {
                              var response = await api.signin(signinRequest);
                              if (response.username != null){
                                _isButtonDisabled = false;
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  )
                                );
                              }
                            }
                            _isButtonDisabled = false;
                          }on DioException catch (e) {
                            setState(() {
                              _isButtonDisabled = false;
                            });
                            if (e.message!.contains('connection errored')) {
                              var snackBar = const SnackBar(
                                content: Text("Une erreur réseau est survenue.", style: TextStyle(color: Colors.white),),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              return;
                            }
                          }
                        }: null,
                        child: const Text('Login', style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: !_isButtonDisabled ? () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Signup(),
                            )
                          );
                        }: null,
                        child: const Text('Signup'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}