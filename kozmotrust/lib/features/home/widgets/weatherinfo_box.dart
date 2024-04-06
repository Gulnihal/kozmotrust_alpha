import 'package:flutter/foundation.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/home/services/home_services.dart';
import 'package:weather/weather.dart';
import 'package:flutter/material.dart';
import 'package:kozmotrust/common/widgets/loader.dart';

class WeatherInformationBox extends StatefulWidget {
  const WeatherInformationBox({super.key});

  @override
  State<WeatherInformationBox> createState() => _WeatherInformationBoxState();
}

class _WeatherInformationBoxState extends State<WeatherInformationBox> {
  final HomeServices _homeServices = HomeServices();
  Weather? _weather;
  late String answer = _homeServices.getAnswer();

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    _homeServices.getGptAnswer2(
        context: context,
        onDataReceived: (result) {
          setState(() {
            answer = result; // Update the answer when data is received
          });
        });
  }

  Future<void> _fetchWeather() async {
    try {
      WeatherFactory wf = WeatherFactory('046617570d44df5f9482d205fcbb67df',
          language: Language.ENGLISH);
      Weather? weather = await wf.currentWeatherByCityName("Ankara");
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching weather: $e");
      }
    }
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
                answer,
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
      child: _weather == null
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
                        Icon(_getWeatherIcon(_weather!.weatherIcon),
                            color: Colors.orange),
                        const SizedBox(width: 5),
                        Text(
                          _weather?.weatherMain ?? 'N/A',
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
                          '${_weather!.temperature?.celsius?.toStringAsFixed(1)}°C',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                answer == ''
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
