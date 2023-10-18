import 'package:flutter_hands_on_todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/home_controller.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/home_page.dart';
import 'package:flutter_hands_on_todo_list_provider/app/repositories/tasks/tasks_repository.dart';
import 'package:flutter_hands_on_todo_list_provider/app/repositories/tasks/tasks_repository_impl.dart';
import 'package:flutter_hands_on_todo_list_provider/app/services/tasks/tasks_service.dart';
import 'package:flutter_hands_on_todo_list_provider/app/services/tasks/tasks_service_impl.dart';
import 'package:provider/provider.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(
          bindings: [
            // duplicado de task_module.dart pois não acha o task service, pois é irmão e não filho
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
              //dá problema pque o HomeModule não acha o taskService
              //create: (context) => HomeController(tasksService: context.read()),
              create: (context) => HomeController(tasksService: context.read()),
            ),
          ],
          routers: {
            '/home': (context) =>  HomePage(homeController: context.read()),
          },
        );
}
