import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class LexicalParser extends StatefulWidget {
  const LexicalParser({super.key, required this.children});
  final List<dynamic> children;

  @override
  State<LexicalParser> createState() => _LexicalParserState();
}

class _LexicalParserState extends State<LexicalParser> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: parseJsonChildrenWidget(
        widget.children,
      ),
    );
  }

  List<Widget> parseJsonChildrenWidget(List<dynamic> children) {
    return children.map<Widget>(
      (child) {
        switch (child['type']) {
          case 'heading':
            return parseParagraph(child);
          case 'paragraph':
            return parseParagraph(child);
          case 'text':
            return parseText(child);
          case 'image':
            return parseImage(child);
          case 'equation':
            return parseEquation(child);
          case 'table':
            return parseTable(child);
          default:
            return const SizedBox.shrink();
        }
      },
    ).toList();
  }

  Widget parseImage(Map<String, dynamic> child) {
    final double width = double.parse(child['maxWidth'].toString());
    // double height = double.parse(child['height'].toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(
        child['src'][0],
        width: width / 2,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget parseParagraph(Map<String, dynamic> child) {
    List<Widget> childrenWidgets = parseJsonChildrenWidget(
      child['children'] ?? [],
    );
    if (childrenWidgets.length > 1) {
      return Wrap(
        alignment: _wrapFromString(child['format']),
        children: childrenWidgets,
      );
    } else {
      return Column(
        crossAxisAlignment: _crossFromString(child['format']),
        children: childrenWidgets,
      );
    }
  }

  Widget parseText(Map<String, dynamic> child) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _OutputText(child: child),
    );
  }

  Widget parseEquation(Map<String, dynamic> child) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Math.tex(child['equation']),
    );
  }

  Widget parseTable(Map<String, dynamic> child) {
    List<TableRow> tableRows = (child['children'] ?? []).map<TableRow>(
      (row) {
        if (row['type'] == 'tablerow') {
          List<Widget> rowCells = (row['children'] ?? []).map<Widget>(
            (cell) {
              if (cell['type'] == 'tablecell') {
                return Column(
                  children: parseJsonChildrenWidget(cell['children'] ?? []),
                );
              }
              return const SizedBox.shrink();
            },
          ).toList();
          return TableRow(children: rowCells);
        }
        return const TableRow(children: []);
      },
    ).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        children: tableRows,
        border: TableBorder.all(color: Colors.black54),
      ),
    );
  }
}

class _OutputText extends StatelessWidget {
  const _OutputText({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Map<String, dynamic> child;

  @override
  Widget build(BuildContext context) {
    //Need Fix
    TextAlign textAlign = textAlignFromFormat(child['format']);
    return Text(
      child['text'],
      style: textStyle(child['format']),
      textAlign: textAlign,
    );
  }

  TextStyle textStyle(int? format) {
    FontWeight fontWeight = FontWeight.normal;
    FontStyle fontStyle = FontStyle.normal;
    TextDecoration decoration = TextDecoration.none;
    bool isStrikethrough = false;

    if (format == null) {
      return const TextStyle();
    }
    if (format & 1 != 0) fontWeight = FontWeight.bold;
    if (format & 2 != 0) fontStyle = FontStyle.italic;
    if (format & 4 != 0) decoration = TextDecoration.underline;
    if (format & 8 != 0) isStrikethrough = true;

    return TextStyle(
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: isStrikethrough ? TextDecoration.lineThrough : decoration,
    );
  }

  TextAlign textAlignFromFormat(int? format) {
    if (format == null) {
      return TextAlign.left;
    }
    if (format & 16 != 0) return TextAlign.left;
    if (format & 32 != 0) return TextAlign.center;
    if (format & 64 != 0) return TextAlign.right;
    return TextAlign.left; // значение по умолчанию
  }
}

WrapAlignment _wrapFromString(String? format) {
  switch (format) {
    case 'center':
      return WrapAlignment.center;
    case 'left':
      return WrapAlignment.start;
    case 'right':
      return WrapAlignment.end;
    default:
      return WrapAlignment.start;
  }
}

CrossAxisAlignment _crossFromString(String? format) {
  switch (format) {
    case 'center':
      return CrossAxisAlignment.center;
    case 'left':
      return CrossAxisAlignment.start;
    case 'right':
      return CrossAxisAlignment.end;
    default:
      return CrossAxisAlignment.start;
  }
}
