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

  bool isButtonDisabled = false;

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
                      child: !isButtonDisabled
                      ? Slider(
                        value: currentSliderValue,
                        max: 100,
                        divisions: 100,
                        label: currentSliderValue.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            currentSliderValue = value;
                          });
                        },
                      ):
                      Slider(
                        value: currentSliderValue,
                        max: 100,
                        divisions: 100,
                        label: currentSliderValue.round().toString(),
                        onChanged: null,
                      )
                    ),
                    Text("${currentSliderValue.round()}%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !isButtonDisabled
                    ? ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                      onPressed: () async{
                        try {
                          setState(() {
                            isButtonDisabled = true;
                          });
                          var response = await api.update(widget.id, currentSliderValue.toInt());
                          isButtonDisabled = false;
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Home(),
                              )
                          );
                        }catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text('Erreur reseau')));
                        }
                      },
                      child: const Text("Mise à jour du progrès", style: TextStyle(color: Colors.white),)
                    ):
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                        onPressed: (){},
                        child: const Text("Mise à jour du progrès", style: TextStyle(color: Colors.grey),)
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