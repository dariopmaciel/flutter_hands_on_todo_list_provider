import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/database/sqlite_connection_factory.dart';

class SqliteAdmConnection with WidgetsBindingObserver {
  SqliteAdmConnection();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final connection = SqliteConnectionFactory();

    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        connection.closeConection();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
