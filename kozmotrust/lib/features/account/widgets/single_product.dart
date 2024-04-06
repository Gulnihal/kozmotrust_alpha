import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final String brand;
  final String name;

  const SingleProduct({
    super.key,
    this.brand = '',
    this.name = '',
    this.image = 'https://4.imimg.com/data4/OR/CH/MY-24500503/catageroy-1-500x500.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        child: Row (
          children: [
            Image.network(
              'https://4.imimg.com/data4/OR/CH/MY-24500503/catageroy-1-500x500.jpg',
              fit: BoxFit.fitHeight,
              height: MediaQuery.of(context).size.width/4,
              width: MediaQuery.of(context).size.width/4,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Text('😢');
              },
            ),
            const SizedBox(width: 5),
            Column(
              children: [
                Container(
                  width: 235,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    brand,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
