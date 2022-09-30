import 'package:demo/colors/custom_palette.dart';
import 'package:flutter/material.dart';

class GettingStarted extends StatelessWidget {
  const GettingStarted({super.key});
  static const double containerWidth = 250;
  static const double buttonHeigth = 45;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomPalette.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/main_logo2.jpg',
                  width: containerWidth,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(top: 40),
                width: containerWidth,
                child: const Text(
                  'Learn a language. Meet the word.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 100, 0, 30),
                width: containerWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: containerWidth,
                      height: buttonHeigth,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomPalette.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/LanguageSelection/', (route) => false);
                        },
                        child: const Text(
                          'Get started',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: containerWidth,
                      height: buttonHeigth,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomPalette.lighterPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          debugPrint('Received click');
                        },
                        child: const Text(
                          'I have an account',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
