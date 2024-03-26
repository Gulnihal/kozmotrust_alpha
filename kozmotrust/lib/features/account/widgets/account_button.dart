import 'package:flutter/material.dart';
import 'package:kozmotrust/constants/global_variables.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const AccountButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 40, // Adjust the height of the button as needed
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: GlobalVariables.buttonBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // Set border radius to 50
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 8), // Add spacing between icon and text
            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
