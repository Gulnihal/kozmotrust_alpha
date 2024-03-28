import 'package:kozmotrust/common/widgets/loader.dart';
import 'package:kozmotrust/features/account/services/account_services.dart';
import 'package:kozmotrust/features/account/widgets/single_product.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:flutter/material.dart';
import 'package:kozmotrust/features/product_details/screens/product_details_screen.dart';

class ListAndFindFavorites extends StatefulWidget {
  const ListAndFindFavorites({super.key});

  @override
  State<ListAndFindFavorites> createState() => _ListAndFindFavoritesState();
}

class _ListAndFindFavoritesState extends State<ListAndFindFavorites> {
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
        : SizedBox(
      height: MediaQuery.of(context).size.height/3,
      child: Column(
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
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                left: 10,
                top: 20,
                right: 10,
              ),
              child: favorites!.isEmpty // Add a null check here
                  ? const Center(
                child: Text('No favorite products found'),
              )
                  : ListView.builder(
                scrollDirection: Axis.vertical, // Change scroll direction to vertical
                itemCount: favorites!.length,
                itemBuilder: (context, index) {
                  final favoriteProduct = favorites![index];
                  return GestureDetector(
                      onTap: () {
                        // TODO service function required
                      },
                      child: Column(
                        children: [
                          SingleProduct(
                            brand: favorites![index].brand,
                            name: favorites![index].name,
                            image: favorites![index].image,
                          ),
                          const SizedBox(height: 20),
                        ],
                      )
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }


}
