import 'package:kozmotrust/constants.dart';
import 'package:kozmotrust/widget/rating_bar.dart';
import 'package:flutter/material.dart';

class PopularCosmeticsListView extends StatelessWidget {
  const PopularCosmeticsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        itemCount: popularCosmeticsList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
          width: 220,
          height: 310,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(
                popularCosmeticsList[index]['imageUrl'] as String,
              ),
            ),
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
                nPrimaryColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  popularCosmeticsList[index]['name'] as String,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RatingBar(
                  onRatingUpdate: (value) {},
                  selectColor: nDarkBackgroundColor,
                  maxRating: 5,
                  value: popularCosmeticsList[index]['star'] as double,
                  size: 18, padding: 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
