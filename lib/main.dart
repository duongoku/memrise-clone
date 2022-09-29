import 'package:demo/Screen/GettingStartedScreen.dart';
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
     
      home: GettingStarted(), 
    );
  }
}

