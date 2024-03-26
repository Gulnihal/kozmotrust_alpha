import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/account/widgets/bottom_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.selectedTopBarColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/images/logo.png'),
      ),
      body: const Column(
        children: [
          Expanded(
            child: SizedBox(), // Add any other content here
          ),
          BottomButtons(),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
