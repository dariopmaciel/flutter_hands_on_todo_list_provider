import 'package:flutter_hands_on_todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/tasks/task_create_controler.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/tasks/task_create_page.dart';
import 'package:flutter_hands_on_todo_list_provider/app/repositories/tasks/tasks_repository.dart';
import 'package:flutter_hands_on_todo_list_provider/app/repositories/tasks/tasks_repository_impl.dart';
import 'package:flutter_hands_on_todo_list_provider/app/services/tasks/tasks_service.dart';
import 'package:flutter_hands_on_todo_list_provider/app/services/tasks/tasks_service_impl.dart';

import 'package:provider/provider.dart';

class TasksModule extends TodoListModule {
  TasksModule()
      : super(
          bindings: [
            Provider<TasksRepository>(
              create: (context) => TasksRepositoryImpl(
                sqliteConnectionFactory: context.read(),
              ),
            ),
            Provider<TasksService>(
              create: (context) =>
                  TasksServiceImpl(tasksRepository: context.read()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  TaskCreateControler(tasksService: context.read()),
            )
          ],
          routers: {
            '/task/create': (context) => TaskCreatePage(
                  controller: context.read(),
                ),
          },
        );
}
