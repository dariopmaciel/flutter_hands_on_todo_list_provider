import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/todo_list_icons.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/widgets/home_filters.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/widgets/home_header.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/widgets/home_tasks.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/widgets/home_week_filter.dart';

import 'package:flutter_hands_on_todo_list_provider/app/modules/tasks/tasks_module.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goToCreateTask(BuildContext context) {
    // Navigator.of(context).pushNamed('/task/create');
    //
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        animation = CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
        return ScaleTransition(scale: animation, alignment: Alignment.bottomRight, child: child,);
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return TasksModule().getPage('/task/create', context);
      },
    )
        //ou assim
        // MaterialPageRoute(
        //     builder: (_) => TasksModule().getPage('/task/create', context)),

        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Home Page')),
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.primaryColor),
        backgroundColor: const Color(0XFFFAFBFE),
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: const Icon(TodoListIcons.filter),
            itemBuilder: (_) => [
              const PopupMenuItem<bool>(
                child: Text("Mostrar Tarefas Concluidas"),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primaryColor,
        onPressed: () => _goToCreateTask(context),
        child: const Icon(Icons.add),
      ),
      drawer: HomeDrawer(),
      backgroundColor: const Color(0XFFFAFBFE),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeHeader(),
                      HomeFilters(),
                      HomeWeekFilter(),
                      HomeTasks(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
