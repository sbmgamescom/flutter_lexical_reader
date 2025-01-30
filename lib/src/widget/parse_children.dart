part of '../parser.dart';

List<Widget> parseJsonChildrenWidget(List<dynamic> children) {
  return children.map<Widget>(
    (child) {
      switch (child['type']) {
        case 'heading':
          return _ParseParagraph(
            child: child,
            lineType: child['tag'] == 'h1' ? LineType.h1 : LineType.h2,
          );
        case 'paragraph':
          return _ParseParagraph(child: child);
        case 'quote':
          return _ParseParagraph(child: child);
        case 'table':
          return ParseTable(child: child);
        case 'list':
          return _ParseNumberedList(child: child);
        case 'listitem':
          return _ParseParagraph(child: child);
        default:
          return const SizedBox.shrink();
      }
    },
  ).toList();
}

List<InlineSpan> parseJsonChild(List<dynamic> children, BuildContext context) {
  final List<InlineSpan> widgets = [];
  final props = _PropsInheritedWidget.of(context)!;

  for (var child in children) {
    switch (child['type']) {
      case 'text':
        widgets.add(_parseText(
          child,
          props.paragraphStyle ?? const TextStyle(),
          props.useMyTextStyle,
        ));
        break;
      case 'image':
        widgets.add(_parseImage(child, context));
        break;
      case 'equation':
        widgets.add(_parseEquation(child, options: props.mathEquationOptions));
        break;
      default:
        widgets.add(const WidgetSpan(child: SizedBox.shrink()));
        break;
    }
  }
  return widgets;
}
