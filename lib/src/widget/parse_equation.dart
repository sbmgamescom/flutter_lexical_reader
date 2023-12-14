part of '../parser.dart';

WidgetSpan _parseEquation(
  Map<String, dynamic> child, {
  MathOptions? mathOptions,
}) {
  return WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: Math.tex(
      child['equation'],
      options: mathOptions,
    ),
  );
}
