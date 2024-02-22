part of '../parser.dart';

InlineSpan _parseText(
  Map<String, dynamic> child,
  TextStyle textStyle, {
  int? indent,
}) {
  final baseStyle = _textStyle(child['format'], textStyle);
  final fontSize = baseStyle.fontSize ?? 12;

  InlineSpan mainSpan;

  if (_isSubscript(child['format'])) {
    mainSpan = WidgetSpan(
      child: Transform.translate(
        offset: const Offset(0, 5),
        child: Text(
          child['text'],
          style: baseStyle.copyWith(
            fontSize: fontSize,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  } else if (_isSuperscript(child['format'])) {
    mainSpan = WidgetSpan(
      child: Transform.translate(
        offset: const Offset(0, -5),
        child: Text(
          child['text'],
          style: baseStyle.copyWith(
            fontSize: fontSize,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  } else {
    if (child['text'].startsWith('     ')) {
      mainSpan = TextSpan(
        children: [
          const WidgetSpan(child: SizedBox(width: 25)),
          TextSpan(
              text: child['text'].substring(5)) // Обрезаем первые 5 пробелов
        ],
        style: baseStyle,
      );
    }
    //  else if (indent != 0) {
    //   mainSpan = TextSpan(
    //     children: [
    //       WidgetSpan(child: SizedBox(width: 25 * indent!.toDouble())),
    //       TextSpan(text: child['text'])
    //     ],
    //     style: baseStyle,
    //   );
    // }
    else {
      mainSpan = TextSpan(
        text: child['text'],
        style: baseStyle,
      );
    }
  }
  return mainSpan;
}

bool _isSuperscript(int? format) {
  return format != null && (format & 64) != 0;
}

bool _isSubscript(int? format) {
  return format != null && (format & 32) != 0;
}

TextStyle _textStyle(int? format, TextStyle style) {
  final textStyle = style;
  FontWeight fontWeight = FontWeight.normal;
  FontStyle fontStyle = FontStyle.normal;
  TextDecoration decoration = TextDecoration.none;
  bool isStrikethrough = false;

  if (format == null) {
    return style;
  }
  if (format & 1 != 0) fontWeight = FontWeight.bold;
  if (format & 2 != 0) fontStyle = FontStyle.italic;
  if (format & 4 != 0) isStrikethrough = true;
  if (format & 8 != 0) decoration = TextDecoration.underline;

  return textStyle.copyWith(
    color: Colors.black,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    decoration: isStrikethrough ? TextDecoration.lineThrough : decoration,
  );
}
