import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hands_on_todo_list_provider/app/exception/auth_exception.dart';
import 'package:flutter_hands_on_todo_list_provider/app/repositories/user/user_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

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

  @override
  // Rodrigo Rahman
  // Future<void> forgotPassword(String email) async {
  //   try {
  //     final loginMethods =
  //         // await _firebaseAuth.fetchSignInMethodsForEmail(email);
  //         await _firebaseAuth.fetchSignInMethodsForEmail(email);

  //     if (loginMethods.contains('email')) {
  //       await _firebaseAuth.sendPasswordResetEmail(email: email);
  //     } else if (loginMethods.contains('google')) {
  //       throw AuthException(
  //           message:
  //               "Cadastro realizado com o Goolge, não pode ser resetado a senha");
  //     } else {
  //       throw AuthException(message: "E-mail não cadastrado");
  //     }
  //   } on PlatformException catch (e, s) {
  //     print(e);
  //     print(s);
  //     throw AuthException(message: "Erro ao resetar senha");
  //   }
  // }

//José Algusto Soares
  // Future<void> forgotPassword(String email) async {
  //   try {
  //     final loginMethods =
  //         await _firebaseAuth.fetchSignInMethodsForEmail(email);
  //     print('loginMethods: $loginMethods');

  //     if (loginMethods.isEmpty) {
  //       try {
  //         await _firebaseAuth.sendPasswordResetEmail(email: email);
  //       } catch (e) {
  //         print('e: $e');
  //         throw AuthException(message: "E-mail nao cadastrado");
  //       }
  //     } else {
  //       throw AuthException(
  //           message:
  //               "Cadastro realizado com o google, não pode ser resetado a senha");
  //     }
  //   } on PlatformException catch (e, s) {
  //     print('e: $e');
  //     print('s: $s');
  //     throw AuthException(message: "Erro ao resetar senha");
  //   }
  // }

// Marcuss Brasizza
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (loginMethods.isEmpty || loginMethods.contains('password')) {
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

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
        if (loginMethods.contains('password')) {
          throw AuthException(
              message:
                  'Vode utilizou o email para cadastro no TodoList, caso esqueceu sua senha por favor click no link ->Esqueceu a senha?');
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
          var userCredential =
              await _firebaseAuth.signInWithCredential(firebaseCredential);
          return userCredential.user;
        }
      }
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(message: '''
              Login inválido, você se registrou no TodoList com os seguintes provedores:
              ${loginMethods?.join(',')}
        ''');
      } else {
        throw AuthException(message: "Erro ao realizar login");
      }
    }
    // return null;
  }

  @override
  Future<void> googleLogout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }
}
