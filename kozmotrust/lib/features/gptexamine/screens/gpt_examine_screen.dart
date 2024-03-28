import 'package:kozmotrust/features/gptexamine/widgets/list_find_from_favorites.dart';
import 'package:kozmotrust/features/home/widgets/healthinfo_box.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:flutter/material.dart';

class GPTExamineScreen extends StatefulWidget {
  const GPTExamineScreen({super.key});

  @override
  State<GPTExamineScreen> createState() {
    return _GPTExamineScreenState();
  }
}

class _GPTExamineScreenState extends State<GPTExamineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: GlobalVariables.selectedTopBarColor,
          elevation: 0,
          centerTitle: true,
          title: Image.asset('assets/images/logo.png'),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children:[
            const HealthInformationBox(),
            const ListAndFindFavorites(),
          ]
        ),
      )
    );
  }
}
