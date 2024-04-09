import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kozmotrust/common/widgets/modal_dialog.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'package:kozmotrust/features/camsearch/widgets/image_cropper_page.dart';
import 'package:kozmotrust/features/camsearch/widgets/image_picker_class.dart';
import 'package:kozmotrust/features/camsearch/screens/recognization_page.dart';

class CameraSearchScreen extends StatefulWidget {
  static const String routeName = '/cam-search-screen';
  const CameraSearchScreen({Key? key}) : super(key: key);

  @override
  State<CameraSearchScreen> createState() {
    return _CameraSearchScreenState();
  }
}

class _CameraSearchScreenState extends State<CameraSearchScreen> {
  bool _isBusy = false;
  String? path;
  late List<String> searchQueries = [];
  late InputImage inputImage;

  Future<void> processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isBusy = true;
    });

    // Processing the image
    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    // Splitting the recognized text into lines
    List<String> lines = recognizedText.text.split('\n');
    searchQueries = lines;

    setState(() {
      _isBusy = false;
    });
  }

  @override
  void initState() {
    super.initState();
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
        title: Image.asset('assets/images/logo.png'),
      ),
      body: _isBusy
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator when busy
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Image.asset('assets/images/logo2.png'),
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () async {
                        await imagePickerModal(context, onCameraTap: () async {
                          String? pickedImagePath =
                              await pickImage(source: ImageSource.camera);
                          if (pickedImagePath != null &&
                              pickedImagePath.isNotEmpty) {
                            String? croppedImagePath = await imageCropperView(
                                pickedImagePath, context);
                            if (croppedImagePath != null &&
                                croppedImagePath.isNotEmpty) {
                              path = croppedImagePath;
                              inputImage = InputImage.fromFilePath(path!);
                              await processImage(inputImage);
                              if (!mounted) return;
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => RecognizePage(
                                    isBusy: _isBusy,
                                    searchQueries: searchQueries,
                                  ),
                                ),
                              );
                            }
                          }
                        }, onGalleryTap: () async {
                          String? pickedImagePath =
                              await pickImage(source: ImageSource.gallery);
                          if (pickedImagePath != null &&
                              pickedImagePath.isNotEmpty) {
                            String? croppedImagePath = await imageCropperView(
                                pickedImagePath, context);
                            if (croppedImagePath != null &&
                                croppedImagePath.isNotEmpty) {
                              path = croppedImagePath;
                              inputImage = InputImage.fromFilePath(path!);
                              await processImage(inputImage);
                              if (!mounted) return;
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => RecognizePage(
                                    isBusy: _isBusy,
                                    searchQueries: searchQueries,
                                  ),
                                ),
                              );
                            }
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalVariables.buttonBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        child: Text(
                          'Scan Your Product',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height / 35),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
    );
  }
}
