part of '../parser.dart';

class _ParseParagraph extends StatelessWidget {
  const _ParseParagraph({
    required this.child,
  });
  final Map<String, dynamic> child;

  @override
  Widget build(BuildContext context) {
    final paragraphPadding =
        _PropsInheritedWidget.of(context)?.paragraphPadding ??
            const EdgeInsets.symmetric(
              vertical: 8.0,
            );
    final List<InlineSpan> childrenWidgets = parseJsonChild(
      child['children'] ?? [],
    );

    return Padding(
      padding: paragraphPadding,
      child: RichText(
        textAlign: _alignmentFromString(child['format']),
        text: TextSpan(children: childrenWidgets),
      ),
    );
  }
}

TextAlign _alignmentFromString(String? format) {
  switch (format) {
    case 'center':
      return TextAlign.center;
    case 'left':
      return TextAlign.start;
    case 'justify':
      return TextAlign.justify;
    case 'right':
      return TextAlign.end;
    default:
      return TextAlign.start;
  }
}
