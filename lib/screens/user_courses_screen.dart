import 'package:demo/colors/custom_palette.dart';
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
                  Navigator.of(context).pushNamed('/LanguageSelection/');
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
      body: ListView(
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
              Navigator.of(context).pushNamedAndRemoveUntil(
                      '/LessonSelection/', (route) => false);
            },
            child: Row(
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(30), // Image radius
                    child: Image.asset(
                      "assets/images/japan_course_icon.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Japanese',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'OTHER COURSES',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                      '/LessonSelection/', (route) => false);
            },
            child: Row(
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(30), // Image radius
                    child: Image.asset(
                      "assets/images/spain_course_icon.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Spanish',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 1,
            color: Colors.blueGrey,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                      '/LessonSelection/', (route) => false);
            },
            child: Row(
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(30), // Image radius
                    child: Image.asset(
                      "assets/images/germany_course_icon.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'German',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
