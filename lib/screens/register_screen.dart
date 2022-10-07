import 'package:demo/colors/custom_palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

import '../firebase_options.dart';

class RegisterScreen extends StatefulWidget {
  final bool isRegistering;

  const RegisterScreen({super.key, required this.isRegistering});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController? _email;
  TextEditingController? _password;

  static const double containerWidth = 250;
  static const double logoWidth = 150;
  static const double buttonHeigth = 45;
  static const double textFieldHeigth = 50;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email?.dispose();
    _password?.dispose();
    super.dispose();
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
                      controller: _email,
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
                        contentPadding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
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
                      controller: _password,
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
                        contentPadding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
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
                              if (kDebugMode) {
                                print('redirect to login');
                              }
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
            FutureBuilder(
              future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
              ),
              builder: (context, snapshot) {
                return SizedBox(
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
                        final email = _email!.text;
                        final password = _password!.text;

                        if (widget.isRegistering) {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password);
                        } else {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email, password: password);
                        }
                        // redirect to login code here
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     '/LoginScreen/', (route) => false);
                      },
                      child: Text(
                        widget.isRegistering ? 'Register' : 'Login',
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ]),
    );
  }
}
