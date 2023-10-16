import 'package:flutter_hands_on_todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:flutter_hands_on_todo_list_provider/app/models/task_filter_enum.dart';
import 'package:flutter_hands_on_todo_list_provider/app/models/task_model.dart';
import 'package:flutter_hands_on_todo_list_provider/app/models/total_tasks_model.dart';
import 'package:flutter_hands_on_todo_list_provider/app/models/week_task_model.dart';
import 'package:flutter_hands_on_todo_list_provider/app/services/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  var filterSelected = TaskFilterEnum.today;
  TotalTasksModel? toDayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;

  HomeController({
    required TasksService tasksService,
  }) : _tasksService = tasksService;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek(),
    ]);

    final toDayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    toDayTotalTasks = TotalTasksModel(
        totalTasks: toDayTasks.length,
        totalTasksFinisk: toDayTasks.where((task) => task.finished).length);

    tomorrowTotalTasks = TotalTasksModel(
        totalTasks: tomorrowTasks.length,
        totalTasksFinisk: tomorrowTasks.where((task) => task.finished).length);

    weekTotalTasks = TotalTasksModel(
        totalTasks: weekTasks.tasks.length,
        totalTasksFinisk:
            weekTasks.tasks.where((task) => task.finished).length);

    notifyListeners();
  }
}
