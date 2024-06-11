import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

class Task {
  late int id;
  late String name;
  late int percentageDone;
  late int percentageTimeSpent;
  late DateTime deadline;
  late int photoId;

  @JsonKey(fromJson: _fromJson)
  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        percentageDone = json['percentageDone'],
        percentageTimeSpent = json['percentageTimeSpent'],
        deadline = _fromJson(json['deadline']),
        photoId = json['photoId'];
}
final _dateFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");

DateTime _fromJson(String date) => _dateFormatter.parse(date);