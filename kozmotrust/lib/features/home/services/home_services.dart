import 'package:kozmotrust/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kozmotrust/features/auth/screens/auth_screen.dart';

class HomeServices {

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      await sharedPreferences.setString('accessToken', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
            (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
