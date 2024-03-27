import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool enabled;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          ))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
