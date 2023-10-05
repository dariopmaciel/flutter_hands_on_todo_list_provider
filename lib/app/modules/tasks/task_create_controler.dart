import 'package:flutter_hands_on_todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:flutter_hands_on_todo_list_provider/app/services/tasks/tasks_service.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class TaskCreateControler extends DefaultChangeNotifier {
  final TasksService _tasksService;
  DateTime? _selectedDate;

  TaskCreateControler({required TasksService tasksService})
      : _tasksService = tasksService;

  set selectedDate(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  void save(String description) {
    
  }
}
