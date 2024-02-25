import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';

class GlobalVariables{
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(178, 70, 135, 1.0);
  static const Color backgroundColor = Color(0xFFFCE4EC);
  static const Color lilaBackgroundCOlor = Color(0xFFE1BEE7);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;



}