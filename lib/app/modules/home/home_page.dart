import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      drawer: HomeDrawer(),
      body: Container(),
      // Center(
      //   child: TextButton(
      //     onPressed: () {
      //       context.read<AuthProvider>().logout();
      //     },
      //     child: const Text('LogOut'),
      //   ),
      // ),
    );
  }
}
