import 'dart:convert';

import 'package:kozmotrust/features/insights/screens/blog.dart';
import 'package:flutter/material.dart';

import 'package:kozmotrust/constants/global_variables.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key, required this.url});
  final String url;
  @override
  State<Blogs> createState() {
    return _BlogsState();
  }
}

class _BlogsState extends State<Blogs> {

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: GlobalVariables.backgroundColor,
        body: SingleChildScrollView(
        )
    );
  }
}
