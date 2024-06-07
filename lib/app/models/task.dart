import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

class Task {
  late int id = 0;
  late String name = "";
  late int percentageDone = 0;
  late double percentageTimeSpent = 0;
  late DateTime deadline = DateTime.now();

  Task({
    required this.id,
    required this.name,
    required this.percentageDone,
    required this.percentageTimeSpent,
    required this.deadline,
  });

  @JsonKey(fromJson: _fromJson)
  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        percentageDone = json['percentageDone'],
        percentageTimeSpent = json['percentageTimeSpent'],
        deadline = _fromJson(json['deadline']);
}
final _dateFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");

DateTime _fromJson(String date) => _dateFormatter.parse(date);