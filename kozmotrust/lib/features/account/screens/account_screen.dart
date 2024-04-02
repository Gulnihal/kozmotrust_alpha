import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/account/screens/healthinfo_screen.dart';
import 'package:kozmotrust/features/account/widgets/bottom_buttons.dart';
import 'package:kozmotrust/providers/user_provider.dart';
import 'package:kozmotrust/features/account/widgets/list_favorites.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.selectedTopBarColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/images/logo.png'),
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/50),
          Center( // Center the text horizontally
            child: Text(
              "Welcome ${user.username}!",
              style: const TextStyle(
                fontSize: 24, // Set the font size to 24
                fontWeight: FontWeight.bold, // Make the text bold
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/50),
          const ListFavorites(),
          SizedBox(height: MediaQuery.of(context).size.height/50),
          const HealthInformationScreen(),
          SizedBox(height: MediaQuery.of(context).size.height/50),
          const BottomButtons(),
          SizedBox(height: MediaQuery.of(context).size.height/50),
        ],
      ),
    );
  }
}
