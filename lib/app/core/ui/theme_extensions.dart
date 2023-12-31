import 'package:flutter/material.dart';

//'extension' adiciona atributos dentro de uma classe onde a variavel 'this' é a adição dentro do buildcontext

extension ThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  // Color get buttonColor => Theme.of(this).buttonColor;
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get titleStyle => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      );
}
