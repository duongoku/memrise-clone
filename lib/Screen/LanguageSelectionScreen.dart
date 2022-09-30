import 'package:demo/Colors/CustomPalette.dart';

import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  static const languages = [
    "English",
    "Spanish",
    "French",
    "German",
    "Italian",
    "Portuguese",
    "Russian",
    "Turkish",
    "Chinese",
    "Japanese",
    "Korean",
    "Arabic",
    "Hindi",
    "Indonesian",
    "Thai",
    "Vietnamese",
    "Dutch",
    "Polish",
    "Swedish",
    "Danish",
    "Norwegian",
  ];

  String selectedLanguage = languages[0];

  TextStyle whiteText = const TextStyle(color: Colors.white, fontSize: 20);
  TextStyle blackText =
      const TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomPalette.primaryColor,
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              child: Center(
                child: Text(
                  "I speak",
                  style: whiteText,
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: CustomPalette.secondaryColor,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      isExpanded: true,
                      alignment: AlignmentDirectional.center,
                      iconSize: 0.0,
                      dropdownColor: CustomPalette.secondaryColor,
                      items: languages.map((String language) {
                        return DropdownMenuItem(
                          value: language,
                          child: Center(
                            child: Text(
                              language,
                              style: blackText,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedLanguage = value!;
                        });
                      },
                      value: selectedLanguage),
                ),
              ),
            ),
          ],
        ),
        Text(
          "I want to learn",
          style: whiteText,
        ),
        SizedBox(
          height: 500.0,
          width: 300.0,
          child: DecoratedBox(
            decoration: const BoxDecoration(
                color: CustomPalette.lighterPrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: ListView(
              children: languages.map((String language) {
                return ListTile(
                  title: Center(
                    child: TextButton(
                      child: Text(language, style: whiteText),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/LessonSelection/', (route) => false);
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ]),
    );
  }
}