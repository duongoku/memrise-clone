import 'package:demo/main.dart';
import 'package:demo/screens/getting_started_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test getting started screen #1', (tester) async {
    startApp();
    Widget testWidget = const MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(home: GettingStarted()),
    );
    tester.binding.window.physicalSizeTestValue = const Size(1800, 3200);
    await tester.pumpWidget(testWidget);
    await tester.tap(find.byType(ElevatedButton).first);
  });

  testWidgets('Test getting started screen #2', (tester) async {
    startApp();
    Widget testWidget = const MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(home: GettingStarted()),
    );
    tester.binding.window.physicalSizeTestValue = const Size(1800, 3200);
    await tester.pumpWidget(testWidget);
    await tester.tap(find.byType(ElevatedButton).last);
  });
}
