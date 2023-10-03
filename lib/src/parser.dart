import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

part 'widget/parse_text.dart';
part 'widget/parse_equation.dart';
part 'widget/parse_image.dart';
part 'widget/parse_paragraph.dart';
part 'widget/parse_table.dart';

class LexicalParser extends StatefulWidget {
  const LexicalParser({
    super.key,
    required this.children,
    this.textStyle,
    this.lazyLoad,
  });
  final List<dynamic> children;
  final TextStyle? textStyle;
  final bool? lazyLoad;

  @override
  State<LexicalParser> createState() => _LexicalParserState();
}

class _LexicalParserState extends State<LexicalParser> {
  TextStyle? _textStyle;
  TextStyle get textStyle {
    return _textStyle ??= widget.textStyle ??
        Theme.of(context).textTheme.titleMedium ??
        const TextStyle();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lazyLoad == true) {
      return ListView.builder(
        itemCount: widget.children.length,
        itemBuilder: (context, index) {
          return parseJsonChildrenWidget([widget.children[index]],
              textStyle: textStyle)[0];
        },
      );
    }
    return ListView(
      children: parseJsonChildrenWidget(widget.children, textStyle: textStyle),
    );
  }
}

List<Widget> parseJsonChildrenWidget(
  List<dynamic> children, {
  TextStyle? textStyle,
}) {
  return children.map<Widget>(
    (child) {
      switch (child['type']) {
        case 'heading':
          return _ParseParagraph(child: child);
        case 'paragraph':
          return _ParseParagraph(child: child);
        case 'text':
          return _ParseText(
              child: child,
              textStyle: textStyle ?? const TextStyle(fontSize: 14));
        case 'quote':
          // return parseParagraph(child);
          return _ParseParagraph(child: child);
        case 'image':
          return _ParseImage(child: child);
        case 'equation':
          return _ParseEquation(child: child);
        case 'table':
          return _ParseTable(child: child);
        case 'list':
          return parseList(child);
        case 'listitem':
          return parseListItem(child);
        default:
          return const SizedBox.shrink();
      }
    },
  ).toList();
}

Widget parseList(Map<String, dynamic> child) {
  List<Widget> childrenWidgets = parseJsonChildrenWidget(
    child['children'] ?? [],
  );

  if (child['listType'] == 'number') {
    int count = 1;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        children: childrenWidgets.map((widget) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${count++}.'),
              Expanded(child: widget),
            ],
          );
        }).toList(),
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        children: childrenWidgets.map((widget) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('•'),
              Expanded(child: widget),
            ],
          );
        }).toList(),
      ),
    );
  }
}

Widget parseListItem(Map<String, dynamic> child) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: parseJsonChildrenWidget(child['children'] ?? []),
  );
}
