import 'dart:convert';
import 'package:kozmotrust/common/widgets/bottom_bar.dart';
import 'package:kozmotrust/constants/error_handling.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/constants/utils.dart';
import 'package:kozmotrust/features/auth/screens/auth_screen.dart';
import 'package:kozmotrust/providers/user_provider.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kozmotrust/models/user.dart';

class AccountServices {
  late SharedPreferences prefs;

  void updatePassword({
    required BuildContext context,
    required String password,
    required String newPassword,
  }) async {
    try {
      http.Response res = await http.patch(
        Uri.parse('$uri/api/update'),
        body: jsonEncode({
          'password': password,
          'newPassword': newPassword,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context).user.password = newPassword;
          // print(res.body);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
                (route) => false,
          );
        },
      );
      showSnackBar(context, "Password changed!");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void deleteAccount({
    required BuildContext context,
    required String password,
  }) async {
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/delete'),
        body: jsonEncode({
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          Navigator.pushNamed(context, AuthScreen.routeName);
        },
      );
      showSnackBar(context, "Account Deleted!");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  void saveUserHealthInformation({
    required BuildContext context,
    required String healthinfo,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-healthinfo'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'accessToken': userProvider.user.token,
        },
        body: jsonEncode({
          'healthinfo': healthinfo,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            healthinfo: jsonDecode(res.body)['healthinfo'],
          );

          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  //very important fetch favorites part
  Future<List<Product>> fetchFavorites({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> favorites = [];
    try {
      http.Response res =
      await http.get(Uri.parse('$uri/api/favorites'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'accessToken': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body)['favorites'].length; i++) {
            print(jsonEncode(
              jsonDecode(jsonEncode(jsonDecode(res.body)['favorites'][i]))['product'],
            ),);
            favorites.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(jsonEncode(jsonDecode(res.body)['favorites'][i]))['product'],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return favorites;
  }

  void removeFromFavorites({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-favorites/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'accessToken': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
          userProvider.user.copyWith(favorites: jsonDecode(res.body)['favorites']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
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
