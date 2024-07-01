import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lexical_reader/src/model/math_equation_options.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'model/image_options.dart';
import 'widget/expandable_list.dart';

part 'props.dart';
part 'widget/parse_children.dart';
part 'widget/parse_equation.dart';
part 'widget/parse_image.dart';
part 'widget/parse_numbered_list.dart';
part 'widget/parse_numbered_list_item.dart';
part 'widget/parse_paragraph.dart';
part 'widget/parse_table.dart';
part 'widget/parse_text.dart';

/// The primary widget for parsing and rendering complex JSON structures.
///
/// The LexicalParser can either take a direct `Map<String, dynamic>` structure through `sourceMap`
/// or a raw JSON string through `sourceString`. It processes this input to generate a visual representation.
///
/// Other stylistic and structural properties can also be customized.
class LexicalParser extends StatefulWidget {
  const LexicalParser({
    super.key,
    this.sourceMap,
    this.sourceString,
    this.paragraphStyle,
    this.lazyLoad,
    this.tablePadding,
    this.paragraphPadding,
    this.numberedPadding,
    this.tableCellPadding,
    this.mathEquationOptions = const MathEquationOptions(),
    this.h1Style,
    this.h2Style,
    this.shrinkWrap = false,
    this.scrollController,
    this.scrollPhysics,
    this.imageOptions = const ImageOptions(),
    this.mathEquationPadding,
    this.expanded,
    this.listPadding,
  });

  /// Direct input of the JSON structure.
  final Map<String, dynamic>? sourceMap;

  /// Raw JSON string, which will be parsed internally.
  final String? sourceString;

  final TextStyle? paragraphStyle;
  final TextStyle? h1Style;
  final TextStyle? h2Style;

  final bool? lazyLoad;
  final EdgeInsets? tablePadding;
  final EdgeInsets? tableCellPadding;
  final EdgeInsets? paragraphPadding;
  final EdgeInsets? numberedPadding;
  final MathEquationOptions mathEquationOptions;
  final bool shrinkWrap;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final ImageOptions imageOptions;
  final EdgeInsetsGeometry? mathEquationPadding;
  final EdgeInsetsGeometry? listPadding;

  final bool? expanded;

  @override
  State<LexicalParser> createState() => _LexicalParserState();
}

class _LexicalParserState extends State<LexicalParser> {
  Map<String, dynamic>? _data;

  List<dynamic> get parsedChildren =>
      _data?['root']['children'] as List<dynamic>? ?? [];

  @override
  void initState() {
    super.initState();
    if (widget.sourceString != null) {
      _data = jsonDecode(widget.sourceString!);
    } else {
      _data = widget.sourceMap;
    }
    log(_data.toString());
  }

  @override
  Widget build(BuildContext context) {
    log('Lexical: ${jsonEncode(_data)}');
    return _PropsInheritedWidget(
      paragraphStyle: widget.paragraphStyle,
      h1Style: widget.h1Style,
      h2Style: widget.h2Style,
      tablePadding: widget.tablePadding,
      paragraphPadding: widget.paragraphPadding,
      numberedPadding: widget.numberedPadding,
      tableCellPadding: widget.tableCellPadding,
      mathEquationOptions: widget.mathEquationOptions,
      imageOptions: widget.imageOptions,
      child: _buildList(),
    );
  }

  Widget _buildList() {
    if (widget.expanded == true) {
      return ExpandableListView(
        children: parseJsonChildrenWidget(parsedChildren),
      );
    }

    return widget.lazyLoad == true
        ? ListView.builder(
            controller: widget.scrollController,
            physics: widget.scrollPhysics,
            shrinkWrap: widget.shrinkWrap,
            itemCount: parsedChildren.length,
            itemBuilder: (context, index) {
              return parseJsonChildrenWidget([parsedChildren[index]])[0];
            },
          )
        : ListView(
            padding: widget.listPadding,
            physics: widget.scrollPhysics,
            controller: widget.scrollController,
            shrinkWrap: widget.shrinkWrap,
            children: parseJsonChildrenWidget(parsedChildren),
          );
  }
}
