import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  Task? task;
  double currentSliderValue = 0;

  void _getDetails() async{
    try {
      task = await api.getDetail(widget.id);
      currentSliderValue = task!.percentageDone.toDouble();
      setState(() {});
    }catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Erreur reseau')));
    }
  }
  var _imageFile;

  @override
  void initState() {
    _getDetails();
    super.initState();
  }

  bool _isButtonDisabled = false;
  final picker = ImagePicker();

  Future<String> _sendPicture(int taskID, File file) async {
    FormData formData = FormData.fromMap({
      "taskID": taskID,
      "file": await MultipartFile.fromFile(file.path, filename: "image.jpg")
    });
    var url = "${api.serverAddress}/file";
    var response = await Dio().post(url, data: formData);
    print(response.data);
    return response.data;
  }

  Future _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      setState(() {});
      print(
          "debut de l'envoi , pensez a indiquer a l'utilisateur que ca charge ${DateTime.now()}");
      _sendPicture(task!.id, _imageFile).then((res) {
        setState(() {
          task!.photoId = int.parse(res);
        });
      }).catchError((err) {
        print(err);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: const Text('Details'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
      body: !api.isLoading
      ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nom : ${task!.name}"),
                Text("Deadline : ${DateFormat.yMMMMd().format(task!.deadline)}"),
                Text("Pourcentage de temps écoulé : ${task!.percentageTimeSpent.round()}%"),
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
                ),
                Center(
                  child: SizedBox(
                    height: 250,
                    child: task!.photoId != 0 ? CachedNetworkImage(
                      imageUrl: "${api.serverAddress}/file/${task!.photoId}",
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ): const Text("")
                  ),
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