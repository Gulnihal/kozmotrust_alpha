import 'package:kozmotrust/features/account/services/account_services.dart';
import 'package:kozmotrust/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () => AccountServices().logOut(context),
            ),
            AccountButton(
              text: 'Your Favorite Products',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
