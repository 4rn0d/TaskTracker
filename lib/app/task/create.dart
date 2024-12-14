import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp1/app/DTO/add_task.dart';
import 'package:tp1/app/home.dart';
import 'package:tp1/app/shared/menu.dart';
import 'package:tp1/app/services/api_service.dart' as api;
import 'package:tp1/generated/l10n.dart';

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
          title: Text(S.of(context).title_create),
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
                                labelText: S.of(context).hint_taskName,
                                errorText: _validateTaskName ? S.of(context).validation_empty:null
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
                                    labelText:  DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 1))),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now().add(const Duration(days: 1)),
                                    firstDate:DateTime.now().add(const Duration(days: 1)),
                                    lastDate: DateTime(2101)
                                  );
                                  if(pickedDate != null ){
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    setState(() {
                                      _dateController.text = formattedDate;
                                    });
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
                    onPressed: !_isButtonDisabled ?  () async {
                      try{
                        setState(() {
                          _isButtonDisabled = true;
                          _validateTaskName = _taskNameController.text.isEmpty;
                        });
                        if (!_validateTaskName) {
                          AddTask addTask = AddTask();
                          addTask.name = _taskNameController.text;
                          if (_dateController.text == ""){
                            addTask.deadline = DateFormat('yyyy-MM-dd').format(DateTime.now());
                          }
                          else{
                            addTask.deadline = _dateController.text;
                          }
                          try{
                            var response = await api.addTask(addTask);
                            _isButtonDisabled = false;
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                )
                            );
                          } on Exception catch(e){
                            setState(() {
                              _isButtonDisabled = false;
                            });
                            var snackBar = SnackBar(
                              content: Text(
                                e.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
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
                        print(e);
                      }
                    }: null,
                    child: Text(S.of(context).button_create)
                )
              ]
          ),
        ),
    );
  }
}

