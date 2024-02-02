import 'package:kozmotrust/constants.dart';
import 'package:kozmotrust/screens/home/widget/popular_cosmetics_listview.dart';
import 'package:flutter/material.dart';

class PopularCosmetics extends StatelessWidget {
  const PopularCosmetics({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: nDarkBackgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: const Text(
              'Popular Cosmetics',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const PopularCosmeticsListView(),
        ],
      ),
    );
  }
}
