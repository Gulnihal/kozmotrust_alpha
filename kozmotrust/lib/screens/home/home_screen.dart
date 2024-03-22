import 'package:kozmotrust/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const primaryColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: primaryColor,
      body: const SingleChildScrollView(
        child: Column(
          children: <Widget>[
          ],
        ),
      ),
    );
  }
  static const secondaryColor = Colors.deepPurpleAccent;
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: secondaryColor,
      elevation: 0,
      centerTitle: true,
      title: Image.asset('assets/images/logo.png'),
    );
  }
}
