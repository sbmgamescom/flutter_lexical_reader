part of '../parser.dart';

class _ParseQuote implements Parser {
  @override
  Widget parse(Map<String, dynamic> child) {
    return _ParseText(child: child);
  }
}
