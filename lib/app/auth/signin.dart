import 'package:flutter/material.dart';
import 'package:tp1/app/utils/app_theme.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => SigninState();
}

class SigninState extends State<Signin> {
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
                const Row( //username field
                  children: [
                    Expanded(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
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
                const Row( //password field
                  children: [
                    Expanded(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
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
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, '/home');
                        },
                        child: const Text('Login', style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, '/signup');
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