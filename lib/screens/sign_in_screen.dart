import 'dart:async';

import 'package:demo/colors/custom_palette.dart';
import 'package:demo/screens/register_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignInSelectionScreen extends StatefulWidget {
  const SignInSelectionScreen({super.key});

  @override
  State<SignInSelectionScreen> createState() => _SignInSelectionScreenState();
}

class _SignInSelectionScreenState extends State<SignInSelectionScreen> {
  static const double logoHeight = 125;
  static const double logoMarginBottom = 200;
  static const double logoMarginTop = 50;
  static const double signInButtonHeight = 60;
  static const double signInButtonWidth = 300;
  static const double spaceBetweenButtons = 20;

  Future<void> signInWithFacebook() async {}
  Future<void> signInWithGoogle() async {}
  Future<void> navigateToSignInScreen() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(isRegistering: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomPalette.primaryColor,
      body: ListView(children: [
        const SizedBox(
          height: logoMarginTop,
        ),
        Image.asset(
          "assets/images/main_logo.png",
          height: logoHeight,
        ),
        const SizedBox(
          height: logoMarginBottom,
        ),
        Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: signInButtonHeight,
              width: signInButtonWidth,
              child: SignInButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                Buttons.Facebook,
                onPressed: signInWithFacebook,
              ),
            )),
        const SizedBox(
          height: spaceBetweenButtons,
        ),
        Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: signInButtonHeight,
              width: signInButtonWidth,
              child: SignInButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                Buttons.Google,
                onPressed: signInWithGoogle,
              ),
            )),
        const SizedBox(
          height: spaceBetweenButtons,
        ),
        Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: signInButtonHeight,
              width: signInButtonWidth,
              child: SignInButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                Buttons.Email,
                onPressed: navigateToSignInScreen,
              ),
            )),
      ]),
    );
  }
}
