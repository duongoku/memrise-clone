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
                    "https://duongoku.github.io/archive/2022/MemriseClone/videos/salut.mp4",
                "phrase": "salut",
                "meaning": "hello",
                "srcLang": "fr",
                "dstLang": "en",
                "lesson": 1,
              },
              {
                "id": 2,
                "videoUrl":
                    "https://duongoku.github.io/archive/2022/MemriseClone/videos/cava.mp4",
                "phrase": "cava",
                "meaning": "how are you?",
                "srcLang": "fr",
                "dstLang": "en",
                "lesson": 1,
              },
              {
                "id": 3,
                "videoUrl":
                    "https://duongoku.github.io/archive/2022/MemriseClone/videos/cava.mp4",
                "phrase": "cava1",
                "meaning": "how are you bro?",
                "srcLang": "fr",
                "dstLang": "en",
                "lesson": 1,
              },
              {
                "id": 4,
                "videoUrl":
                    "https://duongoku.github.io/archive/2022/MemriseClone/videos/cava.mp4",
                "phrase": "cava2",
                "meaning": "how are you bruh?",
                "srcLang": "fr",
                "dstLang": "en",
                "lesson": 1,
              },
              {
                "id": 5,
                "videoUrl":
                    "https://duongoku.github.io/archive/2022/MemriseClone/videos/cava.mp4",
                "phrase": "cava3",
                "meaning": "sup",
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

      testWidgets('Test swipe left', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.drag(find.byType(PageView), const Offset(-500, 0));
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

      testWidgets('Test to new phrase button #1', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(TextButton).first);
        await tester.pumpAndSettle();
      });

      testWidgets('Test to new phrase button #2', (tester) async {
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
        await tester.pumpAndSettle();
      });
      testWidgets('Test learn a new course button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ElevatedButton).first);
        await tester.pumpAndSettle();
      });

      testWidgets('Test courses', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(InkWell).first);
        await tester.pumpAndSettle();
      });
    });

    group('Learn screen', () {
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: LearnScreen(
            words: [
              {
                "id": 1,
                "videoUrl":
                    "https://duongoku.github.io/archive/2022/MemriseClone/videos/salut.mp4",
                "phrase": "salut",
                "meaning": "hello",
                "srcLang": "fr",
                "dstLang": "en",
                "lesson": 1,
              },
              {
                "id": 2,
                "videoUrl":
                    "https://duongoku.github.io/archive/2022/MemriseClone/videos/cava.mp4",
                "phrase": "cava",
                "meaning": "how are you?",
                "srcLang": "fr",
                "dstLang": "en",
                "lesson": 1,
              },
              {
                "id": 3,
                "videoUrl":
                    "https://duongoku.github.io/archive/2022/MemriseClone/videos/cava.mp4",
                "phrase": "cava1",
                "meaning": "how are you bro?",
                "srcLang": "fr",
                "dstLang": "en",
                "lesson": 1,
              },
              {
                "id": 4,
                "videoUrl":
                    "https://duongoku.github.io/archive/2022/MemriseClone/videos/cava.mp4",
                "phrase": "cava2",
                "meaning": "how are you bruh?",
                "srcLang": "fr",
                "dstLang": "en",
                "lesson": 1,
              },
            ],
          ),
        ),
      );

      testWidgets('Test exit button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(IconButton).first);
        await tester.pumpAndSettle();
        await tester.tap(find.text("CANCEL").first);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(IconButton).first);
        await tester.pumpAndSettle();
        await tester.tap(find.text("YES").first);
        await tester.pumpAndSettle();
      });

      testWidgets('Test OK button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        for (var i = 0; i < 4; i++) {
          await tester.drag(find.byType(ListView), const Offset(0.0, -300.0));
          await tester.pumpAndSettle();
          await tester.tap(find.text("Ok, got it").first);
          await tester.pumpAndSettle();
        }
        await tester.tap(find.byType(ElevatedButton).first);
        await tester.pumpAndSettle();
        await tester.drag(find.byType(ListView), const Offset(0.0, -300.0));
        await tester.pumpAndSettle();
        await tester.tap(find.text("GO BACK").first);
        await tester.pumpAndSettle();
      });
    });

    group('Word list screen', () {
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: WordListScreen(
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
            lesson: "Mock lesson",
            lessonId: 1,
          ),
        ),
      );

      testWidgets('Test word card', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(Card).first);
        await tester.pumpAndSettle();
      });

      testWidgets('Test learn button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("Learn").first);
        await tester.pumpAndSettle();
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
        await tester.pumpAndSettle();
      });

      testWidgets('Test register button', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();
        var result = find.text('Register');
        expect(result, findsOneWidget);
        await tester.tap(result);
        await tester.pumpAndSettle();
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
  }
}

void main() {
  TestApp.runTests();
}
