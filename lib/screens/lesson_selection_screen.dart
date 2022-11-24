import 'package:demo/colors/custom_palette.dart';
import 'package:demo/constants.dart';
import 'package:demo/screens/new_phrase.dart';
import 'package:demo/screens/user_courses_screen.dart';
import 'package:demo/screens/word_list_screen.dart';

import 'package:flutter/material.dart';

class LessonSelectionScreen extends StatefulWidget {
  const LessonSelectionScreen({super.key});

  @override
  State<LessonSelectionScreen> createState() => _LessonSelectionScreenState();
}

class _LessonSelectionScreenState extends State<LessonSelectionScreen> {
  static const learnButtonHeight = 65.0;
  static const learnButtonWidth = 165.0;

  var memriseIcon = Image.asset(
    "assets/images/round_logo.png",
    width: 75,
    height: 75,
  );

  var threeVerticalDots = Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: const [
      SizedBox(height: 10),
      Icon(Icons.circle, color: Colors.white, size: 10),
      SizedBox(height: 5),
      Icon(Icons.circle, color: Colors.white, size: 10),
      SizedBox(height: 5),
      Icon(Icons.circle, color: Colors.white, size: 10),
      SizedBox(height: 10),
    ],
  );

  Future<void> toLearnScreen() async {
    //TODO: Change route to learnscreen
    supabase.from("phrases").select("*").then((rows) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewPhrase(words: rows, currentWordIndex: 0),
        ),
      );
    });
  }

  Future<void> toWordListScreen(int lessonId) async {
    supabase.from("phrases").select("*").eq("lesson", lessonId).then((rows) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WordListScreen(
            words: rows,
            lesson: "Lesson 1", //TODO: dynamic lesson
          ),
        ),
      );
    });
  }

  List<Widget> getLessonsFromSnapshot(AsyncSnapshot snapshot) {
    List<Widget> lessons = [];
    int count = 0;
    for (var lesson in snapshot.data) {
      count++;
      lessons.add(memriseIcon);
      lessons.add(TextButton(
        onPressed: () => toWordListScreen(lesson["id"]),
        child: Text(
          "$count - ${lesson['type']}",
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ));
      lessons.add(TextButton(
        onPressed: () => toWordListScreen(lesson["id"]),
        child: Text(
          lesson["name"],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
      lessons.add(threeVerticalDots);
    }
    if (lessons.isNotEmpty) {
      lessons.removeLast();
    }
    return lessons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserCoursesScreen(),
                ),
              );
            },
          )
        ],
        backgroundColor: CustomPalette.lighterPrimaryColor,
        title: const Text("Lesson Selection"),
      ),
      backgroundColor: CustomPalette.primaryColor,
      body: FutureBuilder(
        future: supabase.from("lessons").select("*"),
        builder: (context, snapshot) {
          return ListView(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: learnButtonHeight + 20,
            ),
            children: getLessonsFromSnapshot(snapshot),
          );
        },
      ),
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
    );
  }
}
