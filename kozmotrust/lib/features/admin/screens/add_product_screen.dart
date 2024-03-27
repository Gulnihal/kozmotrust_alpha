import 'dart:io';
import 'package:kozmotrust/common/widgets/custom_textfield.dart';
import 'package:kozmotrust/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productBrandController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  // TODO chek it out
  String category = 'Skin Care';
  String image = 'https://4.imimg.com/data4/OR/CH/MY-24500503/catageroy-1-500x500.jpg';
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    productBrandController.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    ingredientsController.dispose();
  }

  List<String> productCategories = [
    'Skin Care',
    'Oral Care',
    'Hair Care',
    'Make-up',
    'Perfumes & Deodorant'
  ];

  void addProduct() {
    if (_addProductFormKey.currentState!.validate() && image.isNotEmpty) {
      adminServices.addProduct(
        context: context,
        brand: productBrandController.text,
        name: productNameController.text,
        description: descriptionController.text,
        ingredients: ingredientsController.text,
        category: category,
        image: image,
        combination: null,
        dry: null,
        normal: null,
        oily: null,
        sensitive: null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                image.isNotEmpty
                    ? Builder(
                        builder: (BuildContext context) => Image.file(
                          image as File,
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ) :
                const SizedBox(height: 30),
                CustomTextField(
                  controller: productNameController,
                  hintText: 'Product Name',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: ingredientsController,
                  hintText: 'ingredients',
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
