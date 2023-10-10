// parser_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_lexical_reader/flutter_lexical_reader.dart';

void main() {
  final mockData = {
    "root": {
      "children": [
        {
          "children": [
            {
              "detail": 0,
              "format": 0,
              "mode": "normal",
              "style": "",
              "text": "Hello world",
              "type": "text",
              "version": 1
            }
          ],
          "direction": "ltr",
          "format": "",
          "indent": 0,
          "type": "paragraph",
          "version": 1
        }
      ],
      "direction": "ltr",
      "format": "",
      "indent": 0,
      "type": "root",
      "version": 1
    }
  };
  testWidgets('LexicalParser renders correctly with valid data',
      (WidgetTester tester) async {
    // Mock data for _ParseTable

    await tester.pumpWidget(
      MaterialApp(
        home: LexicalParser(children: mockData),
      ),
    );

    // Verify that table cells have the correct text values
    expect(findRichText('Hello world'), findsOneWidget);
  });
}

Finder findRichText(String text) {
  return find.byWidgetPredicate(
    (Widget widget) =>
        widget is RichText && (widget.text.toPlainText() == text),
    description: 'RichText with text "$text"',
  );
}
