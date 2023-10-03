import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';

class TodoCardFilter extends StatefulWidget {
  const TodoCardFilter({super.key});

  @override
  State<TodoCardFilter> createState() => _TodoCardFilterState();
}

class _TodoCardFilterState extends State<TodoCardFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 120, maxWidth: 150),
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: context.primaryColor,
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(0.8),
          ),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "10 Tarefas",
            style: context.titleStyle.copyWith(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          const Text(
            "Hoje",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.red.withOpacity(0.5),
            value: 0.4,
            valueColor: const AlwaysStoppedAnimation<Color>(
              Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
