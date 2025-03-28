part of '../parser.dart';

class ParagraphStyle {
  final TextAlign textAlign;
  final double? heightText;

  ParagraphStyle({required this.textAlign, this.heightText});
}

class _ParseParagraph extends StatelessWidget {
  const _ParseParagraph({
    required this.child,
    this.lineType,
  });
  final Map<String, dynamic> child;
  final LineType? lineType;

  @override
  Widget build(BuildContext context) {
    final paragraphPadding =
        _PropsInheritedWidget.of(context)?.paragraphPadding ??
            const EdgeInsets.symmetric(vertical: 8.0);
    final TextStyle textStyle = _textStyle(context, lineType);
    final List<InlineSpan> childrenWidgets = parseJsonChild(
      child['children'] ?? [],
      context,
    );

    final paragraphDataStyle =
        _PropsInheritedWidget.of(context)?.paragraphDataStyle;
    return Padding(
      padding: paragraphPadding,
      child: RichText(
        textAlign: _alignmentFromString(child['format'],
            textAlign: paragraphDataStyle?.textAlign),
        text: TextSpan(
          children: childrenWidgets,
          style: textStyle.copyWith(
            height: paragraphDataStyle?.heightText,
          ),
        ),
      ),
    );
  }

  TextAlign _alignmentFromString(String? format, {TextAlign? textAlign}) {
    if (textAlign != null) {
      return textAlign;
    }
    switch (format) {
      case 'center':
        return TextAlign.center;
      case 'left':
        return TextAlign.start;
      case 'justify':
        return TextAlign.justify;
      case 'right':
        return TextAlign.end;
      default:
        return TextAlign.start;
    }
  }

  TextStyle _textStyle(BuildContext context, LineType? lineType) {
    final paragraphStyle = _PropsInheritedWidget.of(context)!.paragraphStyle ??
        Theme.of(context).textTheme.titleMedium ??
        const TextStyle(fontSize: 12);
    final h1Style = _PropsInheritedWidget.of(context)!.h1Style ??
        Theme.of(context).textTheme.headlineLarge ??
        const TextStyle(fontSize: 18);
    final h2Style = _PropsInheritedWidget.of(context)!.h2Style ??
        Theme.of(context).textTheme.headlineMedium ??
        const TextStyle(fontSize: 14);

    switch (lineType) {
      case LineType.h1:
        return h1Style;
      case LineType.paragraph:
        return paragraphStyle;
      case LineType.h2:
        return h2Style;
      default:
        return paragraphStyle;
    }
  }
}

enum LineType {
  h1,
  h2,
  paragraph,
}
