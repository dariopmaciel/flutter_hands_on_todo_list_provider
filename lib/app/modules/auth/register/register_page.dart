import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/validators/validators.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    // context.read<RegisterController>().removeListener(() { });
    super.dispose();
  }

//listner pindurado!!!!!
  @override
  void initState() {
    super.initState();
    final defaultListner = DefaultListenerNotifier(
        changeNotifier: context.read<RegisterController>());
    defaultListner.listener(
      context: context,
      successCallBack: (notifier, listenerInstance) {
        listenerInstance.dispose();
          // Navigator.of(context).pop();
/*removemos este pop devido a alteração do 
_firebaseAuth.idTokenChanges().listen((user) {
para o 
_firebaseAuth.authStateChanges().listen((user) {
em AuthProvider*/
      
      },
      //Este atributo abaixo é opcional
      errorCallBack: (notifier, listenerInstance) {
        print("Deu RUIM!!!!");
      },
    );
    // context.read<RegisterController>().addListener(
    //   () {
    //     final controller = context.read<RegisterController>();
    //     var success = controller.success;
    //     var error = controller.error;
    //     if (success) {
    //       Navigator.of(context).pop();
    //     } else if (error != null && error.isNotEmpty) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(
    //           content: Text("ERROR"),
    //           backgroundColor: Colors.red,
    //         ),
    //       );
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Todo List",
              style: TextStyle(color: context.primaryColor, fontSize: 12),
            ),
            Text(
              "Cadastro",
              style: TextStyle(color: context.primaryColor, fontSize: 15),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(15),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 20,
                color: context.primaryColor,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.5,
            color: Colors.white,
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: TodoListLogo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TodoListField(
                    label: 'E-mail',
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required("* E-mail obrigatório!"),
                      Validatorless.email("* Isto não é um E-mail")
                    ]),
                  ),
                  const SizedBox(height: 15),
                  TodoListField(
                    label: 'Senha',
                    obscureText: true,
                    controller: _passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('* Senha obrigatória!'),
                      Validatorless.min(6, "* Insira ao menos 6 caracteres!"),
                    ]),
                  ),
                  const SizedBox(height: 15),
                  TodoListField(
                    label: 'Confirma Senha',
                    obscureText: true,
                    controller: _confirmPasswordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('* Confirmar senha obrigatória!'),
                      Validators.compare(_passwordEC, "* Senhas não conferem!"),
                    ]),
                  ),
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          final email = _emailEC.text;
                          final password = _passwordEC.text;
                          context
                              .read<RegisterController>()
                              .registerUser(email, password);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Salvar"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
