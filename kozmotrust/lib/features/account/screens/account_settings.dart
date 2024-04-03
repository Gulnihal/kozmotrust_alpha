import 'package:kozmotrust/common/widgets/custom_button.dart';
import 'package:kozmotrust/common/widgets/custom_textfield.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/account/services/account_services.dart';
import 'package:flutter/material.dart';

class AccountSettings extends StatefulWidget {
  static const String routeName = '/update';
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordDeleteController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final AccountServices accountServices = AccountServices();
  final _updatePasswordFormKey = GlobalKey<FormState>();
  final _deleteAccountFormKey = GlobalKey<FormState>();

  void updatePassword() {
    accountServices.updatePassword(
      context: context,
      password: _passwordController.text,
      newPassword: _newPasswordController.text,
    );
  }

  void deleteAccount() {
    accountServices.deleteAccount(
      context: context,
      password: _passwordDeleteController.text,
    );
  }

  Future<void> askPassword() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // Allow dismissal by tapping outside
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text('Deleting Account:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  key: _deleteAccountFormKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      const Text(
                        "Enter Your Password!",
                        style: TextStyle(
                          fontSize: 24, // Set the font size to 24
                          fontWeight: FontWeight.bold, // Make the text bold
                        ),
                      ),
                      const SizedBox(height: 50),
                      CustomTextField(
                        controller: _passwordDeleteController,
                        hintText: 'Password',
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        icon: Icons.delete_forever_outlined,
                        color: GlobalVariables.buttonDeleteColor,
                        text: 'Confirm Deleting Account',
                        onTap: () {
                          if (_deleteAccountFormKey.currentState!.validate()) {
                            deleteAccount();
                          }
                        },
                      )
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
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: GlobalVariables.selectedTopBarColor
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/images/logo.png'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        color: GlobalVariables.backgroundColor,
        child: Column(
          children: [
            Form(
              key: _updatePasswordFormKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: 24, // Set the font size to 24
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                  ),
                  const SizedBox(height: 50),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Current Password',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _newPasswordController,
                    hintText: 'New Password',
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    icon: Icons.update,
                    color: GlobalVariables.buttonBackgroundColor,
                    text: 'Change Password',
                    onTap: () {
                      if (_updatePasswordFormKey.currentState!.validate()) {
                        updatePassword();
                      }
                    },
                  )
                ],
              ),
            ),
            const Expanded(
              child: SizedBox(), // Add any other content here
            ),
            SizedBox(
              child: CustomButton(
                text: 'Delete Account',
                icon: Icons.delete,
                color: GlobalVariables.buttonDeleteColor,
                onTap: () {
                  askPassword();
                },
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
