import 'dart:convert';

import 'package:kozmotrust/models/rating.dart';

class Product {
  final String? id;
  final String name;
  final String description;
  final List<String> images;
  final String ingredients;
  final String category;
  final List<Rating>? rating;
  Product({
    this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.ingredients,
    required this.category,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'images': images,
      'ingredients': ingredients,
      'category': category,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      ingredients: map['ingredients'] ?? '',
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
