import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/widgets/task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(
            "TAREFAS DE HOJE",
            style: context.titleStyle.copyWith(fontSize: 16),
          ),
          const Column(
            children: [
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),Task(),
            ],
          )
        ],
      ),
    );
  }
}
