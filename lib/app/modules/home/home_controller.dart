import 'package:flutter_hands_on_todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:flutter_hands_on_todo_list_provider/app/models/task_filter_enum.dart';

class HomeController extends DefaultChangeNotifier {
  var filterSelected = TaskFilterEnum.today;
}
