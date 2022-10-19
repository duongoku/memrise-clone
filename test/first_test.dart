import 'package:demo/screens/language_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  void setTesterWindowSize(tester) {
    tester.binding.window.physicalSizeTestValue = const Size(1440, 3040);
  }

  testWidgets('Initial test to ensure everything is normal', (tester) async {
    setTesterWindowSize(tester);
  });

  // group('Getting started screen', () {
  //   Widget testWidget = const MediaQuery(
  //     data: MediaQueryData(),
  //     child: MaterialApp(home: GettingStarted()),
  //   );

  //   testWidgets('Test getting started screen #1', (tester) async {
  //     await tester.pumpWidget(testWidget);
  //     await tester.tap(find.byType(ElevatedButton).first);
  //   });

  //   testWidgets('Test getting started screen #2', (tester) async {
  //     await tester.pumpWidget(testWidget);
  //     await tester.tap(find.byType(ElevatedButton).last);
  //   });
  // });

  group('Language selection screen', () {
    Widget testWidget = const MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(home: LanguageSelectionScreen()),
    );

    testWidgets('Language selection #1', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.tap(find.byType(TextButton).first);
    });

    testWidgets('Language selection #2', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.tap(find.byType(DropdownButtonHideUnderline).first);
    });
  });
}
