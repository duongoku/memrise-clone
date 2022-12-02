import 'package:demo/colors/custom_palette.dart';
import 'package:demo/constants.dart';
import 'package:demo/screens/learn_screen.dart';
import 'package:demo/screens/user_courses_screen.dart';
import 'package:demo/screens/user_profile_screen.dart';
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
    // TODO: Select from phrases where lesson = lessonId
    supabase.from("phrases").select("*").then((rows) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LearnScreen(words: rows),
        ),
      );
    });
  }

  Future<void> toWordListScreen(int lessonId, String lesson) async {
    supabase.from("phrases").select("*").eq("lesson", lessonId).then((rows) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WordListScreen(
            words: rows,
            lesson: lesson,
          ),
        ),
      );
    });
  }

  List<Widget> getLessonsFromSnapshot(AsyncSnapshot snapshot) {
    List<Widget> lessons = [];
    if (snapshot.connectionState != ConnectionState.done) {
      return lessons;
    }
    for (var lesson in snapshot.data) {
      lessons.add(memriseIcon);
      lessons.add(TextButton(
        onPressed: () => toWordListScreen(lesson["id"], lesson["name"]),
        child: Text(
          "${lesson["order"]} - ${lesson["type"]}",
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ));
      lessons.add(TextButton(
        onPressed: () => toWordListScreen(lesson["id"], lesson["name"]),
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
        leading: IconButton(
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
          ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfileScreen(),
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
        future: supabase
            .from("lessons")
            .select("*")
            .order("order", ascending: true),
        builder: (context, snapshot) {
          var lessons = getLessonsFromSnapshot(snapshot);
          if (lessons.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(
                top: 20,
                bottom: learnButtonHeight + 20,
              ),
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            return ListView(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: learnButtonHeight + 20,
              ),
              children: lessons,
            );
          }
        },
      ),
      floatingActionButton: SizedBox(
        width: learnButtonWidth,
        height: learnButtonHeight,
        child: FloatingActionButton.extended(
          onPressed: () => toLearnScreen(),
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
