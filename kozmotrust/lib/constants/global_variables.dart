import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

String uri = 'http://10.0.2.2:5000';
WeatherFactory wf = WeatherFactory('046617570d44df5f9482d205fcbb67df',
    language: Language.ENGLISH);

class GlobalVariables {
  static const secondaryColor = Color(0xFFE1BEE7);
  static const buttonDeleteColor = Color(0xFFB71C1C);
  static const buttonBackgroundColor = Color(0xFF9FA8DA);
  static const primaryColor = Color(0xFF673AB7);
  static const backgroundColor = Color(0xFFFCE4EC);
  static const gptIconColor = Color(0xFF4C0043);

  static const weatherBox = LinearGradient(
    colors: [
      Color.fromARGB(255, 227, 242, 247), // Very Light Sky Blue
      Color.fromARGB(255, 156, 211, 225), // Sky Blue
    ],
    stops: [0.5, 1.0],
  );
  static const selectedTopBarColor = LinearGradient(
    colors: [
      Color.fromARGB(255, 160, 150, 210), // Lavender
      Color.fromARGB(255, 200, 162, 200), // Lilac
    ],
    stops: [0.5, 1.0],
  );
}
