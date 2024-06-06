import 'package:flutter/material.dart';
import 'package:tp1/app/shared/menu.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => CreateState();
}

class CreateState extends State<Create> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Menu(),
        appBar: AppBar(
          title: const Text('Création'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("test"),
              ]
          ),
        )
    );
  }
}