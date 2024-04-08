import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/home/services/home_services.dart';
import 'package:flutter/material.dart';
import 'package:kozmotrust/common/widgets/loader.dart';
import 'package:weather/weather.dart';

class WeatherInformationBox extends StatefulWidget {
  const WeatherInformationBox({super.key});

  @override
  State<WeatherInformationBox> createState() => _WeatherInformationBoxState();
}

class _WeatherInformationBoxState extends State<WeatherInformationBox> {
  final HomeServices _homeServices = HomeServices();
  late String modelWeather = _homeServices.getModelWeather();
  late Weather weatherData;

  @override
  void initState() {
    super.initState();
    _homeServices.getGptAnswer2(
        context: context,
        onDataReceived: (result) {
          setState(() {
            modelWeather = result;
          });
        });
  }

  IconData _getWeatherIcon(String? weatherIcon) {
    switch (weatherIcon) {
      case '01d':
        return Icons.wb_sunny;
      case '01n':
        return Icons.nightlight_round;
      case '02d':
      case '02n':
        return Icons.cloud;
      case '03d':
      case '03n':
        return Icons.cloud_queue;
      case '04d':
      case '04n':
        return Icons.cloud_off;
      case '09d':
      case '09n':
        return Icons.waves;
      case '10d':
      case '10n':
        return Icons.beach_access;
      case '11d':
      case '11n':
        return Icons.flash_on;
      case '13d':
      case '13n':
        return Icons.ac_unit;
      case '50d':
      case '50n':
        return Icons.filter_drama;
      default:
        return Icons.error;
    }
  }

  Future<void> getWeather() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // Allow dismissal by tapping outside
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text('Here some suggestion for you:'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                modelWeather,
                style: TextStyle(
                  fontSize:
                  MediaQuery.of(context).size.width * 1.5 * 0.025,
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 20, 35, 20),
      decoration: BoxDecoration(
        gradient: GlobalVariables.weatherBox,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: _homeServices.getWeather() == null
          ? const CircularProgressIndicator()
          : Row(
              children: [
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Weather Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(_getWeatherIcon(_homeServices.getWeather()!.weatherIcon),
                            color: Colors.orange),
                        const SizedBox(width: 5),
                        Text(
                          _homeServices.getWeather()?.weatherMain ?? 'N/A',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.thermostat_outlined,
                            color: Colors.blue),
                        const SizedBox(width: 5),
                        Text(
                          '${_homeServices.getWeather()!.temperature?.celsius?.toStringAsFixed(1)}°C',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                modelWeather == ''
                    ? const Loader()
                    : IconButton(
                        icon: const Icon(
                          Icons.note_outlined,
                          color: GlobalVariables.gptIconColor,
                        ),
                        onPressed: getWeather,
                      ),
                const SizedBox(height: 10),
              ],
            ),
      // Show loading indicator while fetching weather
    );
  }
}
