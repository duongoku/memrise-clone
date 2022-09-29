import 'package:demo/Screen/GettingStartedScreen.dart';
import 'package:demo/Screen/LearnScreen.dart';
import 'package:flutter/material.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    
    const appTitle = 'Memrise';
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: GettingStarted(), 
      routes: {
        '/GettingStarted/': (context) => const GettingStarted(),
        '/Sample/': (context) => const LearnScreen()
      },
    );
  }
}

