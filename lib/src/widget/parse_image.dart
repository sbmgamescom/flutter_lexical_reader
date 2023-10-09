part of '../parser.dart';

WidgetSpan _parseImage(Map<String, dynamic> child) {
  final double width = double.parse(child['maxWidth'].toString());
  return WidgetSpan(
    child: Image.network(
      child['src'][0],
      width: width / 2,
      fit: BoxFit.fitWidth,
    ),
  );
}
