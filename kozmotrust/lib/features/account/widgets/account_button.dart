import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color background;
  final VoidCallback onTap;

  const AccountButton({
    super.key,
    required this.text,
    required this.icon,
    required this.background,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.width * 0.5, // Adjust the height of the button as needed
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
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
            SizedBox(width: MediaQuery.of(context).size.width / 25), // Add spacing between icon and text
            Text(
              text,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
