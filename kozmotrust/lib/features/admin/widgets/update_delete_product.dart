import 'dart:io';
import 'package:kozmotrust/common/widgets/custom_button.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/common/widgets/custom_textfield.dart';
import 'package:kozmotrust/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:kozmotrust/constants/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class UpdateDeleteProduct extends StatefulWidget {
  final Product product;
  const UpdateDeleteProduct({super.key, required this.product});

  @override
  State<UpdateDeleteProduct> createState() => _UpdateDeleteProductState();
}

class _UpdateDeleteProductState extends State<UpdateDeleteProduct> {
  final TextEditingController productBrandController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  late bool pcombination = widget.product.combination;
  late bool pdry = widget.product.dry;
  late bool pnormal = widget.product.normal;
  late bool poily = widget.product.oily;
  late bool psensitive = widget.product.sensitive;
  late String pcategory = widget.product.category;
  late String path = widget.product.image;

  String defaultPath = 'assets/images/sample.png';

  final _updateProductFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    productBrandController.text = widget.product.brand;
    productNameController.text = widget.product.name;
    descriptionController.text = widget.product.description;
    ingredientsController.text = widget.product.ingredients;
  }

  @override
  void dispose() {
    productBrandController.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    ingredientsController.dispose();
    super.dispose();
  }


  List<String> productCategories = [
    'Skin Care',
    'Oral Care',
    'Hair Care',
    'Make-up',
    'Perfumes & Deodorant'
  ];

  late File? pimage;

  Future<File> createFileFromAsset(String assetPath) async {
    // Load the asset
    final byteData = await rootBundle.load(assetPath);
    // Get a temporary directory
    final directory = await getTemporaryDirectory();
    // Create a file path in the temporary directory
    final file = File('${directory.path}/sample.png');
    // Write the asset's bytes to the file
    await file.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );
    return file;
  }

  Future<String> saveImageAndGetPath(File imageFile) async {
    final fileName =
        '${productBrandController.text}_${productNameController.text}.png';
    final savedImage = await imageFile.copy('kozmotrust/assets/images/$fileName');
    return savedImage.path;
  }

  Future<void> selectImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      // Save the image to the app's local directory
      String imagePath = await saveImageAndGetPath(imageFile);
      setState(() {
        pimage = File(imagePath);
        path = imagePath; // This path can be used directly in your app
      });
    }
  }

  void updateProduct() async {
    if (!_updateProductFormKey.currentState!.validate()) {
      return;
    }
    try {
      await adminServices.updateProduct(
        context: context,
        product: widget.product,
        brand: productBrandController.text,
        name: productNameController.text,
        description: descriptionController.text,
        ingredients: ingredientsController.text,
        category: pcategory,
        image: path,
        combination: pcombination,
        dry: pdry,
        normal: pnormal,
        oily: poily,
        sensitive: psensitive,
      );

      if (mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
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
              height: MediaQuery.of(context).size.height / 1.25,
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    child: Form(
                      key: _updateProductFormKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: productBrandController,
                              filled: false,
                              hintText: productBrandController.text,
                            ),
                            const SizedBox(height: 5),
                            CustomTextField(
                              controller: productNameController,
                              filled: false,
                              hintText: productNameController.text,
                            ),
                            const SizedBox(height: 5),
                            CustomTextField(
                              controller: descriptionController,
                              filled: false,
                              hintText: descriptionController.text,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 5),
                            CustomTextField(
                              controller: ingredientsController,
                              filled: false,
                              hintText: ingredientsController.text,
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
                                        value: pcategory,
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
                                              pcategory = newVal;
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
                            // TODO image pick should be fixed
                            // Container(
                            //   // Wrap DropdownButton with Container
                            //   decoration: BoxDecoration(
                            //     color: GlobalVariables.backgroundColor,
                            //     borderRadius: BorderRadius.circular(
                            //         8), // Optional: Add border radius
                            //   ),
                            //   child: Center(
                            //     child: path != ''
                            //         ? Container(
                            //       child: pimage != null
                            //           ? Image.file(pimage!)
                            //           : Placeholder(),
                            //     )
                            //         : GestureDetector(
                            //       onTap: selectImage,
                            //       child: DottedBorder(
                            //         borderType: BorderType.RRect,
                            //         radius: const Radius.circular(10),
                            //         dashPattern: const [10, 4],
                            //         strokeCap: StrokeCap.round,
                            //         child: Container(
                            //           width: double.infinity,
                            //           height: 150,
                            //           decoration: BoxDecoration(
                            //             borderRadius:
                            //             BorderRadius.circular(10),
                            //           ),
                            //           child: const Column(
                            //             mainAxisAlignment:
                            //             MainAxisAlignment.center,
                            //             children: [
                            //               Icon(
                            //                 Icons.folder_open,
                            //                 size: 40,
                            //               ),
                            //               SizedBox(height: 15),
                            //               Text(
                            //                 'Select Product Image',
                            //                 style: TextStyle(
                            //                   fontSize: 15,
                            //                   color: Colors.black,
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Row(
                              children: [
                                const Text("Health Ministry Approval: "),
                                Checkbox(
                                  value: pcombination,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      pcombination = value!;
                                    });
                                  },
                                ),
                              ],
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
                              text: 'Update Product',
                              onTap: updateProduct,
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
