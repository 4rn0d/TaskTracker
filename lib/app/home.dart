import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp1/app/models/task.dart';
import 'package:tp1/app/shared/menu.dart';
import 'package:tp1/app/services/api_service.dart' as api;
import 'package:tp1/app/task/create.dart';
import 'package:tp1/app/task/details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {

  List<Task> tasks = [];

  void _getTasks() async{
    try {
      tasks = await api.getTasks();
      setState(() {});
    } catch(e){
      var snackBar = SnackBar(
        content: const Text("Une erreur réseaux est survenue.", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
        duration: const Duration(days: 365),
        action: SnackBarAction(
        label: 'Réessayer',
        onPressed: () {
          _getTasks();
        },
      ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    _getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Menu(),
        appBar: AppBar(
          title: const Text('Accueil'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Create(),
                )
            );
          },
          child: const Icon(Icons.add),
        ),
        body: !api.isLoading
        ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, i){
              return Card(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Details(
                          id: tasks[i].id,
                        ),
                      )
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(tasks[i].name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Progression de la tâche : ${tasks[i].percentageDone}%"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Date d'échéance : ${DateFormat.yMMMMd().format(tasks[i].deadline)}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("pourcentage de temp écoulé : ${tasks[i].percentageTimeSpent.round()}%"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ):
            const LinearProgressIndicator()
    );
  }
}
