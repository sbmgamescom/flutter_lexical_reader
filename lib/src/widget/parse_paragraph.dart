part of '../parser.dart';

class _ParseParagraph extends StatelessWidget {
  const _ParseParagraph({
    required this.child,
  });
  final Map<String, dynamic> child;

  @override
  Widget build(BuildContext context) {
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
