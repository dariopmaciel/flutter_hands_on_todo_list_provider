import 'package:flutter_hands_on_todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/auth/register/register_page.dart';
import 'package:provider/provider.dart';
import '../../core/modules/todo_list_module.dart';
import 'login/login_controller.dart';
import 'login/login_page.dart';

class AuthModule extends TodoListModule {
  AuthModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (context) => LoginController(userService: context.read()),
            ),
            ChangeNotifierProvider(
                create: (context) =>
                    RegisterController(userService: context.read())),
          ],
          routers: {
            '/login': (context) => const LoginPage(),
            '/register': (context) => RegisterPage(),
          },
        );
}
