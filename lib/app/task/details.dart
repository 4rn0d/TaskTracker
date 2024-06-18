import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tp1/app/home.dart';
import 'package:tp1/app/models/task.dart' as model;
import 'package:tp1/app/shared/menu.dart';
import 'package:tp1/app/services/api_service.dart' as api;
import 'package:tp1/generated/l10n.dart';

class Details extends StatefulWidget {

  final String id;

  const Details({super.key, required this.id});

  @override
  State<Details> createState() => DetailsState();
}

class DetailsState extends State<Details> {
  late model.Task task = model.Task(id: "loading", name: "", percentageDone: 0, creationDate: DateTime.now(), deadline: DateTime.now(), imageURL: 'none');
  double currentSliderValue = 0;

  void _getDetails() async{
    try {
      task = (await api.getDetail(widget.id))!;
      print(task.name);
      currentSliderValue = task.percentageDone.toDouble();
      print(currentSliderValue);
      setState(() {});
    }catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(S.of(context).error_connection)));
      print(e);
    }
  }
  var _imageFile;

  @override
  void initState() {
    super.initState();
    photo = task.imageURL;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getDetails();
    });

  }

  bool _isButtonDisabled = false;
  final picker = ImagePicker();
  String photo = '';

  Future _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);

      User? user = FirebaseAuth.instance.currentUser;
      final imageDoc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).collection("tasks").doc(task.id);
      final imageRef = FirebaseStorage.instance.ref('${imageDoc.id}.jpg');
      await imageRef.putFile(_imageFile);
      String imageURL = await imageRef.getDownloadURL();
      await imageDoc.update({
        'ImageURL': imageURL
      });
      setState(() {
        photo = imageURL;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: Text(S.of(context).title_details),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        child: const Icon(Icons.add_a_photo),
      ),
      body: task.id != "loading"
      ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${S.of(context).task_name}${task.name}"),
              Text("${S.of(context).task_deadline}${DateFormat.yMMMMd(S.of(context).code).format(task.deadline)}"),
              Text("${S.of(context).task_timeProgression}${task.getTimeSpent()}%"),
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
                          var snackBar = SnackBar(
                            content: Text(S.of(context).error_connection,),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                      }
                    }: null,
                    child: Text(S.of(context).button_update, style: const TextStyle(color: Colors.white),)
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Center(
                child: SizedBox(
                  height: 250,
                  child: task.imageURL != 'none' ? CachedNetworkImage(
                    imageUrl: photo == 'none' ? task.imageURL: photo,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ): const Text("")
                ),
              )
            ]
          ),
        ),
      ):
          const LinearProgressIndicator()
    );
  }
}