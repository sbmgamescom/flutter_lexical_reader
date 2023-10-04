import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

part 'widget/parse_text.dart';
part 'widget/parse_equation.dart';
part 'widget/parse_image.dart';
part 'widget/parse_paragraph.dart';
part 'widget/parse_table.dart';
part 'widget/parse_list.dart';
part 'widget/parse_list_item.dart';
part 'widget/parse_children.dart';

class LexicalParser extends StatefulWidget {
  const LexicalParser({
    super.key,
    required this.children,
    this.textStyle,
    this.lazyLoad,
    this.tablePadding,
  });
  final List<dynamic> children;
  final TextStyle? textStyle;
  final bool? lazyLoad;
  final EdgeInsets? tablePadding;

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

  @override
  Widget build(BuildContext context) {
    return PropsInheritedWidget(
      textStyle: textStyle,
      child: widget.lazyLoad == true
          ? ListView.builder(
              itemCount: widget.children.length,
              itemBuilder: (context, index) {
                return parseJsonChildrenWidget([widget.children[index]],
                    textStyle: textStyle)[0];
              },
            )
          : ListView(
              children: parseJsonChildrenWidget(widget.children,
                  textStyle: textStyle),
            ),
    );
  }
}

class PropsInheritedWidget extends InheritedWidget {
  final TextStyle textStyle;
  final EdgeInsets? tablePadding;

  const PropsInheritedWidget({
    Key? key,
    required this.textStyle,
    required Widget child,
    this.tablePadding,
  }) : super(key: key, child: child);

  static PropsInheritedWidget? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PropsInheritedWidget>();
  }

  static PropsInheritedWidget? of(BuildContext context) {
    final PropsInheritedWidget? result = maybeOf(context);
    assert(result != null, 'No PropsInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant PropsInheritedWidget oldWidget) {
    return textStyle != oldWidget.textStyle;
  }
}
