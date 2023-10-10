part of '../parser.dart';

TextSpan _parseText(Map<String, dynamic> child) {
  final baseStyle = _textStyle(child['format']);
  final fontSize = baseStyle.fontSize ?? 12;

  TextSpan mainSpan;

  if (_isSubscript(child['format'])) {
    mainSpan = TextSpan(
      text: child['text'],
      style: baseStyle.copyWith(
        fontSize: fontSize * 0.7,
        height: 0.8,
      ),
    );
  } else if (_isSuperscript(child['format'])) {
    mainSpan = TextSpan(
      text: child['text'],
      style: baseStyle.copyWith(
        fontSize: fontSize * 0.7,
        height: 3.2,
      ),
    );
  } else {
    mainSpan = TextSpan(
      text: child['text'],
      style: baseStyle,
    );
  }
  return mainSpan;
}

bool _isSuperscript(int? format) {
  return format != null && (format & 64) != 0;
}

bool _isSubscript(int? format) {
  return format != null && (format & 32) != 0;
}

TextStyle _textStyle(int? format) {
  const textStyle = TextStyle();
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

  return textStyle.copyWith(
    color: Colors.black,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    decoration: isStrikethrough ? TextDecoration.lineThrough : decoration,
  );
}
