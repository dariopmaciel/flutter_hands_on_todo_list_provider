import 'package:flutter_hands_on_todo_list_provider/app/models/task_model.dart';

class WeekTaskModel {
  final DateTime startDate;
  final DateTime enddate;
  final List<TaskModel> tasks;
  WeekTaskModel({
    required this.startDate,
    required this.enddate,
    required this.tasks,
  });
}
