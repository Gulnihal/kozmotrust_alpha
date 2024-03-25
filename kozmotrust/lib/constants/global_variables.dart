import 'package:flutter/material.dart';

String uri = 'http://192.168.0.11:5000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color(0xFFE1BEE7);
  static const backgroundColor = Color(0xFFFCE4EC);
  static const buttonTextColor = Color(0xFF9FA8DA);
  static const selectedNavBarColor = Color(0xFF673AB7);
}

