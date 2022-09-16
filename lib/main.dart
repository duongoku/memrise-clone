import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with TapDetector {
  TextComponent text = TextComponent();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    text
      ..text = "Hello World\nWe're group 2 (Dương and Dũng)\nThis app is built with Flame"
      ..y = 50
      ..x = 50
      ..scale = Vector2(0.75, 0.75);

    add(text);
  }
}
