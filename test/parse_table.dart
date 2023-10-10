// parser_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/flutter_lexical_reader.dart';

void main() {
  testWidgets('_ParseTable renders correctly with valid data',
      (WidgetTester tester) async {
    // Mock data for _ParseTable
    final mockData = {
      'children': [
        {
          'type': 'tablerow',
          'children': [
            {
              'type': 'tablecell',
              'children': [
                {'type': 'text', 'text': 'Hello'}
              ]
            },
            {
              'type': 'tablecell',
              'children': [
                {'type': 'text', 'text': 'World'}
              ]
            }
          ]
        },
        {
          'type': 'tablerow',
          'children': [
            {
              'type': 'tablecell',
              'children': [
                {'type': 'text', 'text': 'Flutter'}
              ]
            },
            {
              'type': 'tablecell',
              'children': [
                {'type': 'text', 'text': 'Testing'}
              ]
            }
          ]
        }
      ]
    };

    await tester.pumpWidget(MaterialApp(
      home: ParseTable(child: mockData),
    ));

    // Verify that table cells have the correct text values
    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('World'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Testing'), findsOneWidget);
  });

  // You can add more tests, like checking behavior for invalid data, no children, etc.
}
