import 'package:flutter/material.dart';
import 'package:flutter_lexical_reader/flutter_lexical_reader.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<String, dynamic>? mockData = {
    "root": {
      "children": [
        {
          "children": [
            {
              "equation": "OPP\\le\\notin",
              "inline": true,
              "type": "equation",
              "version": 1
            }
          ],
          "direction": null,
          "format": "",
          "indent": 1,
          "type": "paragraph",
          "version": 1
        }
      ],
      "direction": null,
      "format": "",
      "indent": 0,
      "type": "root",
      "version": 1
    }
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: LexicalParser(
          sourceMap: mockData,
        ),
      ),
    );
  }
}
