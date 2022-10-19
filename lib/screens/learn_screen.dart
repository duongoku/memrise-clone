import 'package:demo/colors/custom_palette.dart';
import 'package:demo/screens/language_selection_screen.dart';
import 'package:demo/screens/prefab.dart';
import 'package:flutter/material.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  static const double containerWidth = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomPalette.primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CustomPalette.iconColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LanguageSelectionScreen(),
              ),
            );
          },
        ),
        backgroundColor: CustomPalette.lighterPrimaryColor,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            alignment: Alignment.center,
            child: const Text(
              '0', // TODO: dynamic score
              style: TextStyle(fontSize: 20, color: CustomPalette.iconColor),
            ),
          ),
        ],
      ),
      body: ListView(children: [
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Prefab.vPadding10,
          Image.asset('assets/images/ku.gif', width: containerWidth),
          Prefab.vPadding15,
          const Text('く', style: Prefab.phraseStyle),
          Prefab.vPadding35,
          const Text('ENGLISH(US)', style: Prefab.srcStyle),
          Prefab.vPadding15,
          const Text('\'ku\'', style: Prefab.phraseStyle),
          Prefab.vPadding150,
          Center(
            child: SizedBox(
              height: 50,
              width: 350,
              child: CustomElevatedButton(
                onPressed: () {}, // TODO: implement
                text: Prefab.okButtonText,
                style: Prefab.okButtonStyle,
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}
