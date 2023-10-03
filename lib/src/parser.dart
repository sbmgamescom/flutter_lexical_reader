import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

part 'widget/parse_text.dart';
part 'widget/parse_equation.dart';
part 'widget/parse_image.dart';
part 'widget/parse_paragraph.dart';
part 'widget/parse_quote.dart';
part 'base_parser.dart';

class LexicalParser extends StatefulWidget {
  const LexicalParser({
    super.key,
    required this.children,
  });
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
            return _ParseText(child: child);

          case 'image':
            return _ParseImage(child: child);
          case 'equation':
            return _ParseEquation(child: child);
          case 'table':
            return parseTable(child);
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

  Widget parseParagraph(Map<String, dynamic> child) {
    List<Widget> childrenWidgets = parseJsonChildrenWidget(
      child['children'] ?? [],
    );
    if (childrenWidgets.length > 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: _wrapFromString(child['format']),
          children: childrenWidgets,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: _crossFromString(child['format']),
          children: childrenWidgets,
        ),
      );
    }
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
                Text('•'),
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
}
