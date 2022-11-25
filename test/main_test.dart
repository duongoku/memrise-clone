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

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const phrasesCollection = 'phrases';

class TestApp {
  static void setTesterWindowSize(tester) {
    tester.binding.window.physicalSizeTestValue = const Size(1440, 2560);
  }

  static void runTests() {
    testWidgets('Initial test to ensure everything is normal', (tester) async {
      await dotenv.load();
      WidgetsFlutterBinding.ensureInitialized();
      await Supabase.initialize(
        url: dotenv.env['SUPABASE_URL']!,
        anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
      );
      await Supabase.instance.client.auth
          .signInWithPassword(email: "19020060@vnu.edu.vn", password: "123456");
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
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: NewPhrase(
            words: [
              {
                "id": 1,
                "videoUrl":
                    "https://duongoku.github.io/archive/2022/MemriseClone/videos/cava.mp4",
                "phrase": "cava",
                "meaning": "cava",
                "srcLang": "fr",
                "dstLang": "en",
                "lesson": 1,
              }
            ],
            currentWordIndex: 0,
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
