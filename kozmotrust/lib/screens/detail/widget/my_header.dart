import 'package:kozmotrust/constants.dart';
import 'package:kozmotrust/screens/detail/widget/my_action.dart';
import 'package:flutter/material.dart';

class MyHeader extends StatelessWidget {
  const MyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      height: 320,
      decoration: BoxDecoration(
        color: nCardBackgroundColor,
        image: const DecorationImage(
          image: AssetImage('assets/images/product_full_detail.png'),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: const MyActionBar(),
    );
  }
}
