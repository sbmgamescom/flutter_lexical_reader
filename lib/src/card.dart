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
    this.listPadding,
    required this.cardStyle,
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

  final LexicalCardStyle cardStyle;

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
        allChildrenWidgets =
            getParsedChildrenWithSeparators(parsedChildren, context);

        return Padding(
          padding: widget.paragraphPadding ?? const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: _buildLimitedRichText(context, allChildrenWidgets,
                    maxLines: _isExpanded ? null : 4),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 0.0),
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  foregroundColor: const Color(0xff55BBEB),
                ),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded
                      ? widget.cardStyle.hideTitle
                      : widget.cardStyle.seeMoreTitle,
                  style: widget.paragraphStyle,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLimitedRichText(
    BuildContext context,
    List<InlineSpan> spans, {
    int? maxLines,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          textDirection: TextDirection.ltr,
          maxLines: maxLines,
        );

        List<InlineSpan> visibleSpans = [];

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
          textAlign: widget.cardStyle.textAlign,
          text: TextSpan(
              children: visibleSpans,
              style: TextStyle(
                height: widget.cardStyle.height,
              )),
          maxLines: maxLines,
          overflow:
              maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
        );
      },
    );
  }

  List<InlineSpan> getParsedChildrenWithSeparators(
      List<dynamic> children, BuildContext context) {
    List<InlineSpan> spans = [];

    for (int i = 0; i < children.length; i++) {
      spans.addAll(parseJsonChild(children[i]['children'] ?? [], context));

      // Добавляем перенос строки, кроме последней ноды
      if (i < children.length - 1) {
        spans.add(const TextSpan(text: '\n')); // Перенос строки
      }
    }

    return spans;
  }
}

class LexicalCardStyle {
  final TextAlign textAlign;
  final String seeMoreTitle;
  final String hideTitle;
  final double? height;

  LexicalCardStyle({
    this.textAlign = TextAlign.justify,
    required this.seeMoreTitle,
    required this.hideTitle,
    this.height,
  });
}
