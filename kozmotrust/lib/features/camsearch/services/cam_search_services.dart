import 'dart:convert';

import 'package:kozmotrust/constants/error_handling.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/constants/utils.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:kozmotrust/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CamSearchServices {

  Future<List<Product>> fetchSearchedProduct({
    required BuildContext context,
    required List<String> searchQueries,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      for (String searchQuery in searchQueries) {
        http.Response res = await http.get(
          Uri.parse('$uri/api/products/search/$searchQuery'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'accessToken': userProvider.user.token,
          },
        );

        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            List<dynamic> responseData = jsonDecode(res.body);
            for (int i = 0; i < responseData.length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    responseData[i],
                  ),
                ),
              );
            }
          },
        );

        // If productList is not empty, break the loop
        if (productList.isNotEmpty) {
          break;
        }
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return productList;
  }


  Future<List<Product>> fetchSearchedFavoriteProduct({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/user/favorites/search/$searchQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'accessToken': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    print(productList);
    return productList;
  }
}
