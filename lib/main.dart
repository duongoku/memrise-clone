import 'package:demo/screens/all_screens.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Memrise';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Supabase.instance.client.auth.currentUser != null
          ? const UserCoursesScreen()
          : const GettingStarted(),
      routes: {
        '/GettingStarted/': (context) => const GettingStarted(),
        '/LanguageSelection/': (context) => const LanguageSelectionScreen(),
        '/LessonSelection/': (context) => const LessonSelectionScreen(),
        '/RegisterScreen/': (context) => const RegisterScreen(
              isRegistering: true,
            ),
        '/SignInScreen/': (context) => const RegisterScreen(
              isRegistering: false,
            ),
        '/SignInSelectionScreen/': (context) => const SignInSelectionScreen(),
        '/UserCoursesScreen/': (context) => const UserCoursesScreen(),
      },
    );
  }
}

void startApp() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

String checkDotEnv(List<String> keys) {
  for (final key in keys) {
    if (dotenv.env[key] == null) {
      return "Missing $key in .env file";
    }
  }
  return "";
}

Future main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();

  // Make sure all environment variables are set
  List<String> requiredEnv = ["SUPABASE_URL", "SUPABASE_ANON_KEY"];
  String checkResult = checkDotEnv(requiredEnv);
  if (checkResult.startsWith("Missing")) {
    if (kDebugMode) {
      print(checkResult);
    }
    return;
  }

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  startApp();
}
