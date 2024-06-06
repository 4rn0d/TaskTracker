import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp1/app/DTO/add_task.dart';
import 'package:tp1/app/shared/menu.dart';
import 'package:tp1/app/services/api_service.dart' as api;

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => CreateState();
}

class CreateState extends State<Create> {
  final taskName = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    taskName.dispose();
    super.dispose();
  }

  DateTime? newDate = DateTime.now();

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: taskName,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nom de la tâche',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                              onPressed: () async {
                                newDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100, 12, 31),
                                  helpText: 'Select a date',
                                );
                              },
                              child: Text("${newDate?.day}/${newDate?.month}/${newDate?.year}", style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      try{
                        String formatedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(newDate!);
                        AddTask addTask = AddTask();
                        addTask.name = taskName.text;
                        addTask.deadline = formatedDate;
                        var response = api.addTask(addTask);
                        if (response != null){
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, '/home');
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
                    child: Text("Créer")
                )
              ]
          ),
        )
    );
  }
}

