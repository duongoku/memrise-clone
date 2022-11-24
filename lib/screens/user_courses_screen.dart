import 'package:demo/colors/custom_palette.dart';
import 'package:demo/constants.dart';
import 'package:demo/main.dart';
import 'package:demo/screens/language_selection_screen.dart';
import 'package:demo/screens/lesson_selection_screen.dart';

import 'package:flutter/material.dart';

class UserCoursesScreen extends StatefulWidget {
  const UserCoursesScreen({super.key});

  @override
  State<UserCoursesScreen> createState() => _UserCoursesScreenState();
}

class _UserCoursesScreenState extends State<UserCoursesScreen> {
  double iconSize = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CustomPalette.iconColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        leadingWidth: 25,
        backgroundColor: CustomPalette.lighterPrimaryColor,
        title: const Text("Courses"),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 40),
            child: SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomPalette.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LanguageSelectionScreen()),
                  );
                },
                child: const Text(
                  'Learn a new course',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: CustomPalette.primaryColor,
      body: FutureBuilder(
          future: supabase.from('profiles').select('*').execute(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: Text(
                'Please wait its loading...',
                style: TextStyle(color: Colors.white),
              ));
            } else {
              return ListView(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                children: [
                  const Text(
                    'SELECTED COURSE',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const LessonSelectionScreen()),
                      );
                    },
                    child: Row(
                      children: [
                        ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(30), // Image radius
                            child: Image.asset(
                              "assets/images/${snapshot.data["currentCourse"]}_course_icon.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${snapshot.data["currentCourse"]}',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  if (snapshot.data["otherCourses"].length != 0) ...[
                    const Text(
                      'OTHER COURSES',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    for (var i in snapshot.data["otherCourses"]) ...[
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LessonSelectionScreen()), //todo
                          );
                        },
                        child: Row(
                          children: [
                            ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(30), // Image radius
                                child: Image.asset(
                                  "assets/images/${i}_course_icon.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '$i',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (i != snapshot.data["otherCourses"].last) ...[
                        const Divider(
                          thickness: 1,
                          color: Colors.blueGrey,
                        ),
                      ]
                    ]
                  ],
                ],
              );
            }
          }),
    );
  }
}
