import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/app_module.dart';
import 'package:flutter_hands_on_todo_list_provider/firebase_options.dart';


Future<void> main() async {
  //Para inicializar o flutter antes
  WidgetsFlutterBinding.ensureInitialized();
  //Ideal ser colocado em um arquivo de configuração
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //inicialização do app
  runApp(const AppModule());
}
