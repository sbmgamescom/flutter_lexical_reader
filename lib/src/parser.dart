import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

part 'widget/parse_text.dart';
part 'widget/parse_equation.dart';
part 'widget/parse_image.dart';
part 'widget/parse_paragraph.dart';
part 'widget/parse_table.dart';
part 'widget/parse_numbered_list.dart';
part 'widget/parse_numbered_list_item.dart';
part 'widget/parse_children.dart';
part 'props.dart';

class LexicalParser extends StatefulWidget {
  const LexicalParser({
    super.key,
    required this.children,
    this.textStyle,
    this.lazyLoad,
    this.tablePadding,
    this.paragraphPadding,
    this.numberedPadding,
    this.tableCellPadding,
  });
  final Map<String, dynamic> children;

  final TextStyle? textStyle;
  final bool? lazyLoad;
  final EdgeInsets? tablePadding;
  final EdgeInsets? tableCellPadding;
  final EdgeInsets? paragraphPadding;
  final EdgeInsets? numberedPadding;

  @override
  State<LexicalParser> createState() => _LexicalParserState();
}

class _LexicalParserState extends State<LexicalParser> {
  TextStyle? _textStyle;
  TextStyle get textStyle {
    return _textStyle ??= widget.textStyle ??
        Theme.of(context).textTheme.titleMedium ??
        const TextStyle(fontSize: 10);
  }

  List<dynamic> get parsedChildren =>
      widget.children['root']['children'] as List<dynamic>;

  @override
  Widget build(BuildContext context) {
    return _PropsInheritedWidget(
      textStyle: textStyle,
      tablePadding: widget.tablePadding,
      paragraphPadding: widget.paragraphPadding,
      numberedPadding: widget.numberedPadding,
      tableCellPadding: widget.tableCellPadding,
      child: widget.lazyLoad == true
          ? ListView.builder(
              itemCount: widget.children.length,
              itemBuilder: (context, index) {
                return parseJsonChildrenWidget([parsedChildren[index]],
                    textStyle: textStyle)[0];
              },
            )
          : ListView(
              children:
                  parseJsonChildrenWidget(parsedChildren, textStyle: textStyle),
            ),
    );
  }
}
