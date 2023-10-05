import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/messages.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter_hands_on_todo_list_provider/app/services/user/user_service.dart';

import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');

  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: context.primaryColor.withAlpha(70)),
            child: Row(
              children: [
                Selector<AuthProvider, String>(
                    selector: (context, authPovider) {
                  return
                      //teste de validação
                      authPovider.user?.photoURL ??
                          //
                          'https://cdn-icons-png.flaticon.com/512/53/53068.png';
                }, builder: (_, value, __) {
                  return CircleAvatar(
                    backgroundImage: NetworkImage(value),
                    radius: 30,
                  );
                }),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthProvider, String>(
                      selector: (context, authPovider) {
                        return authPovider.user?.displayName ?? 'Não Informado';
                      },
                      builder: (_, value, __) {
                        return Text(
                          value,
                          style: context.textTheme.bodyMedium,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              //criação de modal
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text("Alterar Nome"),
                    content: TextField(
                      onChanged: (value) => nameVN.value = value,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.red),
                          )),
                      TextButton(
                          onPressed: () async {
                            final nameValue = nameVN.value;
                            if (nameValue.isEmpty) {
                              Messages.of(context)
                                  .showError('Nome Obrigatório');
                            } else {
                              // Loader.show(context);
                              await context
                                  .read<UserService>()
                                  .updateDisplayName(nameValue);
                              // Loader.hide();
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Alterar')),
                    ],
                  );
                },
              );
            },
            title: const Text("Alterar Nome:"),
          ),
          ListTile(
            onTap: () {
              context.read<AuthProvider>().logout();
            },
            title: const Text("Sair"),
          ),
        ],
      ),
    );
  }
}
