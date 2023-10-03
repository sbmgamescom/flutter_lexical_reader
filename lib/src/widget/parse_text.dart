part of '../parser.dart';

class _ParseText extends StatelessWidget {
  const _ParseText({required this.child});

  final Map<String, dynamic> child;

  @override
  Widget build(BuildContext context) {
    return _OutputText(child: child);
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
    TextStyle baseStyle = textStyle(child['format']);

    TextSpan mainSpan;
    if (isSuperscript(child['format'])) {
      mainSpan = TextSpan(
        text: child['text'],
        style: baseStyle.copyWith(
          fontSize: baseStyle.fontSize! * 0.7,
          height: 0.8,
        ),
      );
    } else if (isSubscript(child['format'])) {
      mainSpan = TextSpan(
        text: child['text'],
        style: baseStyle.copyWith(
          fontSize: baseStyle.fontSize! * 0.7,
          height: 3.2,
        ),
      );
    } else {
      mainSpan = TextSpan(
        text: child['text'],
        style: baseStyle,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: RichText(text: mainSpan),
    );
  }

  bool isSuperscript(int? format) {
    return format != null && (format & 64) != 0;
  }

  bool isSubscript(int? format) {
    return format != null && (format & 32) != 0;
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
    if (format & 4 != 0) isStrikethrough = true;
    if (format & 8 != 0) decoration = TextDecoration.underline;

    return TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: isStrikethrough ? TextDecoration.lineThrough : decoration,
    );
  }
}
