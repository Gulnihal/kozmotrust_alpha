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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Row (
            children: [
              Image.network(
                'https://4.imimg.com/data4/OR/CH/MY-24500503/catageroy-1-500x500.jpg',
                fit: BoxFit.fitHeight,
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 20),
              Text(
                "$brand\n$name",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
