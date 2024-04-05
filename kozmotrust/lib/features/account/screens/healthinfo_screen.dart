import 'package:kozmotrust/features/account/services/account_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kozmotrust/common/widgets/custom_button.dart';
import 'package:kozmotrust/common/widgets/custom_textfield.dart';
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

  Future<void> updateInfo() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // Allow dismissal by tapping outside
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text('Update Health Information:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  key: _healthinfoFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/50),
                      const Text(
                        "You can add any information you desired like your health background or your skin type:",
                        style: TextStyle(
                          fontSize: 16, // Set the font size to 24
                          fontWeight: FontWeight.bold, // Make the text bold
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/50),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 20,
                          right: 10,
                        ),
                        child: CustomTextField(
                          controller: _healthinfoController,
                          hintText: _healthinfoController.text,
                          filled: false,
                          maxLines: (MediaQuery.of(context).size.height/100).round(),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/50),
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
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.cyan.shade50,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height/3.5,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Column (
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: Text(
                      'Your General Health Information:',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height/50,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 20,
                    right: 10,
                  ),
                  child: Text(
                    healthinfo,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height/60,
                    ),
                  )
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
                    _healthinfoController.text = healthinfo.toString();
                    updateInfo();
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
