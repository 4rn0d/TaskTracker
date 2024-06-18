import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

class Task {
  late String id;
  late String name;
  late int percentageDone;
  late int percentageTimeSpent;
  late DateTime deadline;
  late int photoId;

  Task({
    required this.id,
    required this.name,
    required this.percentageDone,
    required this.percentageTimeSpent,
    required this.deadline,
    required this.photoId,
  });

  @JsonKey(fromJson: _fromJson)
  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        percentageDone = json['percentageDone'],
        percentageTimeSpent = json['percentageTimeSpent'],
        deadline = _fromJson(json['deadline']),
        photoId = json['photoId'];

  factory Task.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
    ) {
      final data = snapshot.data();
      return Task(
          id: snapshot.id,
          name: data?['Name'],
          percentageDone: data?['Progression'],
          percentageTimeSpent: data?['TimeSpent'],
          deadline: data?['Deadline'].toDate(),
          photoId: data?['PhotoId']
      );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "Name": name,
      if (percentageDone != null) "Progression": percentageDone,
      if (percentageTimeSpent != null) "TimeSpent": percentageTimeSpent,
      if (deadline != null) "Deadline": deadline,
      if (photoId != null) "PhotoId": photoId,
    };
  }
}
final _dateFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");

DateTime _fromJson(String date) => _dateFormatter.parse(date);