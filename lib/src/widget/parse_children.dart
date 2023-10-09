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
        case 'quote':
          return _ParseParagraph(child: child);
        case 'table':
          return _ParseTable(child: child);
        case 'list':
          return _ParseNumberedList(child: child);
        case 'listitem':
          return _ParseNumberedListItem(child: child);
        default:
          return const SizedBox.shrink();
      }
    },
  ).toList();
}

List<InlineSpan> parseJsonChild(List<dynamic> children) {
  final List<InlineSpan> widgets = [];

  for (var child in children) {
    switch (child['type']) {
      case 'text':
        widgets.add(_parseText(child));
        break;
      case 'image':
        widgets.add(_parseImage(child));
        break;
      case 'equation':
        widgets.add(_parseEquation(child));
        break;
      default:
        widgets.add(const WidgetSpan(child: SizedBox.shrink()));
        break;
    }
  }

  return widgets;
}
