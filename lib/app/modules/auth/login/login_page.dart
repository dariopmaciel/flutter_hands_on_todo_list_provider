import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/messages.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:validatorless/validatorless.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _emailFocus = FocusNode();

  @override
 void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
      context: context,
      everCallBack: (notifier, listenerInstance) {
        if (notifier is LoginController) {
          if (notifier.hasInfo) {
            Messages.of(context).showInfo(notifier.infoMessage!);
          }
        }
      },
      successCallBack: (notifier, listenerInstance) {
        print("Login realizado com Sucesso!!!");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<LoginController>(context);
    return Scaffold(
      //O 'LayoutBuilder' é bom pra saber o tamanho da tela exata, p pegar a tela
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                //a estratégia de colocar o minimo como sento o máximo é boa pq não atrapalha a rolagem de tela DENTRO de um singlechildscrollview
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
                
              ),
              //'IntrinsicHeight' faz com que o Column tenha exatamente o máximo a tela possivel a ser usado com seus widgets. "Tem o tamanho que precisa ter e não infinito"
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const TodoListLogo(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TodoListField(
                              label: 'E-mail',
                              controller: _emailEC,
                              focusNode: _emailFocus ,
                              validator: Validatorless.multiple([
                                Validatorless.required("* E-mail Obrigatório!"),
                                Validatorless.email("* E-mail Inválido"),
                              ]),
                            ),
                            const SizedBox(height: 20),
                            TodoListField(
                              label: 'Senha',
                              controller: _passwordEC,
                              obscureText: true,
                              validator: Validatorless.multiple([
                                Validatorless.required("* Senha obrigatória!"),
                                Validatorless.min(6, "Mínimo 6 caracteres")
                              ]),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    //esqueceu senha
                                    if (_emailEC.text.isNotEmpty) {
                                      //recuperar senha
                                      context
                                          .read<LoginController>()
                                          .forgotPassword(_emailEC.text);
                                    } else {
                                      _emailFocus.requestFocus();
                                      Messages.of(context).showError(
                                          "Digite um email para recuperar senha");
                                    }
                                  },
                                  child: const Text("Esqueceu a senha?"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    final formValid =
                                        _formKey.currentState?.validate() ??
                                            false;
                                    if (formValid) {
                                      final email = _emailEC.text;
                                      final password = _passwordEC.text;
                                      context.read<LoginController>().login(
                                          email: email, password: password);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text("Login"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.primaryColorLight,
                          border: Border(
                            top: BorderSide(
                              width: 2,
                              color: Colors.grey.withAlpha(50),
                            ),
                          ),
                        ),
                        child: Column(children: [
                          const SizedBox(height: 30),
                          SignInButton(
                            Buttons.google,
                            text: "Continue com o Google",
                            padding: const EdgeInsets.all(5),
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            onPressed: () {
                              //Login com o google
                              context.read<LoginController>().googleLogin();
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Não tem conta?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/register');
                                },
                                child: const Text("Cadastre-se!"),
                              ),
                            ],
                          ),
                          // Container(height: 30, color: Colors.red),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
