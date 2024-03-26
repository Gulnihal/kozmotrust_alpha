import 'package:kozmotrust/features/account/services/account_services.dart';
import 'package:kozmotrust/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              child: AccountButton(
                      text: 'Account Settings',
                      icon: Icons.settings_outlined,
                      onTap: () {},
                    ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              child: AccountButton(
                text: 'Logout',
                icon: Icons.logout_outlined,
                onTap: () => AccountServices().logOut(context),
              ),
            ),
          ]
        ),
      ],
    );
  }
}
