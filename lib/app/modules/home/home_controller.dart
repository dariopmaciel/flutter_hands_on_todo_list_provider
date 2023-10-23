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
  bool showFinishingTasks = false;

  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  //Variavel criada para que inicie em data específica
  DateTime? initialDateOfWeek;
  DateTime? selectedDay;

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
      totalTasksFinisk: toDayTasks.where((task) => task.finished).length,
    );

    tomorrowTotalTasks = TotalTasksModel(
      totalTasks: tomorrowTasks.length,
      totalTasksFinisk: tomorrowTasks.where((task) => task.finished).length,
    );

    weekTotalTasks = TotalTasksModel(
      totalTasks: weekTasks.tasks.length,
      totalTasksFinisk: weekTasks.tasks.where((task) => task.finished).length,
    );
    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekModel = await _tasksService.getWeek();
        //faz com que o primiro dia da semana seja o que for definido em 'initialDateOfWeek' que deve ser formatado e acertado em home_week_filter
        initialDateOfWeek = weekModel.startDate;
        tasks = weekModel.tasks;
        break;
      // default:
    }
    filteredTasks = tasks;
    allTasks = tasks;
    if (filter == TaskFilterEnum.week) {
      if (selectedDay != null) {
        filterByday(selectedDay!);
      } else if (initialDateOfWeek != null) {
        //Metodo que ira selecionar o dia setado
        filterByday(initialDateOfWeek!);
      }
    } else {
      selectedDay = null;
    }
    hideLoading();
    notifyListeners();
  }

  void filterByday(DateTime date) async {
    selectedDay = date;
    filteredTasks = allTasks.where((task) {
      return task.dateTime == date; //ou 'selectedDay' pois ambos são iguais;
    }).toList();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: filterSelected);
    await loadTotalTasks();
    notifyListeners();
  }

  Future<void> checkOrUncheckTask(TaskModel task) async {
    showLoadingAndResetState();
    notifyListeners();
    final taskUpdate = task.copyWith(finished: !task.finished);
    await _tasksService.checkOrUncheckTask(taskUpdate);
    hideLoading();
    refreshPage();
  }

  void showOrHideFinishingTask(){
    showFinishingTasks = true;
    
  }

}
