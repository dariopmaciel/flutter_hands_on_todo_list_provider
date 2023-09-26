import 'package:flutter_hands_on_todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:flutter_hands_on_todo_list_provider/app/exception/auth_exception.dart';
import 'package:flutter_hands_on_todo_list_provider/app/services/user/user_service.dart';

class RegisterController extends DefaultChangeNotifier {
  final UserService _userService;
  //bool success = false;
  //bool loading = false;

  RegisterController({required UserService userService})
      : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      //a função destes 2 é zerar o changenofifier
      // error = null;
      // success = false;
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.register(email, password);
      if (user != null) {
        // success = true;
        success();
      } else {
        // error = 'Erro ao registrar usuário!';
        setError('Erro ao registrar usuário!');
      }
      notifyListeners();
    } on AuthException catch (e) {
      // error = e.message;
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
