import 'package:flutter_hands_on_todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:flutter_hands_on_todo_list_provider/app/services/tasks/tasks_service.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class TaskCreateControler extends DefaultChangeNotifier {
  final TasksService _tasksService;
  DateTime? _selectedDate;

  TaskCreateControler({required TasksService tasksService})
      : _tasksService = tasksService;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (_selectedDate != null) {
        await _tasksService.save(_selectedDate!, description);
        success();
      } else {
        setError("Data da tarefa não selecionada");
      }
    } catch (e, s) {
      print(e);
      print(s);
      setError('Erro ao cadastrar Tarefa');
    }finally{
      hideLoading();
      notifyListeners();
    }
  }
}
