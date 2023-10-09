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
    this.paragraphStyle,
    this.lazyLoad,
    this.tablePadding,
    this.paragraphPadding,
    this.numberedPadding,
    this.tableCellPadding,
    this.mathOptions,
  });
  final Map<String, dynamic> children;

  final TextStyle? paragraphStyle;
  final bool? lazyLoad;
  final EdgeInsets? tablePadding;
  final EdgeInsets? tableCellPadding;
  final EdgeInsets? paragraphPadding;
  final EdgeInsets? numberedPadding;
  final MathOptions? mathOptions;

  @override
  State<LexicalParser> createState() => _LexicalParserState();
}

class _LexicalParserState extends State<LexicalParser> {
  List<dynamic> get parsedChildren =>
      widget.children['root']['children'] as List<dynamic>;

  @override
  Widget build(BuildContext context) {
    return _PropsInheritedWidget(
      paragraphStyle: widget.paragraphStyle,
      tablePadding: widget.tablePadding,
      paragraphPadding: widget.paragraphPadding,
      numberedPadding: widget.numberedPadding,
      tableCellPadding: widget.tableCellPadding,
      mathOptions: widget.mathOptions,
      child: widget.lazyLoad == true
          ? ListView.builder(
              itemCount: widget.children.length,
              itemBuilder: (context, index) {
                return parseJsonChildrenWidget([parsedChildren[index]])[0];
              },
            )
          : ListView(
              children: parseJsonChildrenWidget(parsedChildren),
            ),
    );
  }
}
