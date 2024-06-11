import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1/app/DTO/signup_request.dart';
import 'package:tp1/app/auth/signin.dart';
import 'package:tp1/app/home.dart';
import 'package:tp1/app/services/api_service.dart' as api;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  SignupRequest signupRequest = SignupRequest();
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username.dispose();
    password.dispose();
    super.dispose();
  }

  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: !api.isLoading
        ? Padding(
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
                          controller: username,
                          obscureText: false,
                          enabled: !_isButtonDisabled,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
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
                          controller: password,
                          enabled: !_isButtonDisabled,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
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
                          obscureText: true,
                          enabled: !_isButtonDisabled,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Confirm Password',
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
                              });
                              signupRequest.username = username.text;
                              signupRequest.password = password.text;
                              var response = await api.signup(signupRequest);
                              if (response.username != null){
                                _isButtonDisabled = false;
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const Home(),
                                    )
                                );
                              }
                            }on DioException catch (e) {
                              print(e);
                              String message = e.response!.data;
                              if (message == "BadCredentialsException") {
                                print('login deja utilise');
                              } else {
                                print('autre erreurs');
                              }
                            }
                          }: null,
                          child: const Text('Signup', style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: !_isButtonDisabled ? () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Signin(),
                              )
                            );
                          }: null,
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ):
            const LinearProgressIndicator()
    );
  }
}