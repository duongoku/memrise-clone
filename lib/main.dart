import 'package:demo/screens/getting_started_screen.dart';
import 'package:demo/screens/language_selection_screen.dart';
import 'package:demo/screens/learn_screen.dart';
import 'package:demo/screens/lesson_selection_screen.dart';
import 'package:demo/screens/register_screen.dart';
import 'package:demo/screens/sign_in_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // This need to be awaited but I'm too lazy to do it
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    const appTitle = 'Memrise';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: const GettingStarted(),
      routes: {
        '/GettingStarted/': (context) => const GettingStarted(),
        '/LanguageSelection/': (context) => const LanguageSelectionScreen(),
        '/LessonSelection/': (context) => const LessonSelectionScreen(),
        '/LearnScreen/': (context) => const LearnScreen(),
        '/RegisterScreen/': (context) => const RegisterScreen(isRegistering: true),
        '/SignInScreen/': (context) => const RegisterScreen(isRegistering: false),
        '/SignInSelectionScreen/': (context) => const SignInSelectionScreen()
      },
    );
  }
}
