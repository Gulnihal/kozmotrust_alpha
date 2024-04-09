import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<File?> pickImage() async {
  File? image;
  try {
    var pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false, // Set to false to pick only one file
    );
    if (pickedFile != null && pickedFile.files.isNotEmpty) {
      // Only one file is picked, so directly get the first file
      image = File(pickedFile.files[0].path!);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return image;
}