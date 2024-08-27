part of 'parser.dart';

/// The primary widget for parsing and rendering complex JSON structures.
///
/// The LexicalParser can either take a direct `Map<String, dynamic>` structure through `sourceMap`
/// or a raw JSON string through `sourceString`. It processes this input to generate a visual representation.
///
/// Other stylistic and structural properties can also be customized.
class LexicalCard extends StatefulWidget {
  const LexicalCard({
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
  State<LexicalCard> createState() => _LexicalCardState();
}

class _LexicalCardState extends State<LexicalCard> {
  Map<String, dynamic>? _data;
  bool _isExpanded = false;

  List<dynamic> get parsedChildren =>
      _data?['root']['children'] as List<dynamic>? ?? [];

  @override
  void initState() {
    super.initState();
    try {
      if (widget.sourceString != null) {
        _data = jsonDecode(widget.sourceString!);
      } else {
        _data = widget.sourceMap;
      }
    } catch (e) {}
    log(_data.toString());
  }

  @override
  Widget build(BuildContext context) {
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
      child: Builder(builder: (context) {
        List<InlineSpan> allChildrenWidgets = [];

        // Collect all InlineSpan from each child
        for (var child in parsedChildren) {
          allChildrenWidgets
              .addAll(parseJsonChild(child['children'] ?? [], context));
        }

        return Padding(
          padding: widget.paragraphPadding ?? const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLimitedRichText(context, allChildrenWidgets,
                  maxLines: _isExpanded ? null : 4),
              if (!_isExpanded)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = true;
                    });
                  },
                  child: const Text('See More'),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLimitedRichText(BuildContext context, List<InlineSpan> spans,
      {int? maxLines}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          textDirection: TextDirection.ltr,
          maxLines: maxLines,
        );

        List<InlineSpan> visibleSpans = [];
        int currentLine = 0;

        for (var span in spans) {
          visibleSpans.add(span);
          textPainter.text = TextSpan(children: visibleSpans);
          textPainter.layout(maxWidth: constraints.maxWidth);

          final linesCount = textPainter.computeLineMetrics().length;

          if (maxLines != null && linesCount > maxLines) {
            visibleSpans.removeLast();
            break;
          }
        }

        return RichText(
          text: TextSpan(children: visibleSpans),
          maxLines: maxLines,
          overflow:
              maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
        );
      },
    );
  }
}
