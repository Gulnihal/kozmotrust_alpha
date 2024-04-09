import 'package:kozmotrust/features/admin/services/admin_services.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:flutter/material.dart';

class AdminSearchedProduct extends StatefulWidget {
  final Product product;
  const AdminSearchedProduct({
    super.key,
    required this.product,
  });
  @override
  State<AdminSearchedProduct> createState() =>
      _AdminSearchedProductState();
}

class _AdminSearchedProductState extends State<AdminSearchedProduct> {
  final AdminServices adminServices = AdminServices();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red.shade200,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/sample.png',
                  fit: BoxFit.contain,
                  height: 135,
                  width: 135,
                ),
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
        ],
      ),
    );
  }
}
