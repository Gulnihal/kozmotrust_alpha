import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kozmotrust/constants/utils.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:dotted_border/dotted_border.dart';
import 'package:kozmotrust/common/widgets/custom_button.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:kozmotrust/common/widgets/custom_textfield.dart';
import 'package:kozmotrust/features/insights/services/blog_service.dart';

class AddBlog extends StatefulWidget {
  static const String routeName = '/add-blog';
  const AddBlog({super.key});
  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  late String path = '';
  late File? pimage;

  final _blogFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  void addBlog() async {
    if (!_blogFormKey.currentState!.validate()) {
      return;
    }
    try {
      await blogServices.addBlog(
        context: context,
        title: titleController.text,
        body: bodyController.text,
        image: path,
      );

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

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
        '${titleController.text}.png';
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

  final BlogServices blogServices = BlogServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: GlobalVariables.selectedTopBarColor),
        ),
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/images/logo.png'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(5),
              color: Colors.lightGreen.shade50),
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.4,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add Product:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height / 50,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      child: Form(
                        key: _blogFormKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: titleController,
                                filled: false,
                                hintText: 'Title',
                              ),
                              const SizedBox(height: 5),
                              const SizedBox(height: 10),
                              // TODO image pick should be fixed
                              Container(
                                // Wrap DropdownButton with Container
                                decoration: BoxDecoration(
                                  color: GlobalVariables.backgroundColor,
                                  borderRadius: BorderRadius.circular(
                                      8), // Optional: Add border radius
                                ),
                                child: Center(
                                  child: path != ''
                                      ? Container(
                                    child: pimage != null
                                        ? Image.file(pimage!)
                                        : Placeholder(),
                                  )
                                      : GestureDetector(
                                    onTap: selectImage,
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(10),
                                      dashPattern: const [10, 4],
                                      strokeCap: StrokeCap.round,
                                      child: Container(
                                        width: double.infinity,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                        child: const Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.folder_open,
                                              size: 40,
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Select Product Image',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              CustomTextField(
                                controller: bodyController,
                                filled: false,
                                hintText: 'Blog Body',
                              ),
                              const SizedBox(height: 10),
                              CustomButton(
                                text: 'Add Blog',
                                onTap: addBlog,
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
      ),
    );
  }
}
