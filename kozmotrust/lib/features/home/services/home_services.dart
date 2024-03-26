import 'package:kozmotrust/constants/utils.dart';
import 'package:kozmotrust/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kozmotrust/features/auth/screens/auth_screen.dart';

class HomeServices {
  final UserProvider userService = UserProvider();
  Future<String> getUserName() async {
    print(userService.user.username);
    return userService.user.username;
  }

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
