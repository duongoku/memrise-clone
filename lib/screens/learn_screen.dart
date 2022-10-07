import 'package:demo/colors/custom_palette.dart';
import 'package:flutter/material.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  static const double containerWidth = 250;
  static const double buttonWidth = 325;
  static const double buttonHeigth = 45;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomPalette.primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CustomPalette.iconColor),
          onPressed: () => Navigator.of(context)
              .pushNamedAndRemoveUntil('/LessonSelection/', (route) => false),
        ),
        backgroundColor: CustomPalette.lighterPrimaryColor,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            alignment: Alignment.center,
            child: const Text(
              '0',
              style: TextStyle(fontSize: 20, color: CustomPalette.iconColor),
            ),
          ),
        ],
      ),
      body: ListView(children: [
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/ku.gif',
              width: containerWidth,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15),
            alignment: Alignment.center,
            child: const Text(
              'く',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 35),
            alignment: Alignment.center,
            child: const Text(
              'ENGLISH(US)',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 15),
              alignment: Alignment.center,
              child: const Text(
                '\'ku\'',
                style: TextStyle(color: Colors.white, fontSize: 24),
              )),
          Container(
            padding: const EdgeInsets.only(top: 200),
            child: SizedBox(
              width: buttonWidth,
              height: buttonHeigth,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomPalette.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Ok, got it',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}
