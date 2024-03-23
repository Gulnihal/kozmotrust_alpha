import 'dart:convert';
import 'package:kozmotrust/constants/error_handling.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/constants/utils.dart';
import 'package:kozmotrust/features/auth/screens/auth_screen.dart';
import 'package:kozmotrust/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
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
