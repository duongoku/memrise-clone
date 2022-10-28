import 'package:demo/main.dart';
import 'package:demo/screens/getting_started_screen.dart';
import 'package:demo/screens/language_selection_screen.dart';
import 'package:demo/screens/learn_screen.dart';
import 'package:demo/screens/lesson_selection_screen.dart';
import 'package:demo/screens/new_phrase.dart';
import 'package:demo/screens/prefab.dart';
import 'package:demo/screens/register_screen.dart';
import 'package:demo/screens/sign_in_screen.dart';
import 'package:demo/screens/user_courses_screen.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_test/flutter_test.dart';

const phrasesCollection = 'phrases';

class TestApp {
  static void setTesterWindowSize(tester) {
    tester.binding.window.physicalSizeTestValue = const Size(1440, 2560);
  }

  static void runTests() {
    testWidgets('Initial test to ensure everything is normal', (tester) async {
      MyApp.firestore = FakeFirebaseFirestore();
      await MyApp.firestore.collection(phrasesCollection).add({
        'dstLang': 'en',
        'meaning': 'Chrome',
        'phrase': 'クロム',
        'srcLang': 'ja',
        'videoUrl':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
      });
      setTesterWindowSize(tester);
    });

    group('Getting started screen', () {
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: GettingStarted()),
      );

      testWidgets('Test get started button', (tester) async {
        await tester.pumpWidget(testWidget);
        Finder result = find.text('Get started');
        expect(result, findsOneWidget);
        await tester.tap(find.text('Get started'));
      });

      testWidgets('Test to login button', (tester) async {
        await tester.pumpWidget(testWidget);
        Finder result = find.text('I have an account');
        expect(result, findsOneWidget);
        await tester.tap(result);
      });
    });

    group('Language selection screen', () {
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: LanguageSelectionScreen()),
      );

      testWidgets('Language selection #1', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.tap(find.byType(TextButton).first);
      });

      testWidgets('Language selection #2', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.tap(find.byType(DropdownButtonHideUnderline).first);
      });
    });

    group('New phrase screen', () {
      Widget testWidget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: NewPhrase(
            phrase: Phrase(
              phrase: 'Hello',
              meaning: 'Привет',
              srcLang: 'English',
              dstLang: 'Russian',
              videoUrl:
                  'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
            ),
          ),
        ),
      );

      // Wait for video to load, but it doesn't work lmao
      // sleep(const Duration(seconds: 2));

      testWidgets('Test reply button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.tap(find.byType(ElevatedButton).first);
      });

      testWidgets('Test OK button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.tap(find.byType(CustomElevatedButton).last);
      });
    });

    group('Lesson selection screen', () {
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: LessonSelectionScreen()),
      );

      testWidgets('Test to user course button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.tap(find.byType(IconButton).first);
      });

      testWidgets('Test to learn screen buttons', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.tap(find.byType(TextButton).first);
      });
    });

    group('User courses screen', () {
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: UserCoursesScreen()),
      );

      testWidgets('Test back button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.tap(find.byType(IconButton).first);
      });
      testWidgets('Test learn a new course button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.tap(find.byType(ElevatedButton).first);
      });

      testWidgets('Test courses', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.tap(find.byType(InkWell).first);
      });
    });

    group('Register screen', () {
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
            home: RegisterScreen(
          isRegistering: true,
        )),
      );

      testWidgets('Test redirect button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.tap(find.byType(TextButton).first);
      });

    });

    group('Sign in selection screen', () {
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: SignInSelectionScreen()),
      );

      testWidgets('Test signin buttons', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.tap(find.byType(SignInButton).first);
      });
    });

    group('Learn screen', () {
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: LearnScreen()),
      );

      testWidgets('Test back button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.tap(find.byType(IconButton).first);
      });

      testWidgets('Test OK button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.tap(find.byType(CustomElevatedButton).first);
      });
    });
  }
  
}

void main() {
  TestApp.runTests();
}
