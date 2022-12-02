import 'dart:async';

import 'package:demo/colors/custom_palette.dart';
import 'package:demo/constants.dart';
import 'package:demo/screens/lesson_selection_screen.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget {
  final bool isRegistering;

  const RegisterScreen({super.key, required this.isRegistering});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const double containerWidth = 250;
  static const double logoWidth = 150;
  static const double buttonHeigth = 45;
  static const double textFieldHeigth = 50;

  late final StreamSubscription<AuthState> _authStateSubscription;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isLoading = false;
  bool _redirecting = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _authStateSubscription =
        supabase.auth.onAuthStateChange.listen((AuthState event) {
      if (_redirecting) return;

      final session = event.session;

      if (session != null) {
        _redirecting = true;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LessonSelectionScreen(),
          ),
          (route) => false,
        );
      }
    });

    super.initState();
  }

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  Future<void> _signInWithPassword(
      String email, String password, bool isSignUp) async {
    setState(() {
      _isLoading = true;
    });

    try {
      String successMessage = "Check your email for login link!";
      if (isSignUp) {
        await supabase.auth.signUp(email: email, password: password);
      } else {
        await supabase.auth
            .signInWithPassword(email: email, password: password);
        successMessage = "Logged in successfully!";
      }
      if (!mounted) return;
      context.showSnackBar(message: successMessage);
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: "Unexpected error: $error");
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomPalette.primaryColor,
      body: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/main_logo2.jpg',
                width: logoWidth,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40),
              width: containerWidth,
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: const Text(
                      'Email',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: textFieldHeigth,
                    child: TextField(
                      controller: _emailController,
                      style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: CustomPalette.textField,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 10, 0, 10),
                        hintText: 'example@gmail.com',
                        hintStyle: TextStyle(
                            fontSize: 15.0, color: Colors.blueGrey[100]),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                    child: const Text(
                      'Password',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: textFieldHeigth,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: CustomPalette.textField,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 10, 0, 10),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            fontSize: 15.0, color: Colors.blueGrey[100]),
                      ),
                    ),
                  ),
                  widget.isRegistering
                      ? Container(
                          padding: const EdgeInsets.only(top: 30),
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: (() {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const RegisterScreen(isRegistering: false);
                                },
                              ));
                            }),
                            child: const Text(
                              'Already have an account? Login now!',
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.only(top: 30),
                        ),
                ],
              ),
            ),
            SizedBox(
              width: containerWidth,
              child: SizedBox(
                width: containerWidth,
                height: buttonHeigth,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomPalette.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: () async {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    _signInWithPassword(email, password, widget.isRegistering);
                  },
                  child: Text(
                    _isLoading
                        ? 'Loading...'
                        : widget.isRegistering
                            ? 'Register'
                            : 'Login',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
