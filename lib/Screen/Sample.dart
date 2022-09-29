import 'package:flutter/material.dart';

class Sample extends StatelessWidget {
  const Sample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/GettingStarted/', (route) => false),
        ),
        title: Text("Sample"),
        centerTitle: true,
      ),
      body: const Center(child: Text('hello')),
    );
  }
}
