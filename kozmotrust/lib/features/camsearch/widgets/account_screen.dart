import 'package:flutter/material.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/account/screens/healthinfo_screen.dart';
import 'package:kozmotrust/features/account/widgets/list_favorites.dart';
import 'package:kozmotrust/features/account/screens/account_settings.dart';
import 'package:kozmotrust/features/account/services/account_services.dart';
import 'package:kozmotrust/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void navigateToAccountSettings() {
    Navigator.pushNamed(context, AccountSettings.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.selectedTopBarColor,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/images/logo.png'),
        leading: IconButton(
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ), // Config icon
          onPressed: () {
            navigateToAccountSettings();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ), // Logout icon
            onPressed: () {
              AccountServices().logOut(context);
            },
          ),
        ],
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          Center(
            child: RichText(
              text: TextSpan(
                text: "Hi ${user.username} ",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '😊', // Smile emoji
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height /
                            35), // Adjust emoji if needed
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          const ListFavorites(),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          const HealthInformationScreen(),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
        ],
      ),
    );
  }
}
