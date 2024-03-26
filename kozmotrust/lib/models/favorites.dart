import 'dart:convert';

import 'package:kozmotrust/models/product.dart';

class Favorites {
  final String id;
  final List<Product> products;
  Favorites({
    required this.id,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory Favorites.fromMap(Map<String, dynamic> map) {
    return Favorites(
      id: map['_id'] ?? '',
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x['product']))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorites.fromJson(String source) => Favorites.fromMap(json.decode(source));
}
