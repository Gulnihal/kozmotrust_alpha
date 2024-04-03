import 'package:flutter/material.dart';

class CustomTextFieldWithEye extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextFieldWithEye(
      {super.key, required this.controller, required this.hintText});

  @override
  State<CustomTextFieldWithEye> createState() => _CustomTextFieldWithEyeState();
}

class _CustomTextFieldWithEyeState extends State<CustomTextFieldWithEye> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextField(
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: const OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.black38,
            )),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.black38,
            )),
          ),
        ),
        IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ],
    );
  }
}
