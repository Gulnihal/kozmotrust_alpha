import 'package:flutter/cupertino.dart';
import 'package:kozmotrust/common/widgets/custom_button.dart';
import 'package:kozmotrust/features/product_details/services/product_details_services.dart';
import 'package:kozmotrust/providers/user_provider.dart';
import 'package:kozmotrust/features/search/screens/search_screen.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:provider/provider.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void removeFromFavorites() {
    productDetailsServices.removeFromFavorites(
      context: context,
      product: widget.product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: GlobalVariables.selectedTopBarColor,
          elevation: 0,
          centerTitle: true,
          title: Image.asset('assets/images/logo.png'),
        ),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.redAccent.shade700,
            width: 5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.red.shade100,
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row (
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 40,
                ),
                child: Builder(
                  builder: (BuildContext context) => Image.network(
                    'https://4.imimg.com/data4/OR/CH/MY-24500503/catageroy-1-500x500.jpg',
                    fit: BoxFit.contain,
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.brand!,
                          style: const TextStyle(
                            fontSize: 30,// Make the text bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Text(
                      widget.product.name!,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Text(
              "Description: ${widget.product.description!}",
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Text(
              "Ingredients: ${widget.product.ingredients!}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            color: Colors.black12,
            height: 5,
          ),Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Combination of some compounds: ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Checkbox(value: widget.product.combination, onChanged: null),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "For Dry Skin: ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Checkbox(value: widget.product.dry, onChanged: null),
                    const Text(
                      "For Normal Skin: ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Checkbox(value: widget.product.normal, onChanged: null),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "For Oily Skin: ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Checkbox(value: widget.product.oily, onChanged: null),
                    const Text(
                      "For Sensitive Skin: ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Checkbox(value: widget.product.sensitive, onChanged: null),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomButton(
              icon: Icons.favorite_border_outlined,
              text: 'Remove From Favorites',
              onTap: removeFromFavorites,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Rate The Product',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      ),
    );
  }
}
