import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter_hands_on_todo_list_provider/app/models/task_filter_enum.dart';
import 'package:flutter_hands_on_todo_list_provider/app/models/task_model.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/home_controller.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/widgets/task.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
          //---------------------------------------------------------------
          // Column(
          //   children:
          // context
          //       .select<HomeController, List<TaskModel>>(
          //           (controller) => controller.filteredTasks)
          //       .map(
          //         (task) => Task(
          //           model: task,
          //         ),
          //       )
          //       .toList(),
          // ),
          //---------------------------------------------------------------
          Column(
            children: context
                .select<HomeController, List<TaskModel>>(
                    (controller) => controller.filteredTasks)
                .map(
                  (task) => Container(
                    margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Slidable(
                      endActionPane: ActionPane(
                        extentRatio: 0.30,
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              onDeleteTask();
                            },
                            icon: Icons.delete,
                            borderRadius: BorderRadius.circular(20),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            label: "Deletar",
                          ),
                        ],
                      ),
                      child: Task(model: task),
                    ),
                  ),
                )
                .toList(),
          )
          //---------------------------------------------------------------
        ],
      ),
    );
  }
}

void onDeleteTask() {}
