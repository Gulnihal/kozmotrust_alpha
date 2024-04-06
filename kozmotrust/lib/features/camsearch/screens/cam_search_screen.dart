import 'package:flutter/material.dart';
import 'package:kozmotrust/constants/global_variables.dart';

class CameraSearchScreen extends StatefulWidget {
  const CameraSearchScreen({super.key});

  @override
  State<CameraSearchScreen> createState() {
    return _CameraSearchScreenState();
  }
}

class _CameraSearchScreenState extends State<CameraSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      body: SingleChildScrollView(

      ),
    );
  }
}
