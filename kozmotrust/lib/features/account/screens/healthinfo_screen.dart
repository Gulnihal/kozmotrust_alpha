import 'package:kozmotrust/features/account/services/account_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kozmotrust/common/widgets/custom_button.dart';
import 'package:kozmotrust/providers/user_provider.dart';

class HealthInformationScreen extends StatefulWidget {
  static const String routeName = '/healthinfo';
  const HealthInformationScreen({
    super.key,
  });

  @override
  State<HealthInformationScreen> createState() => _HealthInformationScreenState();
}

class _HealthInformationScreenState extends State<HealthInformationScreen> {
  final TextEditingController _healthinfoController = TextEditingController();
  final AccountServices accountServices = AccountServices();
  final _healthinfoFormKey = GlobalKey<FormState>();

  void updateHealthInformation() {
    accountServices.saveHealthInformation(
      context: context,
      healthinfo: _healthinfoController.text,
    );
  }
  
  @override
  void initState() {
    super.initState();
  }

  Future<void> updateInfo(String? existingInfo) async {
    _healthinfoController.text = existingInfo ?? '';
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // Allow dismissal by tapping outside
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text('Update Health Information:'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: ListBody(
                children: <Widget>[
                  Form(
                    key: _healthinfoFormKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "You can add any information you desired like your health background or your skin type:",
                          style: TextStyle(
                            fontSize: 16, // Set the font size to 24
                            fontWeight: FontWeight.bold, // Make the text bold
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 20,
                            right: 10,
                          ),
                          child: TextField(
                            enabled: true,
                            controller: _healthinfoController,
                            maxLines: null, // Allows for unlimited lines
                            keyboardType: TextInputType.multiline, // Specifies the keyboard type
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                ),
                              ),
                              hintText: _healthinfoController.text, // Your hint text here
                            ),
                            autofocus: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: 'Update',
                          icon: Icons.edit_note_outlined,
                          color: Colors.lightBlueAccent,
                          onTap: () {
                            if (_healthinfoFormKey.currentState!.validate()) {
                              updateHealthInformation();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    var healthinfo = context.watch<UserProvider>().user.healthinfo;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.cyan.shade700,
            width: 5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.cyan.shade50,
        ),
        child: Container(
          height: MediaQuery.of(context).size.width/2.5,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Column (
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 15,
                    ),
                    child: const Text(
                      'Your General Health Information:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38), // Add border
                    borderRadius: BorderRadius.circular(5), // Add border radius
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      healthinfo,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Adjust color as needed
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: CustomButton(
                  text: "Update",
                  icon:Icons.edit_note_outlined,
                  color: Colors.blue.shade200,
                  onTap: () {
                    updateInfo(healthinfo);
                  },
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
