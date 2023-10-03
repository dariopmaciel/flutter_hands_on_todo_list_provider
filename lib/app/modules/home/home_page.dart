import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/todo_list_icons.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/widgets/home_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Home Page')),
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.primaryColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: Icon(TodoListIcons.filter),
            itemBuilder: (_) => [
              const PopupMenuItem<bool>(child: Text("Mostrar Tarefas Concluidas"))
            ],
          )
        ],
      ),
      drawer: HomeDrawer(),
      backgroundColor: Color(0XFFFAFBFE),
      body: Container(),
    );
  }
}
