import 'package:kozmotrust/features/admin/screens/update_delete_product_screen.dart';
import 'package:kozmotrust/features/admin/services/admin_services.dart';
import 'package:kozmotrust/features/admin/widgets/admin_searched_product.dart';
import 'package:kozmotrust/features/search/services/search_services.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AdminEditDeleteScreen extends StatefulWidget {
  static const String routeName = '/search-edit-delete-screen';
  final String searchQuery;
  const AdminEditDeleteScreen({
    super.key,
    required this.searchQuery,
  });

  @override
  State<AdminEditDeleteScreen> createState() =>
      _AdminEditDeleteScreenState();
}

class _AdminEditDeleteScreenState extends State<AdminEditDeleteScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  fetchSearchedProduct() async {
    if (widget.searchQuery != '') {
      products = await searchServices.fetchSearchedProduct(
          context: context, searchQuery: widget.searchQuery);
      setState(() {});
    }
  }
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, AdminEditDeleteScreen.routeName, arguments: query);
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search in Kozmotrust',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: products == null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset('assets/images/logo2.png'),
            ),
          ],
        ),
      )
          : products!.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning,
              size: 100,
              color: Colors.red,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            const Text(
              "The product is not found.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 28,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      )
          : Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: products!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      UpdateDeleteProductScreen.routeName,
                      arguments: products![index],
                    );
                  },
                  child: AdminSearchedProduct(
                    product: products![index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
