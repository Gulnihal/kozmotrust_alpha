// import 'dart:convert';

// import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/models/user.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    token: '',
    id: '',
    username: '',
    email: '',
    password: '',
    healthinfo: '',
    type: '',
    language: '',
    favorites: [],
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
  //
  // Future<void> fetchUserData() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$uri/api/getUser'),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final userData = jsonDecode(response.body);
  //       setUserFromModel(User.fromJson(userData));
  //     } else {
  //       throw Exception('Failed to fetch user data');
  //     }
  //   } catch (error) {
  //     print('Error fetching user data: $error');
  //     rethrow;
  //   }
  // }
}
