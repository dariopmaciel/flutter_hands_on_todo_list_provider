import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/widget/todo_list_field.dart';

import 'package:flutter_hands_on_todo_list_provider/app/modules/tasks/task_create_controler.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/tasks/widget/calendar_button.dart';
import 'package:validatorless/validatorless.dart';

class TaskCreatePage extends StatelessWidget {
  final TaskCreateControler _controller;
  final _descriptionEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TaskCreatePage({Key? key, required TaskCreateControler controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //remove botão de voltar
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: context.primaryColor,
        onPressed: () {
          final formvalid = _formKey.currentState?.validate() ??false;
          if (formvalid) {
            _controller.save(_descriptionEC.text);            
          }
        },
        label: const Text(
          'Salvar Task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Criar Tarefa",
                  style: context.titleStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TodoListField(
                label: '',
                controller: _descriptionEC,
                validator: Validatorless.required("* Obrigatorio!"),
              ),
              const SizedBox(height: 20),
              CalendarButton(),
            ],
          ),
        ),
      ),
    );
  }

@override
List<Object?> get props => [_controller, _descriptionEC, _formKey];
}
