import 'package:flutter/material.dart';

String uri = 'http://10.0.2.2:5000';

class GlobalVariables {
  // COLORS
  static const secondaryColor = Color(0xFFE1BEE7);
  static const selectedTopBarColor = LinearGradient(
    colors: [
      Color.fromARGB(255, 160, 150, 210), // Lavender
      Color.fromARGB(255, 200, 162, 200), // Lilac
    ],
    stops: [0.5, 1.0],
  );
  static const buttonDeleteColor = Color(0xFFB71C1C);
  static const buttonBackgroundColor = Color(0xFF9FA8DA);
  static const primaryColor = Color(0xFF673AB7);
  static const backgroundColor = Color(0xFFFCE4EC);
}