import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kozmotrust/providers/user_provider.dart';
import 'package:kozmotrust/constants/error_handling.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:weather/weather.dart';

class HomeServices {
  late String modelWeather = '';
  late Weather? weatherData = Weather(<String, dynamic> {});

  Future<void> fetchWeather() async {
    try {

      Weather? weather = await wf.currentWeatherByCityName("Ankara");
      print(weather);
      weatherData = weather;

    } catch (e) {
      if (kDebugMode) {
        print("Error fetching weather: $e");
      }
    }
  }

  void getGptAnswer({
    required BuildContext context,
    required Weather? weather,
    required Function(String) onDataReceived, // Callback function to handle the response
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/gptweather'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'accessToken': userProvider.user.token,
        },
        body: jsonEncode({
          'weather': weather!,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final Map<String, dynamic> decodedBody = jsonDecode(res.body);
          String answer = decodedBody['modelAnswer'];
          onDataReceived(answer);
          modelWeather = answer;
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getGptAnswer2({
    required BuildContext context,
    required Function(String) onDataReceived, // Callback function to handle the response
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/gptweather'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'accessToken': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final Map<String, dynamic> decodedBody = jsonDecode(res.body);
          String answer = decodedBody['modelAnswer'];
          onDataReceived(answer);
          modelWeather = answer;
          weatherData = Weather(decodedBody['weatherData']);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  String getModelWeather() => modelWeather;
  Weather? getWeather() => weatherData;
}
