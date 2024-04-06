import 'package:flutter/material.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class GPTExamineScreen extends StatefulWidget {
  static const String routeName = '/gptexamine';
  final String answer;
  const GPTExamineScreen({
    super.key,
    required this.answer,
  });

  @override
  State<GPTExamineScreen> createState() {
    return _GPTExamineScreenState();
  }
}

class _GPTExamineScreenState extends State<GPTExamineScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: GlobalVariables.selectedTopBarColor),
          ),
          elevation: 0,
          centerTitle: true,
          title: Image.asset('assets/images/logo.png'),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: RichText(
              text: TextSpan(
                text: "Hi ${user.username} ",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '😊', // Smile emoji
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width /
                            15), // Adjust emoji if needed
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Here is a detailed description of the product that includes the information you provided.\nIn case you want to add or change any of the information, please visit the account page. \u2764",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
              maxLines: null,
            ),
          ),
          const SizedBox(height: 20),
          Container(
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
                height: MediaQuery.of(context).size.width * 1.5,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: Text(
                            'Product Review For You:',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // TODO animation repeats 3 times?
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 10,
                          right: 10,
                        ),
                        child: SingleChildScrollView( // Add SingleChildScrollView here
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  widget.answer,
                                  textStyle: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 1.5 * 0.025,
                                  ),
                                  textAlign: TextAlign.left,
                                  speed: const Duration(milliseconds: 5),
                                ),
                              ],
                              repeatForever: false,
                            ),
                            // child: Text(
                            //   widget.answer,
                            //   style: TextStyle(
                            //     fontSize:
                            //     MediaQuery.of(context).size.width * 1.5 * 0.025,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
