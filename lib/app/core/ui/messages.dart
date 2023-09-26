import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';

class Messages {
  final BuildContext context;
  Messages._(this.context);

//quando necessário fazer aparecer alguma msg
  factory Messages.of(BuildContext context) {
    return Messages._(context);
  }

  void showError(String message) => _showMessage(message, Colors.red);
  //ou
  // void showError(String message) {
  //   return _showMessage(message, Colors.red);
  // }

  void showInfo(String message) => _showMessage(message, context.primaryColor);
  //ou
  // void showInfo(String message) {
  //   return _showMessage(message, context.primaryColor);
  // }

//Impede erro e verbose de codigo
  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
