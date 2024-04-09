import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

class SkinTypeDetectPage extends StatefulWidget {
  const SkinTypeDetectPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SkinTypeDetectPage> createState() => _SkinTypeDetectPageState();
}

class _SkinTypeDetectPageState extends State<SkinTypeDetectPage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMKey = GlobalKey<ScaffoldMessengerState>();
  bool isDetectingSkinType = false;
  XFile? imageFile;
  String skinType = "";
  Size? imageSize;
  List<Face> faces = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isDetectingSkinType) const CircularProgressIndicator.adaptive(),
              if (!isDetectingSkinType && imageFile == null)
                Container(
                  width: 300,
                  height: 300,
                  color: Colors.grey[400],
                  child: Center(child: Text("Upload your face photo...")),
                ),
              if (imageFile != null && !isDetectingSkinType)
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.file(
                      File(imageFile!.path),
                      width: 350,
                      height: 450,
                      fit: BoxFit.contain,
                    ),
                    CustomPaint(
                      painter: FacePainter(imageSize: imageSize, faces: faces),
                      size: Size(350, 450),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 480.0),
                      child: Text(
                        skinType,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              buildImageSelectionRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageSelectionRow() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ElevatedButton.icon(
              onPressed: () => onPickImageSelected('Camera'),
              icon: Icon(Icons.camera_alt_rounded),
              label: Text("Camera"),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ElevatedButton.icon(
              onPressed: () => onPickImageSelected('Gallery'),
              label: Text("Gallery"),
              icon: Icon(Icons.image_rounded),
            ),
          ),
        ),
      ],
    );
  }

  void onPickImageSelected(String source) async {
    ImageSource imageSource = source == "Camera" ? ImageSource.camera : ImageSource.gallery;
    try {
      final file = await ImagePicker().pickImage(source: imageSource);
      if (file != null) {
        setState(() {
          isDetectingSkinType = true;
          imageFile = file;
        });
        await getImageSize(file);
        await analyzeSkinType(file);
      }
    } catch (e) {
      setState(() {
        isDetectingSkinType = false;
        imageFile = null;
        skinType = "Error occurred while getting image";
      });
      final scaffoldState = _scaffoldMKey.currentState;
      scaffoldState?.showSnackBar(SnackBar(content: Text(e.toString()), duration: const Duration(seconds: 4)));
    }
  }

  Future<void> getImageSize(XFile file) async {
    final File imageFile = File(file.path);
    final img = await decodeImageFromList(imageFile.readAsBytesSync());
    setState(() {
      imageSize = Size(img.width.toDouble(), img.height.toDouble());
    });
  }

  Future<void> analyzeSkinType(XFile source) async {
    final inputImage = InputImage.fromFilePath(source.path);
    final faceDetector = FaceDetector(options: FaceDetectorOptions(enableContours: true));
    faces = await faceDetector.processImage(inputImage);


    for (Face face in faces) {
      final contours = face.contours;
      final faceContour = contours[FaceContourType.face];
      if (faceContour != null) {
        if (faceContour.points.length > 75) {
          skinType = "Skin type: Oily";
        } else if (faceContour.points.length <= 75 && faceContour.points.length > 50) {
          skinType = "Skin type: Combination";
        } else {
          skinType = "Skin type: Dry";
        }
      } else {
        skinType = "Face contour not found";
      }
    }

    setState(() {
      isDetectingSkinType = false;
    });
    faceDetector.close();
  }
}

class FacePainter extends CustomPainter {
  final Size? imageSize;
  final List<Face> faces;

  FacePainter({this.imageSize, required this.faces});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    for (var face in faces) {
      final rect = face.boundingBox;
      final scaleX = size.width / (imageSize?.width ?? 1);
      final scaleY = size.height / (imageSize?.height ?? 1);
      final Rect scaledRect = Rect.fromLTRB(
        rect.left * scaleX,
        rect.top * scaleY,
        rect.right * scaleX,
        rect.bottom * scaleY,
      );
      canvas.drawRect(scaledRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
