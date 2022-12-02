import 'dart:convert';

import 'package:demo/colors/custom_palette.dart';
import 'package:demo/screens/all_screens.dart';

import 'package:demo/constants.dart';
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
  final userId = supabase.auth.currentUser?.id;

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

  updateUserCourses(language) async {
    var user =
        await supabase.from("profiles").select().eq("id", userId).single();
    String currentCourse = user["courses"]["currentCourse"];
    List otherCourses = user["courses"]["otherCourses"];

    if (currentCourse != language && !otherCourses.contains(language)) {
      otherCourses.add(currentCourse);
      currentCourse = language;

      user["courses"]["currentCourse"] = currentCourse;
      user["courses"]["otherCourses"] = otherCourses;
      await supabase.from("profiles").upsert(user);
    }
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
                        if (supabase.auth.currentUser == null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(
                                isRegistering: true,
                              ),
                            ),
                          );
                        } else {
                          updateUserCourses(language);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LessonSelectionScreen()),
                          );
                        }
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
