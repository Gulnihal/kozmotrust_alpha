import 'package:flutter/material.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/admin/widgets/update_delete_product.dart';
import 'package:kozmotrust/features/admin/services/admin_services.dart';

class UpdateDeleteProductScreen extends StatefulWidget {
  static const String routeName = '/update-delete-product-screen';
  final Product product;
  const UpdateDeleteProductScreen({super.key, required this.product});

  @override
  State<UpdateDeleteProductScreen> createState() => _UpdateDeleteProductScreenState();
}

class _UpdateDeleteProductScreenState extends State<UpdateDeleteProductScreen> {
  final AdminServices adminServices = AdminServices();

  Future<void> deleteProduct() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // Allow dismissal by tapping outside
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text('Are you sure deleting this product?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                adminServices.deleteProduct(context: context, product: widget.product);
                if (mounted) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
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
        title: const Text(
          'Admin Product Edit',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
            onPressed: () {
              deleteProduct();
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          Text(
            "Update Product:",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height /
                    50), // Adjust emoji if needed
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          UpdateDeleteProduct(product: widget.product),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
        ],
      ),
    );
  }
}
