import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({super.key});

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
          contentPadding: EdgeInsets.all(8),
          leading: Checkbox(
            value: true,
            onChanged: (value) {},
          ),
          title: const Text(
            'Descrição da Tarefa',
            style:
                TextStyle(decoration: true ? TextDecoration.lineThrough : null),
          ),
          subtitle: const Text(
            '03/10/2023',
            style:
                TextStyle(decoration: true ? TextDecoration.lineThrough : null),
          ),
        ),
      ),
    );
  }
}
