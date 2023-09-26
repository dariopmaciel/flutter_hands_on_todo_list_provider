import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hands_on_todo_list_provider/app/exception/auth_exception.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  //UserRepositoryImpl({required firebaseAuth}) : _firebaseAuth = firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      //caminho feliz
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      //reorno como '.user' é opcional, podendo existir ou não, conforme '<User?>'
      return userCredencial.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      // if (e.code == 'email-already-in-use') {
      if (e.code == 'email-already-exists') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message: "Email já utilizado por favor escolha outro e-mail");
        } else {
          throw AuthException(
              message:
                  "Você se cadastrou no TodoList pelo Google, utilize a validação do Google para entrar!");
        }
      } else {
        throw AuthException(message: e.message ?? "Erro ao registrar usuário");
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? "Erro ao realizar Login");
    } on FirebaseAuthException catch (e, s) {
      //erro firebase atentication
      print(e);
      print(s);
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        throw AuthException(message: "Login ou senha inválidos!");
      }
      throw AuthException(message: e.message ?? "Erro ao realizar Login");
    }
  }

  // @override
  // Future<void> forgotPassword(String email) async {
  //   try {
  //     final loginMetods = await _firebaseAuth.fetchSignInMethodsForEmail(email);
  //     if (loginMetods.contains('password')) {
  //       await _firebaseAuth.sendPasswordResetEmail(email: email);
  //     } else if (loginMetods.contains('google')) {
  //       throw AuthException(
  //           message:
  //               'Cadastro realizado com o Google, não é possivel resetar senha');
  //     } else {
  //       throw AuthException(message: 'Email não cadastradooooo');
  //     }
  //   } on PlatformException catch (e, s) {
  //     print(e);
  //     print(s);
  //     throw AuthException(message: 'Erro ao resetar senha');
  //   }
  // }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods = await _firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google')) {
        throw AuthException(
            message:
                "Cadastro realizado com o Goolge, não pode ser resetado a senha");
      } else {
        throw AuthException(message: "E-mail não cadastrado");
      }
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: "Erro ao resetar senha");
    }
  }
}