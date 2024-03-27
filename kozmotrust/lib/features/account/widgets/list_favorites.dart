import 'package:kozmotrust/common/widgets/loader.dart';
import 'package:kozmotrust/features/account/services/account_services.dart';
import 'package:kozmotrust/features/account/widgets/single_product.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:flutter/material.dart';
import 'package:kozmotrust/features/product_details/screens/product_details_screen.dart';

class ListFavorites extends StatefulWidget {
  const ListFavorites({super.key});

  @override
  State<ListFavorites> createState() => _ListFavoritesState();
}

class _ListFavoritesState extends State<ListFavorites> {
  List<Product>? favorites = [];
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  void fetchFavorites() async {
    favorites = await accountServices.fetchFavorites(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return favorites == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: const Text(
                      'Your Favorite Products',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              // display favorites
              Container(
                height: 170,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 0,
                ),
                child: favorites!.isEmpty // Add a null check here
                    ? const Center(
                        child: Text('No favorite products found'),
                      )
                    : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: favorites!.length,
                  itemBuilder: (context, index) {
                    final favoriteProduct = favorites![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ProductDetailScreen.routeName,
                          arguments: favoriteProduct,
                        );
                      },
                      child: SingleProduct(
                        brand: favorites![index].brand,
                        name: favorites![index].name,
                        image: Uri.parse(favorites![index].image).toString(),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }

}
