import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

class Task {
  late String id;
  late String name;
  late int percentageDone;
  late DateTime creationDate;
  late DateTime deadline;
  late String imageURL;

  Task({
    required this.id,
    required this.name,
    required this.percentageDone,
    required this.creationDate,
    required this.deadline,
    required this.imageURL,
  });

  int getTimeSpent() {
    if (DateTime.now().isAfter(deadline)) {
      return 100;
    }
    int total = deadline.compareTo(creationDate);
    int spent = creationDate.compareTo(deadline);
    double percentage = 100.0 * spent / total;
    return max(percentage.toInt(), 0);
  }

  @JsonKey(fromJson: _fromJson)
  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        percentageDone = json['percentageDone'],
        creationDate = _fromJson(json['CreationDate']),
        deadline = _fromJson(json['deadline']),
        imageURL = json['ImageURL'];

  factory Task.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
    ) {
      final data = snapshot.data();
      return Task(
          id: snapshot.id,
          name: data?['Name'],
          percentageDone: data?['Progression'],
          deadline: data?['Deadline'].toDate(),
          creationDate: data?['CreationDate'].toDate(),
          imageURL: data?['ImageURL']
      );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "Name": name,
      "Progression": percentageDone,
      "CreationDate": creationDate,
      "Deadline": deadline,
      "ImageURL": imageURL,
    };
  }
}
final _dateFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");

DateTime _fromJson(String date) => _dateFormatter.parse(date);