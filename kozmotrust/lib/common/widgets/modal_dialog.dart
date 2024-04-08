import 'package:flutter/material.dart';
import 'package:kozmotrust/constants/global_variables.dart';

void imagePickerModal(BuildContext context, {VoidCallback? onCameraTap, VoidCallback? onGalleryTap}){
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 250,
        child: Column(
          children: [
            GestureDetector(
            onTap: onCameraTap,
            child: Card(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(color: GlobalVariables.buttonBackgroundColor),
                child: Text(
                  "Camera",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ),
            const SizedBox( height: 10),
            GestureDetector(
             onTap: onGalleryTap,
             child: Card(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(color: GlobalVariables.buttonBackgroundColor),
                child: Text(
                  "Gallery",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ),
          ],
        ),
      );
    },
  );
}
