import 'package:demo/Colors/CustomPalette.dart';
import 'package:flame/experimental.dart';

import 'package:flutter/material.dart';

class LessonSelectionScreen extends StatefulWidget {
  const LessonSelectionScreen({super.key});

  @override
  State<LessonSelectionScreen> createState() => _LessonSelectionScreenState();
}

class _LessonSelectionScreenState extends State<LessonSelectionScreen> {
  var memriseIcon = Image.asset(
    "assets/images/round_logo.png",
    width: 75,
  );

  var threeVerticalDots = Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
        Icon(Icons.circle, color: Colors.white, size: 10),
        Icon(Icons.circle, color: Colors.white, size: 10),
        Icon(Icons.circle, color: Colors.white, size: 10),
      ]));

  toLearnScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil('/Sample/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomPalette.lighterPrimaryColor,
        title: const Text("Lesson Selection"),
      ),
      backgroundColor: CustomPalette.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Column(children: [
            memriseIcon,
            TextButton(
              onPressed: toLearnScreen,
              child: const Text(
                "1 - Words and Phrases",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: toLearnScreen,
              child: const Text(
                "The basics 1",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ])),
          threeVerticalDots,
          Expanded(
              child: Column(children: [
            memriseIcon,
            TextButton(
              onPressed: toLearnScreen,
              child: const Text(
                "2 - Grammar",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: toLearnScreen,
              child: const Text(
                "How to sound polite",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ])),
          threeVerticalDots,
          Expanded(
              child: Column(children: [
            memriseIcon,
            TextButton(
              onPressed: toLearnScreen,
              child: const Text(
                "3 - Words and Phrases",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: toLearnScreen,
              child: const Text(
                "The basics 2",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ])),
        ],
      ),
    );
  }
}
