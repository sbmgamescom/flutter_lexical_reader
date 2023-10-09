part of '../parser.dart';

WidgetSpan _parseEquation(Map<String, dynamic> child) {
  return WidgetSpan(
    child: Math.tex(
      child['equation'],
      options: MathOptions(style: MathStyle.display),
    ),
  );
}
