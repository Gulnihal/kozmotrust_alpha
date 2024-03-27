import 'package:kozmotrust/common/widgets/loader.dart';
import 'package:kozmotrust/common/widgets/custom_textfield.dart';
import 'package:kozmotrust/constants/global_variables.dart';
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
  List<Product>? favorites;
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
        : GridView.builder(
          itemCount: favorites!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
          itemBuilder: (context, index) {
            final favoritesData = favorites![index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ProductDetailScreen.routeName,
                  arguments: favoritesData,
                );
              },
              child: SizedBox(
                height: 140,
                child: SingleProduct(
                  name: favoritesData.name[0],
                  image: favoritesData.image[0],
                ),
              ),
            );
          },
    );
  }
}
