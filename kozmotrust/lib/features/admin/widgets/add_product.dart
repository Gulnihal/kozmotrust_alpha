import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:kozmotrust/common/widgets/custom_button.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/constants/utils.dart';
import 'package:kozmotrust/common/widgets/custom_textfield.dart';
import 'package:kozmotrust/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productBrandController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  bool pcombination = false;
  bool pdry = false;
  bool pnormal = false;
  bool poily = false;
  bool psensitive = false;

  String category = 'Skin Care';

  String? path;
  String defaultPath = 'assets/images/productsample.png';
  File? pimage = File('assets/images/productsample.png');

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

  // TODO image path function should be fixed, default path is provided temporarily
  Future<String> saveImageAndGetPath(File imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName =
        'product_image_${DateTime.now().millisecondsSinceEpoch}.png';
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    return savedImage.path;
  }

  void selectImage() async {
    var res = await pickImage();
    if (res != null) {
      setState(() {
        pimage = res;
        saveImageAndGetPath(res).then((path) {
          setState(() {
            this.path = path;
          });
        });
      });
    }
  }

  void addProduct() {
    if (_addProductFormKey.currentState!.validate()) {
      adminServices.addProduct(
        context: context,
        brand: productBrandController.text,
        name: productNameController.text,
        description: descriptionController.text,
        ingredients: ingredientsController.text,
        category: category,
        image: defaultPath,
        combination: pcombination,
        dry: pdry,
        normal: pnormal,
        oily: poily,
        sensitive: psensitive,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(5),
            color: Colors.lightGreen.shade50
        ),
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Product:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height / 50,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    child: Form(
                      key: _addProductFormKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: productBrandController,
                              filled: false,
                              hintText: 'Product Brand',
                            ),
                            const SizedBox(height: 5),
                            CustomTextField(
                              controller: productNameController,
                              filled: false,
                              hintText: 'Product Name',
                            ),
                            const SizedBox(height: 5),
                            CustomTextField(
                              controller: descriptionController,
                              filled: false,
                              hintText: 'Description',
                              maxLines: 1,
                            ),
                            const SizedBox(height: 5),
                            CustomTextField(
                              controller: ingredientsController,
                              filled: false,
                              hintText: 'Ingredients',
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text(
                                  "Category: ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 25),
                                SizedBox(
                                  width:
                                      200, // Provide a fixed width or adjust as needed
                                  child: Container(
                                    // Wrap DropdownButton with Container
                                    decoration: BoxDecoration(
                                      color: GlobalVariables.backgroundColor,
                                      borderRadius: BorderRadius.circular(
                                          8), // Optional: Add border radius
                                    ),
                                    child: Center(
                                      child: DropdownButton<String>(
                                        value: category,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        style: const TextStyle(
                                            color: Colors
                                                .black), // Set dropdown button text color
                                        underline:
                                            Container(), // Hide the default underline
                                        items: productCategories
                                            .map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Container(
                                              // Wrap dropdown item text with Container
                                              color: GlobalVariables.backgroundColor,
                                              child: Text(item),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newVal) {
                                          if (newVal != null) {
                                            setState(() {
                                              category = newVal;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              // Wrap DropdownButton with Container
                              decoration: BoxDecoration(
                                color: GlobalVariables.backgroundColor,
                                borderRadius: BorderRadius.circular(
                                    8), // Optional: Add border radius
                              ),
                              child: Center(
                                child: path != null
                                    ? Image.file(
                                        pimage!,
                                        fit: BoxFit.cover,
                                        height: 20,
                                        width: 20,
                                      )
                                    : GestureDetector(
                                        onTap: selectImage,
                                        child: DottedBorder(
                                          borderType: BorderType.RRect,
                                          radius: const Radius.circular(10),
                                          dashPattern: const [10, 4],
                                          strokeCap: StrokeCap.round,
                                          child: Container(
                                            width: double.infinity,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.folder_open,
                                                  size: 40,
                                                ),
                                                SizedBox(height: 15),
                                                Text(
                                                  'Select Product Image',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            Row(
                              children: [
                                const Text("Dry: "),
                                Checkbox(
                                  value: pdry,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      pdry = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Normal: "),
                                Checkbox(
                                  value: pnormal,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      pnormal = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Oily: "),
                                Checkbox(
                                  value: poily,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      poily = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Sensitive: "),
                                Checkbox(
                                  value: psensitive,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      psensitive = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomButton(
                              text: 'Add Product',
                              onTap: addProduct,
                              icon: Icons.add_circle_outline_outlined,
                              color: GlobalVariables.backgroundColor,
                              textColor: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
