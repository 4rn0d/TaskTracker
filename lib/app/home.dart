import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp1/app/models/task.dart';
import 'package:tp1/app/shared/menu.dart';
import 'package:tp1/app/services/api_service.dart' as api;
import 'package:tp1/app/task/create.dart';
import 'package:tp1/app/task/details.dart';

import '../generated/l10n.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {

  var tasks = [];

  void _getTasks() async{
    try {
      tasks = await api.getTasks();
      setState(() {});
    } catch(e){
      var snackBar = SnackBar(
        content: Text(
          S.of(context).error_connection,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(days: 365),
        action: SnackBarAction(
          label: S.of(context).error_tryAgain,
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
          title: Text(S.of(context)!.title_home),
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
                            Expanded(child: Text(tasks[i]['Name'], style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.check),
                                    Text("${S.of(context).task_progress}${tasks[i]['Progression']}%"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time),
                                    Text("${S.of(context).task_deadline}${DateFormat.yMMMMd(S.of(context).code).format(tasks[i]['Deadline'].toDate())}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.hourglass_bottom),
                                    Text("${S.of(context).task_timeProgression}${tasks[i]['TimeSpent']}%"),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: 75,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                      child: tasks[i]['PhotoId'] != 0 ? CachedNetworkImage(
                                        imageUrl: "${api.serverAddress}/file/${tasks[i]['PhotoId']}",
                                        placeholder: (context, url) => const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ): const Text("")
                                  ),
                                )
                              ],
                            )
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
