import 'dart:convert';
import 'package:kozmotrust/constants/error_handling.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/constants/utils.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:kozmotrust/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {

  Future<void> addProduct({
    required BuildContext context,
    required description,
    required brand,
    required name,
    required ingredients,
    required category,
    required combination,
    required dry,
    required normal,
    required oily,
    required sensitive,
    required image,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        body: jsonEncode({
          'description': description,
          'brand': brand,
          'name': name,
          'ingredients': ingredients,
          'category': category,
          'combination': combination,
          'dry': dry,
          'normal': normal,
          'oily': oily,
          'sensitive': sensitive,
          'image': image,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'accessToken': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Added Successfully!');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> updateProduct({
    required BuildContext context,
    required Product product,
    required description,
    required brand,
    required name,
    required ingredients,
    required category,
    required combination,
    required dry,
    required normal,
    required oily,
    required sensitive,
    required image,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.patch(
        Uri.parse('$uri/admin/edit-product'),
        body: jsonEncode({
          'id': product.id,
          'description': description,
          'brand': brand,
          'name': name,
          'ingredients': ingredients,
          'category': category,
          'combination': combination,
          'dry': dry,
          'normal': normal,
          'oily': oily,
          'sensitive': sensitive,
          'image': image,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accessToken': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, "Product edited!");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> deleteProduct({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'accessToken': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.of(context).pop(true);
          showSnackBar(context, "Product deleted!");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}