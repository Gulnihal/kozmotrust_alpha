import 'dart:convert';

import 'package:kozmotrust/constants/error_handling.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/constants/utils.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:kozmotrust/models/user.dart';
import 'package:kozmotrust/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  late String answer = '';

  void addToFavorites({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-favorites'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'accessToken': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
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

  void removeFromFavorites({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-favorites'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'accessToken': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
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

  void getGptAnswer({
    required BuildContext context,
    required Product product,
    required Function(String) onDataReceived, // Callback function to handle the response
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/gptexamine'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'accessToken': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final Map<String, dynamic> decodedBody = jsonDecode(res.body);
          String answer = decodedBody['modelAnswer'];
          print(answer);
          onDataReceived(answer); // Pass the answer to the callback function
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  String getAnswer() => answer;
}
