import 'package:demo/screens/all_screens.dart';
import 'package:demo/constants.dart';

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
    testWidgets('Initial test to setup', (tester) async {
      await dotenv.load();
      WidgetsFlutterBinding.ensureInitialized();
      await Supabase.initialize(
        url: dotenv.env['SUPABASE_URL']!,
        anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
      );
      await supabase.auth.signInWithPassword(
        email: dotenv.env['TEST_EMAIL']!,
        password: dotenv.env['TEST_PASSWORD']!,
      );
      setTesterWindowSize(tester);
    });

    group('Getting started screen', () {
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: GettingStarted()),
      );

      testWidgets('Test get started button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        Finder result = find.text('Get started');
        expect(result, findsOneWidget);
        await tester.tap(result);
        await tester.pumpAndSettle();
      });

      testWidgets('Test to login button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        Finder result = find.text('I have an account');
        expect(result, findsOneWidget);
        await tester.tap(result);
        await tester.pumpAndSettle();
      });
    });

    group('Language selection screen', () {
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: LanguageSelectionScreen()),
      );

      testWidgets('Language selection #1', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(TextButton).first);
        await tester.pumpAndSettle();
      });

      testWidgets('Language selection #2', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(DropdownButtonHideUnderline).first);
        await tester.pumpAndSettle();
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

      testWidgets('Test replay button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ElevatedButton).first);
        await tester.pumpAndSettle();
      });

      testWidgets('Test OK button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(CustomElevatedButton).last);
        await tester.pumpAndSettle();
      });
    });

    group('Lesson selection screen', () {
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: LessonSelectionScreen()),
      );

      testWidgets('Test to user course button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(IconButton).first);
        await tester.pumpAndSettle();
      });

      testWidgets('Test to user profile button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(IconButton).last);
        await tester.pumpAndSettle();
      });

      testWidgets('Test to new phrase buttons #1', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(TextButton).first);
        await tester.pumpAndSettle();
      });

      testWidgets('Test to new phrase buttons #2', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(TextButton).last);
        await tester.pumpAndSettle();
      });

      testWidgets('Test to learn screen buttons', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(FloatingActionButton).first);
        await tester.pumpAndSettle();
      });
    });

    group('User courses screen', () {
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: UserCoursesScreen()),
      );

      testWidgets('Test back button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(IconButton).first);
      });
      testWidgets('Test learn a new course button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ElevatedButton).first);
      });

      testWidgets('Test courses', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
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
        await tester.pumpAndSettle();
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
        await tester.pumpAndSettle();
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
        await tester.pumpAndSettle();
        await tester.tap(find.byType(IconButton).first);
      });

      testWidgets('Test OK button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(CustomElevatedButton).first);
      });
    });
  }
}

void main() {
  TestApp.runTests();
}
