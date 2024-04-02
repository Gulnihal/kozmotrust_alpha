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
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.redAccent.shade700,
                  width: 5,
                ),
                borderRadius: BorderRadius.circular(5),
                color: Colors.red.shade100,
              ),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                left: 15,
                              ),
                              child: Text(
                                'Your Favorite Products:',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 50,
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
                                    scrollDirection: Axis
                                        .vertical, // Change scroll direction to vertical
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
                                          child: Column(
                                            children: [
                                              SingleProduct(
                                                brand: favorites![index].brand,
                                                name: favorites![index].name,
                                                image: favorites![index].image,
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      50),
                                            ],
                                          ));
                                    },
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  )),
            ),
          );
  }
}
