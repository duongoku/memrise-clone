import "package:demo/colors/custom_palette.dart";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_signin_button/flutter_signin_button.dart";
import "package:google_sign_in/google_sign_in.dart";
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  static const double logoHeight = 125;
  static const double logoMarginBottom = 200;
  static const double logoMarginTop = 50;
  static const double signInButtonHeight = 60;
  static const double signInButtonWidth = 300;
  static const double spaceBetweenButtons = 20;

  void signInWithFacebook() {}
  Future<void> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: "YOUR_CLIENT_ID",
      scopes: [
        "email",
        "https://www.googleapis.com/auth/userinfo.profile",
      ],
    );
    try {
      await googleSignIn.signIn();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future<void> signInWithEmail(emailAddress, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      if (kDebugMode) {
        print(credential);
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
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
                onPressed: () => {
                  signInWithEmail("123@gmail.com ", "1234567"),
                },
              ),
            )),
      ]),
    );
  }
}
