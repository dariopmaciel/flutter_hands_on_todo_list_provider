import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/navigator/todo_list_navigator.dart';

import 'package:flutter_hands_on_todo_list_provider/app/services/user/user_service.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;

  AuthProvider({
    required FirebaseAuth firebaseAuth,
    required UserService userService,
  })  : _firebaseAuth = firebaseAuth,
        _userService = userService;

//atalho para deslogar so serviço
  Future<void> logout() => _userService.logout();
  //Possobilita pegar os dados do usuário, e ele pode estar deslogado
  User? get user => _firebaseAuth.currentUser;

//metodos para escutar
  void loadListener() {
    _firebaseAuth.userChanges().listen((_) => notifyListeners());
    // _firebaseAuth.idTokenChanges().listen((user) {
      _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        //usuario logou
        TodoListNavigator.to.pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        //usuario deslogou
        TodoListNavigator.to.pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }
}
