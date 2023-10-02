import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

part 'widget/output_text.dart';
part 'widget/parse_text.dart';

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
            return _ParseText(child: child);
          case 'image':
            return parseImage(child);
          case 'equation':
            return parseEquation(child);
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
                Text('• '),
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
