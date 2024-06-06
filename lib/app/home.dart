import 'package:flutter/material.dart';
import 'package:tp1/app/models/task.dart';
import 'package:tp1/app/shared/menu.dart';
import 'package:tp1/app/services/api_service.dart' as api;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {

  List<Task> tasks = [];

  void getTasks() async{
    try {
      tasks = await api.getTasks();
      setState(() {});
    }catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Erreur reseau')));
    }
  }

  @override
  void initState() {
    super.initState();
    getTasks();
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
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/create');
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, i){
              return Card(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/details');
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
                            Text("Progression de la tâche : ${tasks[i].percentageDone}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Date d'échéance : ${tasks[i].deadline}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("pourcentage de temp écoulé : ${tasks[i].percentageTimeSpent}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ),
    );
  }
}
