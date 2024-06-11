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
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username.dispose();
    password.dispose();
    super.dispose();
  }

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
                        controller: username,
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
                Column(
                  children: [
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                        onPressed: () async {
                          try{
                            setState(() {
                              api.isLoading = true;
                            });
                            signinRequest.username = username.text;
                            signinRequest.password = password.text;
                            var response = await api.signin(signinRequest);
                            if (response.username != null){
                              api.isLoading = false;
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
                        },
                        child: const Text('Login', style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Signup(),
                            )
                          );
                        },
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