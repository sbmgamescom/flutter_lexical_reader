part of '../parser.dart';

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
          return _ParseText(child: child);
        case 'quote':
          return _ParseParagraph(child: child);
        case 'image':
          return _ParseImage(child: child);
        case 'equation':
          return _ParseEquation(child: child);
        case 'table':
          return _ParseTable(child: child);
        case 'list':
          return _ParseList(child: child);
        case 'listitem':
          return _ParseListItem(child: child);
        default:
          return const SizedBox.shrink();
      }
    },
  ).toList();
}
