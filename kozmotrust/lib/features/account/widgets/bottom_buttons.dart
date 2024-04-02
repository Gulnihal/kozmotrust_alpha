import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/account/services/account_services.dart';
import 'package:kozmotrust/features/account/widgets/account_button.dart';
import 'package:kozmotrust/features/account/screens/account_settings.dart';
import 'package:flutter/material.dart';

class BottomButtons extends StatefulWidget {
  const BottomButtons({super.key});
  @override
  State<BottomButtons> createState() => _BottomButtonsState();

}
class _BottomButtonsState extends State <BottomButtons> {
  void navigateToAccountSettings() {
    Navigator.pushNamed(context, AccountSettings.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.2,
              child: AccountButton(
                      text: 'Account\nSettings',
                      icon: Icons.settings_outlined,
                      background: GlobalVariables.buttonBackgroundColor,
                      onTap: () => navigateToAccountSettings(),
                    ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.2,
              child: AccountButton(
                text: 'Logout',
                icon: Icons.logout_outlined,
                background: GlobalVariables.buttonBackgroundColor,
                onTap: () => AccountServices().logOut(context),
              ),
            ),
          ]
        ),
      ],
    );
  }
}
