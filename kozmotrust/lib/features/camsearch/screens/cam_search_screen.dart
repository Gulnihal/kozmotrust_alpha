import 'package:image_picker/image_picker.dart';
import 'package:kozmotrust/common/widgets/modal_dialog.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:kozmotrust/features/camsearch/CameraUtils/image_picker_class.dart';

class CameraSearchScreen extends StatefulWidget {
  const CameraSearchScreen({Key? key}) : super(key: key);

  @override
  State<CameraSearchScreen> createState() {
    return _CameraSearchScreenState();
  }
}

class _CameraSearchScreenState extends State<CameraSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: GlobalVariables.backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Image.asset('assets/images/logo.png'),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  imagePickerModal(context, onCameraTap: () {
                   pickImage(source: ImageSource.camera).then((value) {
                     if (value != '') {

                     }
                   });
                  } , onGalleryTap: () {
                    pickImage(source: ImageSource.gallery).then((value) {
                      if (value != '') {

                      }
                    });
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Text(
                    'Scan Photo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalVariables.buttonBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  minimumSize: Size(300, 100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

