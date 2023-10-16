// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/app_widget.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:flutter_hands_on_todo_list_provider/app/repositories/tasks/tasks_repository.dart';
import 'package:flutter_hands_on_todo_list_provider/app/repositories/tasks/tasks_repository_impl.dart';
import 'package:flutter_hands_on_todo_list_provider/app/repositories/user/user_repository.dart';
import 'package:flutter_hands_on_todo_list_provider/app/repositories/user/user_repository_impl.dart';
import 'package:flutter_hands_on_todo_list_provider/app/services/tasks/tasks_service.dart';
import 'package:flutter_hands_on_todo_list_provider/app/services/tasks/tasks_service_impl.dart';
import 'package:flutter_hands_on_todo_list_provider/app/services/user/user_service.dart';
import 'package:flutter_hands_on_todo_list_provider/app/services/user/user_service_impl.dart';
import 'package:provider/provider.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    //'MultiProvider' SEMPRE precisa de um objeto para iniciar
    return MultiProvider(
      providers: [
        //---------------------------------------------------------------
        // Provider<TasksRepository>(
        //   create: (context) => TasksRepositoryImpl(
        //     sqliteConnectionFactory: context.read(),
        //   ),
        // ),
        // Provider<TasksService>(
        //   create: (context) =>
        //       TasksServiceImpl(tasksRepository: context.read()),
        // ),
        //---------------------------------------------------------------
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false,
        ),
        Provider<UserRepository>(
            create: (context) =>
                UserRepositoryImpl(firebaseAuth: context.read())),
        Provider<UserService>(
          create: (context) => UserServiceImpl(userRepository: context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
              firebaseAuth: context.read(), userService: context.read())
            ..loadListener(),
          lazy: false,
        ),
      ],
      child: AppWidget(),
    );
  }
}
