import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final String name;
  const SingleProduct({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(10),
          child: Column (
            children: [
              Image.network(
                image,
                fit: BoxFit.fitHeight,
                width: 150,
              ),
              const SizedBox(height: 20,),
              Text(
                name,
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
