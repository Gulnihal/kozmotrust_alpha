import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/home/services/home_services.dart';
import 'package:flutter/material.dart';
import 'package:kozmotrust/providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserProvider userService = UserProvider();
  Future<String> getUserName() async {
    print(userService.user.username+ "sdjkmsjdfm");
    return userService.user.username;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: GlobalVariables.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
          const SizedBox(height: 100),
          Center( // Center the text horizontally
            child: Text(
              "Welcome ${userService.user.username}!",
              style: const TextStyle(
                fontSize: 24, // Set the font size to 24
                fontWeight: FontWeight.bold, // Make the text bold
              ),
            ),
          ),
          const SizedBox(height: 100), // Added SizedBox for spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for button 1
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalVariables.buttonBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Set border radius to 10
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Expanded(
                        child: Image.asset(
                          'assets/images/profile.png',
                          fit: BoxFit.contain, // Make the image fit within the button
                        ),
                      ),
                      const SizedBox(height: 8), // Add spacing between image and text
                      const Text(
                        'Profile',
                        style: TextStyle(fontSize: 20), // Increase the font size of the text
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for button 2
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalVariables.buttonBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Set border radius to 10
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Expanded(
                        child: Image.asset(
                          'assets/images/profile.png',
                          fit: BoxFit.contain, // Make the image fit within the button
                        ),
                      ),
                      const SizedBox(height: 8), // Add spacing between image and text
                      const Text(
                        'Scanner',
                        style: TextStyle(fontSize: 20), // Increase the font size of the text
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20), // Added SizedBox for spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality for button 1
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalVariables.buttonBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Set border radius to 10
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Expanded(
                      child: Image.asset(
                        'assets/images/profile.png',
                        fit: BoxFit.contain, // Make the image fit within the button
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality for button 2
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalVariables.buttonBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Set border radius to 10
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Expanded(
                      child: Image.asset(
                        'assets/images/profile.png',
                        fit: BoxFit.contain, // Make the image fit within the button
                      ),
                    ),
                    const SizedBox(height: 8), // Add spacing between image and text
                    const Text(
                      'Insights',
                      style: TextStyle(fontSize: 20), // Increase the font size of the text
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
          ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: GlobalVariables.selectedTopBarColor,
      elevation: 0,
      centerTitle: true,
      title: Image.asset('assets/images/logo.png'),
    );
  }
}
