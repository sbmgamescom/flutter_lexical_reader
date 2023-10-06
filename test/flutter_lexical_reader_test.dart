// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:flutter_lexical_reader/flutter_lexical_reader.dart';

// void main() {
//   testWidgets('LexicalParser can be created', (WidgetTester tester) async {
//     final widget = LexicalParser(
//       children: [],
//     );

//     await tester.pumpWidget(MaterialApp(home: widget));

//     expect(find.byType(LexicalParser), findsOneWidget);
//   });

//   testWidgets('LexicalParser displays children', (WidgetTester tester) async {
//     final children =
//         """{"root":{"children":[{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"indent 0 BEKA","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"indent 1 ABAY","type":"text","version":1}],"direction":"ltr","format":"","indent":1,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"indent 2 ALISH","type":"text","version":1}],"direction":"ltr","format":"","indent":2,"type":"paragraph","version":1}],"direction":"ltr","format":"","indent":0,"type":"root","version":1}}""";



//     // Создаем виджет с ребенком
//     final widget = LexicalParser(
//       children,
//     );

//     await tester.pumpWidget(MaterialApp(home: widget));

//     expect(find.byWidget(child), findsOneWidget);
//   });
// }
