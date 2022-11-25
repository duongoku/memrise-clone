import 'package:demo/colors/custom_palette.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.style,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final VoidCallback onPressed;
  final ButtonStyle style;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: text,
    );
  }
}

abstract class Prefab {
  static final okButtonStyle = ButtonStyle(
    backgroundColor:
        MaterialStateProperty.all<Color>(CustomPalette.dimmedSecondaryColor),
  );
  static const okButtonText = Text(
    "Ok, got it",
    style: TextStyle(
        color: CustomPalette.primaryColor,
        fontWeight: FontWeight.w900,
        fontSize: 26),
  );
  static const phraseStyle = TextStyle(color: Colors.white, fontSize: 24);
  static const srcStyle = TextStyle(color: Colors.grey, fontSize: 12);
  static const vPadding5 = SizedBox(height: 5);
  static const vPadding10 = SizedBox(height: 10);
  static const vPadding15 = SizedBox(height: 15);
  static const vPadding20 = SizedBox(height: 20);
  static const vPadding25 = SizedBox(height: 25);
  static const vPadding35 = SizedBox(height: 35);
  static const vPadding50 = SizedBox(height: 50);
  static const vPadding75 = SizedBox(height: 75);
  static const vPadding100 = SizedBox(height: 100);
  static const vPadding125 = SizedBox(height: 125);
  static const vPadding150 = SizedBox(height: 150);
  static const vPadding175 = SizedBox(height: 175);
  static const vPadding200 = SizedBox(height: 200);
  static const hPadding5 = SizedBox(width: 5);
  static const hPadding10 = SizedBox(width: 10);
  static const hPadding15 = SizedBox(width: 15);
  static const hPadding20 = SizedBox(width: 20);
  static const hPadding25 = SizedBox(width: 25);
  static const hPadding30 = SizedBox(width: 30);
  static const hPadding35 = SizedBox(width: 35);
}
