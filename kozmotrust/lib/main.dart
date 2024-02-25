import 'package:flutter/material.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/auth/screens/auth_screen.dart';
import 'package:kozmotrust/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KozmoTrust',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(),
        primaryColor: GlobalVariables.secondaryColor ,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
              color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings) ,
      home: const AuthScreen(),
    );
  }
}
