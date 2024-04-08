import 'package:kozmotrust/common/widgets/custom_button.dart';
import 'package:kozmotrust/common/widgets/loader.dart';
import 'package:kozmotrust/features/product_details/services/product_details_services.dart';
import 'package:kozmotrust/features/account/services/account_services.dart';
import 'package:flutter/material.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:kozmotrust/features/product_details/screens/gpt_examine_screen.dart';
import 'package:kozmotrust/constants/global_variables.dart';

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
  List<Product>? favorites = [];
  late String answer = '';
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    productDetailsServices.getGptAnswer(
        context: context,
        product: widget.product,
        onDataReceived: (result) {
          setState(() {
            answer = result; // Update the answer when data is received
          });
        });
    fetchFavorites();
  }

  void navigateToGPT() {
    Navigator.pushNamed(
      context,
      GPTExamineScreen.routeName,
      arguments: answer,
    );
  }

  void fetchFavorites() async {
    favorites = await accountServices.fetchFavorites(context: context);
    setState(() {});
  }

  bool isFavorite(Product product) {
    return favorites!.any((favProduct) => favProduct.id == product.id);
  }

  void addToFavorites() async {
    productDetailsServices.addToFavorites(
      context: context,
      product: widget.product,
    );
    fetchFavorites(); // Refresh the favorites list
  }

  void removeFromFavorites() async {
    productDetailsServices.removeFromFavorites(
      context: context,
      product: widget.product,
    );
    fetchFavorites(); // Refresh the favorites list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: GlobalVariables.selectedTopBarColor),
          ),
          elevation: 0,
          centerTitle: true,
          title: Image.asset('assets/images/logo.png'),
          actions: [
            answer == ''
                ? const Loader()
                : IconButton(
                    icon: const Icon(
                      Icons.question_answer_outlined,
                      color: GlobalVariables.gptIconColor,
                    ),
                    onPressed: navigateToGPT,
                  ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Image.network(
                    'https://4.imimg.com/data4/OR/CH/MY-24500503/catageroy-1-500x500.jpg',
                    fit: BoxFit.fitHeight,
                    height: MediaQuery.of(context).size.width / 4,
                    width: MediaQuery.of(context).size.width / 4,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Text('😢');
                    },
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Column(
                    children: [
                      Container(
                        width: 235,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          widget.product.brand,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          widget.product.name,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.025,
                  vertical: MediaQuery.of(context).size.height * 0.01),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Product Description: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: widget.product.description,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.025,
                  vertical: MediaQuery.of(context).size.height * 0.01),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text: "Ingredients: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: widget.product.ingredients,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.025,
                    vertical: MediaQuery.of(context).size.height * 0.01),
                child: Column(
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Is product ...?: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 10),
                        RichText(
                          text: TextSpan(
                            text: "Combination: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ),
                        Checkbox(
                          value: widget.product.combination,
                          onChanged:
                              null, // Set onChanged to null to make the checkbox non-changeable
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "For normal skin: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ),
                        Checkbox(
                          value: widget.product.normal,
                          onChanged:
                              null, // Set onChanged to null to make the checkbox non-changeable
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 10),
                        RichText(
                          text: TextSpan(
                            text: "For oily skin: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ),
                        Checkbox(
                          value: widget.product.oily,
                          onChanged:
                              null, // Set onChanged to null to make the checkbox non-changeable
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "For dry skin: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ),
                        Checkbox(
                          value: widget.product.dry,
                          onChanged:
                              null, // Set onChanged to null to make the checkbox non-changeable
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 10),
                        RichText(
                          text: TextSpan(
                            text: "For sensitive skin: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ),
                        Checkbox(
                          value: widget.product.sensitive,
                          onChanged:
                              null, // Set onChanged to null to make the checkbox non-changeable
                        ),
                      ],
                    ),
                  ],
                )),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                icon: isFavorite(widget.product)
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                text: isFavorite(widget.product)
                    ? 'Remove from favorites'
                    : 'Add to favorites',
                onTap: () {
                  if (isFavorite(widget.product)) {
                    removeFromFavorites();
                  } else {
                    addToFavorites();
                  }
                },
                color: isFavorite(widget.product)
                    ? Colors.red
                    : Colors.red.shade400,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
