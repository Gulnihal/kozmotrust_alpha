import 'package:kozmotrust/constants.dart';
import 'package:kozmotrust/screens/detail/detail_screen.dart';
import 'package:flutter/material.dart';

class CosmeticsFull extends StatelessWidget {
  const CosmeticsFull({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: <Widget>[
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Cosmetics Full Kit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ALL',
                style: TextStyle(
                  color: Colors.black38,
                ),
              )
            ],
          ),
          ListView.builder(
            itemCount: cosmeticsFullList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DetailScreen();
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                ),
                child: Image.asset(
                  cosmeticsFullList[index],
                  height: 210,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
