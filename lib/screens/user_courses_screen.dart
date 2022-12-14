import 'package:demo/colors/custom_palette.dart';
import 'package:demo/constants.dart';
import 'package:demo/screens/all_screens.dart';

import 'package:flutter/material.dart';

class UserCoursesScreen extends StatefulWidget {
  const UserCoursesScreen({super.key});

  @override
  State<UserCoursesScreen> createState() => _UserCoursesScreenState();
}

class _UserCoursesScreenState extends State<UserCoursesScreen> {
  double iconSize = 50;
  var userId =
      supabase.auth.currentUser?.id ?? "7b0dc386-e979-49d3-950d-13af79f3389d";
  dynamic data;

  updateUserCourses(language, user) async {
    String currentCourse = user["courses"]["currentCourse"];
    List otherCourses = user["courses"]["otherCourses"];

    
      otherCourses.add(currentCourse);
      otherCourses.remove(language);
      currentCourse = language;

      user["courses"]["currentCourse"] = currentCourse;
      user["courses"]["otherCourses"] = otherCourses;
      await supabase.from("profiles").upsert(user);
    
  }

  List<Widget> getCoursesFromData(otherCourses, userData) {
    List<Widget> courses = [];

    for (String course in otherCourses) {
      courses.add(Prefab.vPadding20);
      courses.add(
        InkWell(
          onTap: () {
            updateUserCourses(course, userData);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LessonSelectionScreen(),
              ),
            );
          },
          child: Row(
            children: [
              ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(30), // Image radius
                  child: Image.asset(
                    "assets/images/${course}_course_icon.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                course,
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ],
          ),
        ),
      );
      courses.add(Prefab.vPadding10);
      courses.add(const Divider(
        thickness: 1,
        color: Colors.blueGrey,
      ));
    }
    if (courses.isNotEmpty) {
      courses.removeLast();
    }
    return courses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomPalette.primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
      body: FutureBuilder(
          future: supabase.from("profiles").select().eq("id", userId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            } else {
              data = snapshot.data[0]["courses"];
              if (data == null) {
                return const Center(
                  child: Text(
                    "You have not enrolled in any courses yet",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
              }
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
                          builder: (context) => const LessonSelectionScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(30), // Image radius
                            child: Image.asset(
                              "assets/images/${data["currentCourse"]}_course_icon.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${data["currentCourse"]}',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  if (data["otherCourses"].length != 0) ...[
                    const Text(
                      'OTHER COURSES',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    ...getCoursesFromData(
                        data["otherCourses"], snapshot.data[0])
                  ],
                ],
              );
            }
          }),
    );
  }
}
