import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter_hands_on_todo_list_provider/app/models/task_filter_enum.dart';
import 'package:flutter_hands_on_todo_list_provider/app/models/task_model.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/home_controller.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/widgets/task.dart';
import 'package:provider/provider.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Selector<HomeController, String>(
            selector: (context, controller) {
              return controller.filterSelected.description;
            },
            builder: (context, value, child) {
              return Text(
                "TAREFAS $value",
                style: context.titleStyle.copyWith(fontSize: 16),
              );
            },
          ),
          Column(
            children: context
                .select<HomeController, List<TaskModel>>(
                    (controller) => controller.filteredTasks)
                .map((task) => Task(model: task,))
                .toList(),
          )
        ],
      ),
    );
  }

  // @override
  // List<Object?> get props => [];

  // @override
  // String toString() {
  //   return 'HomeTasks{}';
  // }
}
