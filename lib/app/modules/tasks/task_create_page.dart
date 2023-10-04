import 'package:flutter/material.dart';

import 'package:flutter_hands_on_todo_list_provider/app/modules/tasks/task_create_controler.dart';

class TaskCreatePage extends StatelessWidget {
  TaskCreateControler _controller;

  TaskCreatePage({
    Key? key,
    required TaskCreateControler controller,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}
