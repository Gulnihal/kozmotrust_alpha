import 'package:flutter/material.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/account/screens/account_settings.dart';
import 'package:kozmotrust/features/account/services/account_services.dart';
import 'package:kozmotrust/features/admin/widgets/add_product.dart';
import 'package:kozmotrust/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:kozmotrust/features/admin/screens/search-edit-delete-product.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin-screen';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
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
        title: const Text(
          'Admin Product Control',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.settings,
            color: Colors.black,
          ), // Config icon
          onPressed: () {
            navigateToAccountSettings();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
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
          const AddProduct(),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
        ],
      ),
    );
  }
}
