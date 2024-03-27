import 'package:kozmotrust/features/favorites/services/favorites_services.dart';
import 'package:kozmotrust/features/product_details/services/product_details_services.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:kozmotrust/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesProduct extends StatefulWidget {
  final int index;
  const FavoritesProduct({
    super.key,
    required this.index,
  });

  @override
  State<FavoritesProduct> createState() => _FavoritesProductState();
}

class _FavoritesProductState extends State<FavoritesProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final FavoritesServices favoritesServices = FavoritesServices();

  @override
  Widget build(BuildContext context) {
    final productFavorites = context.watch<UserProvider>().user.favorites[widget.index];
    final product = Product.fromMap(productFavorites['product']);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                product.image,
                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
