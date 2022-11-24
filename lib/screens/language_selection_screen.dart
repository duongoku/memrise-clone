import 'dart:convert';
import 'package:demo/screens/register_screen.dart';

import 'lesson_selection_screen.dart';
import 'package:demo/colors/custom_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<List> loadLanguages() async {
  final String jsonString =
      await rootBundle.loadString("assets/data/languages.json");
  return json.decode(jsonString);
}

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  static var languages = <String>["English"];

  String selectedLanguage = "English";

  TextStyle whiteText = const TextStyle(color: Colors.white, fontSize: 20);
  TextStyle blackText =
      const TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 20);

  @override
  void initState() {
    super.initState();
    loadLanguages().then((value) {
      setState(() {
        languages = List<String>.from(value);
        selectedLanguage = languages[0];
      });
    });
  }

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
                    value: selectedLanguage,
                  ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(
                              isRegistering: true,
                            ),
                          ),
                        );
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
