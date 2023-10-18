import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/models/task_model.dart';
import 'package:intl/intl.dart';

class Task extends StatelessWidget {
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/y');

  Task({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.green,
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              width: 1,
            ),
          ),
          contentPadding: const EdgeInsets.all(8),
          leading: Checkbox(
            value: model.finished,
            onChanged: (value) {},
          ),
          title: Text(
            model.description,
            style:
                TextStyle(decoration: model.finished ? TextDecoration.lineThrough : null),
          ),
          subtitle: Text(
            dateFormat.format(model.dateTime),
            style:
                TextStyle(decoration: model.finished ? TextDecoration.lineThrough : null),
          ),
        ),
      ),
    );
  }
}
