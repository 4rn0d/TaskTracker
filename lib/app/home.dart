import 'package:flutter/material.dart';
import 'package:tp1/app/shared/menu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Menu(),
        appBar: AppBar(
          title: const Text('Accueil'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/create');
          },
          child: Icon(Icons.add),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/details');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Tâche 1", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Progression de la tâche : 90%"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Date d'échéance : 09-12-2025"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("va te pendre"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
    );
  }
}