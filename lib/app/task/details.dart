import 'package:flutter/material.dart';
import 'package:tp1/app/shared/menu.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => DetailsState();
}

class DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Menu(),
        appBar: AppBar(
          title: const Text('Details'),
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