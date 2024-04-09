import 'package:flutter/material.dart';
import 'package:kozmotrust/constants/global_variables.dart';

class SingleBlogScreen extends StatelessWidget {
  static const String routeName = '/single-blog-screen';
  final String title;
  final String image;
  final String body;
  const SingleBlogScreen({super.key, required this.title, required this.image, required this.body});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: GlobalVariables.selectedTopBarColor),
          ),
          elevation: 0,
          centerTitle: true,
          title: Image.asset('assets/images/logo.png'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
             Text(
              title,
              style: const TextStyle(
                fontSize: 24, // Set the font size to 24
                fontWeight: FontWeight.bold, // Make the text bold
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Image.asset(image),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
             Text(
              title,
              style: const TextStyle(
                fontSize: 16, // Set the font size to 24
                fontWeight: FontWeight.bold, // Make the text bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
