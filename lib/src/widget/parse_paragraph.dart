part of '../parser.dart';

class _ParseParagraph extends StatelessWidget {
  const _ParseParagraph({
    required this.child,
  });
  final Map<String, dynamic> child;

  @override
  Widget build(BuildContext context) {
    final paragraphPadding =
        PropsInheritedWidget.of(context)?.paragraphPadding ??
            const EdgeInsets.symmetric(vertical: 8.0);
    final List<Widget> childrenWidgets = parseJsonChildrenWidget(
      child['children'] ?? [],
    );
    final Widget content;
    if (childrenWidgets.length > 1) {
      content = Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: _alignmentFromString<WrapAlignment>(child['format']),
        children: childrenWidgets,
      );
    } else {
      content = Column(
        crossAxisAlignment:
            _alignmentFromString<CrossAxisAlignment>(child['format']),
        children: childrenWidgets,
      );
    }

    return Padding(
      padding: paragraphPadding,
      child: content,
    );
  }
}

T _alignmentFromString<T>(String? format) {
  switch (format) {
    case 'center':
      if (T == WrapAlignment) return WrapAlignment.center as T;
      return CrossAxisAlignment.center as T;
    case 'left':
      if (T == WrapAlignment) return WrapAlignment.start as T;
      return CrossAxisAlignment.start as T;
    case 'right':
      if (T == WrapAlignment) return WrapAlignment.end as T;
      return CrossAxisAlignment.end as T;
    default:
      if (T == WrapAlignment) return WrapAlignment.start as T;
      return CrossAxisAlignment.start as T;
  }
}
