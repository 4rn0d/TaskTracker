import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp1/app/home.dart';
import 'package:tp1/app/models/task.dart';
import 'package:tp1/app/shared/menu.dart';
import 'package:tp1/app/services/api_service.dart' as api;

class Details extends StatefulWidget {

  final int id;

  const Details({super.key, required this.id});

  @override
  State<Details> createState() => DetailsState();
}

class DetailsState extends State<Details> {
  Task task = Task(id: 0, name: "",  percentageDone: 0, percentageTimeSpent: 0, deadline: DateTime.now());
  double currentSliderValue = 0;

  void _getDetails() async{
    try {
      task = await api.getDetail(widget.id);
      currentSliderValue = task.percentageDone.toDouble();
      setState(() {});
    }catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Erreur reseau')));
    }
  }

  @override
  void initState() {
    _getDetails();
    super.initState();
  }

  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: !api.isLoading
      ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nom : ${task.name}"),
                Text("Deadline : ${DateFormat.yMMMMd().format(task.deadline)}"),
                Text("Pourcentage de temps écoulé : ${task.percentageTimeSpent.round()}%"),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: currentSliderValue,
                        max: 100,
                        divisions: 100,
                        label: currentSliderValue.round().toString(),
                        onChanged: !_isButtonDisabled ?(double value) {
                          setState(() {
                            currentSliderValue = value;
                          });
                        }: null
                      )
                    ),
                    Text("${currentSliderValue.round()}%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                      onPressed: !_isButtonDisabled ?  () async{
                        try {
                          setState(() {
                            _isButtonDisabled = true;
                          });
                          var response = await api.update(widget.id, currentSliderValue.toInt());
                          _isButtonDisabled = false;
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Home(),
                              )
                          );
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
                      child: const Text("Mise à jour du progrès", style: TextStyle(color: Colors.white),)
                    )
                  ],
                )
              ]
            ),
          ),
        ),
      ):
          const LinearProgressIndicator()
    );
  }
}