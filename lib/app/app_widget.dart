import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/database/sqlite_adm_connection.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/navigator/todo_list_navigator.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/todo_list_ui_config.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/home_module.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/splash/splash_page.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/auth/auth_module.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdmConnection = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();
    // FirebaseAuth auth = FirebaseAuth.instance;
    WidgetsBinding.instance.addObserver(sqliteAdmConnection);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo List Provider',
      // initialRoute: '/login',
      //Para evitar a verbose, construiu-se rotas para os varios modulos,'{...AuthModule().routers},'
      theme: TodoListUiConfig.theme,
      navigatorKey: TodoListNavigator.navigatorKey,
      routes: {
        ...AuthModule().routers,
        ...HomeModule().routers,
      },
      // routes: {
      //   '/login': (_) => MultiProvider(
      //         providers: [
      //           Provider(create: (context) => "Repository"),
      //           Provider(create: (context) => "Services"),
      //           ChangeNotifierProvider(
      //             create: (context) => LoginController(),
      //           ),
      //         ],
      //         child: LoginPage(),
      //       ),
      //   '/register': (_) => MultiProvider(
      //         providers: [
      //           Provider(create: (context) => "Repository"),
      //           Provider(create: (context) => "Services"),
      //           ChangeNotifierProvider(
      //             create: (context) => LoginController(),
      //           ),
      //         ],
      //         child: LoginPage(),
      //       ),
      // },
      home: SplashPage(),
    );
  }
}
