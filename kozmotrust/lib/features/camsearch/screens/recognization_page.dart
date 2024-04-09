import 'package:flutter/material.dart';
import 'package:kozmotrust/features/search/widget/searched_product.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/search/screens/search_screen.dart';
import 'package:kozmotrust/common/widgets/loader.dart';
import 'package:kozmotrust/features/product_details/screens/product_details_screen.dart';
import 'package:kozmotrust/features/camsearch/services/cam_search_services.dart';

class RecognizePage extends StatefulWidget {
  final bool isBusy;
  final List<String> searchQueries;
  const RecognizePage({
    super.key,
    required this.isBusy,
    required this.searchQueries,
  });

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;
  List<Product>? products;
  late String answer = '';
  final CamSearchServices camSearchServices = CamSearchServices();
  TextEditingController controller = TextEditingController();

  fetchSearchedProduct() async {
    // Check if there's a search query available
    if (widget.searchQueries != []) {
      // Use the search query to fetch products
      products = await camSearchServices.fetchSearchedProduct(
          context: context,
          searchQueries:
          widget.searchQueries); // Use widget.searchQuery directly
      setState(() {});
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  Future<void> getAlternativeAnswer() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // Allow dismissal by tapping outside
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text('Here some suggestion for you:'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                answer,
                style: TextStyle(
                  fontSize:
                  MediaQuery.of(context).size.width * 1.5 * 0.025,
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    camSearchServices.getGptAnswer(
        context: context,
        extractedProduct: widget.searchQueries,
        onDataReceived: (result) {
          setState(() {
            answer = result; // Update the answer when data is received
          });
        });
    fetchSearchedProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.selectedTopBarColor,
          ),
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
            onPressed: getAlternativeAnswer,
          ),
        ],
      ),
      body: _isBusy
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : products == null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset('assets/images/logo2.png'),
            ),
            const Loader(),
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            const Text(
              "You can access alternative AI answer from top.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
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
                      ProductDetailScreen.routeName,
                      arguments: products![index],
                    );
                  },
                  child: SearchedProduct(
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
