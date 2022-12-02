import 'package:demo/colors/custom_palette.dart';
import 'package:demo/constants.dart';
import 'package:demo/screens/learn_screen.dart';
import 'package:demo/screens/new_phrase.dart';

import 'package:flutter/material.dart';

class WordListScreen extends StatefulWidget {
  final dynamic words;
  final String lesson;
  final int lessonId;

  const WordListScreen({
    super.key,
    required this.words,
    required this.lesson,
    required this.lessonId,
  });

  @override
  State<WordListScreen> createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
  static const learnButtonHeight = 65.0;
  static const learnButtonWidth = 165.0;

  Future<void> toLearnScreen() async {
    supabase
        .from("phrases")
        .select("*")
        .eq("lesson", widget.lessonId)
        .order("order", ascending: true)
        .then((rows) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LearnScreen(words: rows),
        ),
      );
    });
  }

  Future<void> toNewPhraseScreen(dynamic words, int index) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewPhrase(
          words: words,
          currentWordIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomPalette.lighterPrimaryColor,
        title: Text(widget.lesson),
      ),
      backgroundColor: CustomPalette.primaryColor,
      floatingActionButton: SizedBox(
        width: learnButtonWidth,
        height: learnButtonHeight,
        child: FloatingActionButton.extended(
          onPressed: toLearnScreen,
          label: const Text(
            "Learn",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: const Icon(Icons.draw, size: 28),
          backgroundColor: CustomPalette.dimmedSecondaryColor,
        ),
      ),
      body: ListView(
        children: [
          for (var i = 0; i < widget.words.length; i++)
            Card(
              color: CustomPalette.primaryColor,
              child: ListTile(
                leading: Image.asset("assets/images/new_phrase.png"),
                onTap: () {
                  toNewPhraseScreen(widget.words, i);
                },
                title: Text(
                  widget.words[i]["phrase"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  widget.words[i]["meaning"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
