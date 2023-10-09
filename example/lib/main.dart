import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(

          // child: Padding(
          //         padding: const EdgeInsets.all(16.0),
          //         child: LexicalParser(
          //           children: testJson,
          //           tableCellPadding: const EdgeInsets.all(0),
          //           mathOptions: MathOptions(color: Colors.red),
          //         ),
          //       );
          ),
    );
  }
}

final testJson =
    '''{"root":{"children":[{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Headline1","type":"text","version":1}],"direction":"ltr","format":"justify","indent":0,"type":"heading","version":1,"tag":"h1"},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Headline2","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"heading","version":1,"tag":"h2"},{"children":[],"direction":"ltr","format":"justify","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":1,"mode":"normal","style":"","text":"Скорость ","type":"text","version":1},{"detail":0,"format":0,"mode":"normal","style":"color: #bd2828;","text":"чтения ","type":"text","version":1},{"detail":0,"format":0,"mode":"normal","style":"","text":"– это ","type":"text","version":1},{"detail":0,"format":1,"mode":"normal","style":"","text":"количество ","type":"text","version":1},{"detail":0,"format":0,"mode":"normal","style":"","text":"количество2 ","type":"text","version":1},{"detail":0,"format":2,"mode":"normal","style":"","text":"количество3  ","type":"text","version":1},{"detail":0,"format":0,"mode":"normal","style":"","text":"слов, ","type":"text","version":1},{"detail":0,"format":8,"mode":"normal","style":"","text":"прочитанных ","type":"text","version":1},{"detail":0,"format":0,"mode":"normal","style":"","text":"за 1 ","type":"text","version":1},{"detail":0,"format":4,"mode":"normal","style":"","text":"минуту","type":"text","version":1},{"detail":0,"format":0,"mode":"normal","style":"","text":". Ученик ","type":"text","version":1},{"detail":0,"format":32,"mode":"normal","style":"","text":"должен ","type":"text","version":1},{"detail":0,"format":0,"mode":"normal","style":"","text":"читать ","type":"text","version":1},{"detail":0,"format":64,"mode":"normal","style":"","text":"выразительно","type":"text","version":1},{"detail":0,"format":0,"mode":"normal","style":"","text":", не меняя темп чтения, соблюдая знаки препинания, чётко проговаривая слова. ","type":"text","version":1}],"direction":"ltr","format":"justify","indent":0,"type":"paragraph","version":1},{"children":[],"direction":null,"format":"","indent":0,"type":"paragraph","version":1},{"children":[{"children":[{"children":[{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"test text","type":"text","version":1}],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":2},{"children":[{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Проверка текста","type":"text","version":1}],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":0},{"children":[{"children":[],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":0},{"children":[{"children":[],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":0}],"direction":null,"format":"","indent":0,"type":"tablerow","version":1},{"children":[{"children":[{"children":[],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":2},{"children":[{"children":[],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":0},{"children":[{"children":[{"equation":"\\mathrm{abs}\\left(123\\right)","inline":true,"type":"equation","version":1}],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":0},{"children":[{"children":[{"equation":"\\mathrm{abs}\\left(asd\\right)","inline":true,"type":"equation","version":1}],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":0}],"direction":null,"format":"","indent":0,"type":"tablerow","version":1},{"children":[{"children":[{"children":[],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":2},{"children":[{"children":[],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":0},{"children":[{"children":[],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":0},{"children":[{"children":[],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":0}],"direction":null,"format":"","indent":0,"type":"tablerow","version":1},{"children":[{"children":[{"children":[{"equation":"AgHg","inline":true,"type":"equation","version":1}],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":2},{"children":[{"children":[{"altText":"","caption":{"editorState":{"root":{"children":[],"direction":null,"format":"","indent":0,"type":"root","version":1}}},"height":0,"maxWidth":772,"showCaption":false,"src":["https://test-beyim-content.s3.eu-central-1.amazonaws.com/651a5f561a00123b63c4be9b/58369932-eeb8-4bfe-b422-2400bf6c3f92.jpeg"],"type":"image","version":1,"width":0}],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":0},{"children":[{"children":[],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":0},{"children":[{"children":[],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":null,"format":"","indent":0,"type":"tablecell","version":1,"headerState":0}],"direction":null,"format":"","indent":0,"type":"tablerow","version":1}],"direction":null,"format":"","indent":0,"type":"table","version":1},{"children":[],"direction":null,"format":"","indent":0,"type":"paragraph","version":1}],"direction":"ltr","format":"","indent":0,"type":"root","version":1}}''';
