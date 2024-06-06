class Task {
  late int id;
  late String name;
  late int percentageDone;
  late double percentageTimeSpent;
  late String deadline;

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        percentageDone = json['percentageDone'],
        percentageTimeSpent = json['percentageTimeSpent'],
        deadline = json['deadline'];
}