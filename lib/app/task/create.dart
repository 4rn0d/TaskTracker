import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp1/app/DTO/add_task.dart';
import 'package:tp1/app/home.dart';
import 'package:tp1/app/shared/menu.dart';
import 'package:tp1/app/services/api_service.dart' as api;

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => CreateState();
}

class CreateState extends State<Create> {
  final _taskNameController = TextEditingController();

  final RestorableDateTime _selectedDate =
  RestorableDateTime(DateTime.now());

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _taskNameController.dispose();
    super.dispose();
  }

  final _dateController = TextEditingController();
  bool _isButtonDisabled = false;
  bool _validateTaskName = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Menu(),
        appBar: AppBar(
          title: const Text('Création'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _taskNameController,
                              enabled: !_isButtonDisabled,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.title),
                                border: const OutlineInputBorder(),
                                labelText: 'Nom de la tâche',
                                errorText: _validateTaskName ? 'le champ ne peut pas être vide':null
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                                controller: _dateController,
                                enabled: !_isButtonDisabled,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.calendar_today),
                                    border: const OutlineInputBorder(),
                                    labelText:  DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate:DateTime.now(),
                                      lastDate: DateTime(2101)
                                  );
                                  if(pickedDate != null ){
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    setState(() {
                                      _dateController.text = formattedDate;
                                    });
                                  }else{
                                    print("Date is not selected");
                                  }
                                }
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                    onPressed: !_isButtonDisabled ?  () async {
                      try{
                        setState(() {
                          _isButtonDisabled = true;
                          _validateTaskName = _taskNameController.text.isEmpty;
                        });
                        if (!_validateTaskName) {
                          AddTask addTask = AddTask();
                          addTask.name = _taskNameController.text;
                          addTask.deadline = _dateController.text;
                          var response = await api.addTask(addTask);
                          _isButtonDisabled = false;
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            )
                          );
                        }
                        _isButtonDisabled = false;

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
                    child: const Text("Créer", style: TextStyle(color: Colors.white),)
                )
              ]
          ),
        ),
    );
  }
}

