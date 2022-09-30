import 'package:demo/Screen/GettingStartedScreen.dart';
import 'package:demo/Screen/LanguageSelectionScreen.dart';
import 'package:demo/Screen/LearnScreen.dart';
import 'package:demo/Screen/LessonSelectionScreen.dart';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Memrise';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: const GettingStarted(),
      routes: {
        '/GettingStarted/': (context) => const GettingStarted(),
        '/LanguageSelection/': (context) => const LanguageSelectionScreen(),
        '/LessonSelection/': (context) => const LessonSelectionScreen(),
        '/LearnScreen/': (context) => const LearnScreen()
      },
    );
  }
}
