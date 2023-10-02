import 'package:flutter_hands_on_todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/home_page.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(
          // bindings: null,
          routers: {
            '/home': (context) => const HomePage(),
          },
        );
}
