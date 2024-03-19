import 'package:kozmotrust/constants.dart';
import 'package:kozmotrust/screens/detail/widget/my_header.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            const MyHeader(),
            Positioned(
              top: 290,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                decoration: BoxDecoration(
                  color: nDarkBackgroundColor,
                ),
                child: const Column(
                  children: [
                    Text(
                      'Make up beauty products',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec semper, libero in finibus convallis, purus velit vehicula nulla, id mattis nibh risus a elit. Nullam sit amet est consequat, venenatis velit at, vulputate elit. Morbi ante dolor, hendrerit eu lacus mollis, euismod egestas dui. Quisque imperdiet id velit non efficitur. Mauris justo dolor, aliquet et arcu at, luctus lobortis mi. In sit amet faucibus nunc, eu mattis lacus. Quisque eu mi nec mauris malesuada tincidunt quis non neque. Maecenas viverra, est non venenatis mollis, quam velit suscipit nisi, rutrum ornare enim quam in nisl. Vivamus et facilisis augue, cursus commodo quam.',
                      style: TextStyle(
                        height: 1.8,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
