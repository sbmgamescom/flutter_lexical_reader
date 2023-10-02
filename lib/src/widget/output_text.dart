part of '../parser.dart';

class _OutputText extends StatelessWidget {
  const _OutputText({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Map<String, dynamic> child;

  @override
  Widget build(BuildContext context) {
    //Need Fix
    TextAlign textAlign = textAlignFromFormat(child['format']);
    return Text(
      child['text'],
      style: textStyle(child['format']),
      textAlign: textAlign,
    );
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
    if (format & 4 != 0) decoration = TextDecoration.underline;
    if (format & 8 != 0) isStrikethrough = true;

    return TextStyle(
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: isStrikethrough ? TextDecoration.lineThrough : decoration,
    );
  }

  TextAlign textAlignFromFormat(int? format) {
    if (format == null) {
      return TextAlign.left;
    }
    if (format & 16 != 0) return TextAlign.left;
    if (format & 32 != 0) return TextAlign.center;
    if (format & 64 != 0) return TextAlign.right;
    return TextAlign.left;
  }
}
