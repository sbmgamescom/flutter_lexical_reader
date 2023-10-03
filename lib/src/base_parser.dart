part of 'parser.dart';

abstract class Parser {
  Widget parse(Map<String, dynamic> child);
}

class ParserFactory {
  static Parser getParser(String type) {
    switch (type) {
      case 'quotes':
        return _ParseQuote();

      default:
        throw UnsupportedError('Unsupported type: $type');
    }
  }
}

List<Widget> parseJsonChildrenWidget(List<dynamic> children) {
  return children.map<Widget>(
    (child) {
      final type = child['type'];
      final parser = ParserFactory.getParser(type);
      return parser.parse(child);
    },
  ).toList();
}
