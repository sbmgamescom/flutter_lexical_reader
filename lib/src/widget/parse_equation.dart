part of '../parser.dart';

WidgetSpan _parseEquation(
  Map<String, dynamic> child, {
  required MathEquationOptions options,
}) {
  return WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: Padding(
      padding: options.padding ?? const EdgeInsets.all(0),
      child: Math.tex(
        child['equation'],
        options: options.mathOptions,
        settings: options.textParserSettings,
        textStyle: options.textStyle,
        textScaleFactor: options.textScaleFactor,
      ),
    ),
  );
}
