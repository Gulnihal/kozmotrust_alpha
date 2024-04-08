import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:kozmotrust/features/search/widget/searched_product.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/search/screens/search_screen.dart';

import 'package:kozmotrust/common/widgets/loader.dart';
import 'package:kozmotrust/features/product_details/screens/product_details_screen.dart';
import 'package:kozmotrust/features/camsearch/services/cam_search_services.dart';

class RecognizePage extends StatefulWidget {
  final String? path;
  const RecognizePage({
    super.key,
    this.path,
  });

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;
  List<Product>? products;
  late List<String> searchQueries;
  final CamSearchServices camSearchServices = CamSearchServices();
  TextEditingController controller = TextEditingController();

  fetchSearchedProduct() async {
    // Check if there's a search query available
    if (searchQueries != []) {
      // Use the search query to fetch products
      products = await camSearchServices.fetchSearchedProduct(
          context: context,
          searchQueries: searchQueries); // Use widget.searchQuery directly
      setState(() {});
    }
  }


  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    final InputImage inputImage = InputImage.fromFilePath(widget.path!);
    processImage(inputImage);
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
                            // TODO gpt asss text
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

  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isBusy = true;
    });

    // Processing the image
    final RecognizedText recognizedText = await textRecognizer.processImage(image);

    // Splitting the recognized text into lines
    List<String> lines = recognizedText.text.split('\n');

    // Example usage: Assigning the list of strings to a controller or state variable
    // This is just an example. Adapt it according to your actual needs
    // For instance, if you have a List<String> in your state to hold the lines
    searchQueries = lines;

    setState(() {
      _isBusy = false;
    });
  }

}
