class AddTask{
  late String name;
  late String deadline;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'deadline': deadline,
    };
  }
}