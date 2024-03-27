import 'dart:convert';
import 'dart:ffi';

import 'package:kozmotrust/models/rating.dart';

class Product {
  final String? id;
  final String name;
  final String brand;
  final String description;
  final String image;
  final String ingredients;
  final String category;
  final Bool combination;
  final Bool dry;
  final Bool normal;
  final Bool oily;
  final Bool sensitive;

  final List<Rating>? rating;

  Product({
    this.id,
    required this.description,
    required this.brand,
    required this.name,
    required this.image,
    required this.ingredients,
    required this.category,
    required this.combination,
    required this.dry,
    required this.normal,
    required this.oily,
    required this.sensitive,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'brand': brand,
      'name': name,
      'image': image,
      'ingredients': ingredients,
      'category': category,
      'combination': combination,
      'dry': dry,
      'normal': normal,
      'oily': oily,
      'sensitive': sensitive,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'],
      description: map['description'] ?? '',
      brand: map['brand'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      category: map['category'] ?? '',
      ingredients: map['ingredients'] ?? '',
      combination: map['combination'],
      dry: map['dry'],
      normal: map['normal'],
      oily: map['oily'],
      sensitive: map['sensitive'],
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
