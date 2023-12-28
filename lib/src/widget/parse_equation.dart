part of '../parser.dart';

WidgetSpan _parseEquation(
  Map<String, dynamic> child, {
  required MathEquationOptions options,
}) {
  // final parts = Math.tex(
  //   child['equation'],
  //   options: options.mathOptions,
  //   settings: options.textParserSettings,
  //   textStyle: options.textStyle,
  //   textScaleFactor: options.textScaleFactor,
  // ).texBreak();

  // for (var element in parts.penalties) {
  //   print('penalties $element');
  // }

  // for (var element in parts.parts) {
  //   print('parts ${element.toStringDeep()}');
  // }

  // final widget = Wrap(
  //   crossAxisAlignment: WrapCrossAlignment.center,
  //   children: parts.parts,
  // );

  // return WidgetSpan(
  //   alignment: PlaceholderAlignment.middle,
  //   child: widget,
  // );

  // return TextSpan(
  //     children: List.generate(
  //   parts.parts.length,
  //   (index) => WidgetSpan(
  //     alignment: PlaceholderAlignment.middle,
  //     child: parts.parts[index],
  //   ),
  // ));

  return WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: Padding(
        padding: options.padding ?? const EdgeInsets.all(0),
        child: OverflowSmokeWidget(
          child: Math.tex(
            child['equation'],
            options: options.mathOptions,
            settings: options.textParserSettings,
            textStyle: options.textStyle,
            textScaleFactor: options.textScaleFactor,
          ),
        )),
  );
}

class OverflowSmokeWidget extends StatefulWidget {
  final Widget child;
  const OverflowSmokeWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<OverflowSmokeWidget> createState() => _OverflowSmokeWidgetState();
}

class _OverflowSmokeWidgetState extends State<OverflowSmokeWidget> {
  bool _isOverflowingRight = false;
  bool _isOverflowingLeft = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  void _checkOverflow() {
    if (_scrollController.position.maxScrollExtent > 0) {
      setState(() {
        _isOverflowingRight = true;
      });
    }
    if (_scrollController.position.minScrollExtent < 0) {
      setState(() {
        _isOverflowingLeft = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification.metrics.extentAfter == 0 && _isOverflowingRight) {
              setState(() {
                _isOverflowingRight = false;
              });
            } else if (notification.metrics.extentAfter > 0 &&
                !_isOverflowingRight) {
              setState(() {
                _isOverflowingRight = true;
              });
            }

            if (notification.metrics.extentBefore == 0 && _isOverflowingLeft) {
              setState(() {
                _isOverflowingLeft = false;
              });
            } else if (notification.metrics.extentBefore > 0 &&
                !_isOverflowingLeft) {
              setState(() {
                _isOverflowingLeft = true;
              });
            }
            return true;
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            scrollDirection: Axis.horizontal,
            child: widget.child,
          ),
        ),
        if (_isOverflowingRight)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: _buildSmokeEffect(),
          ),
        // if (_isOverflowingLeft)
        //   Positioned(
        //     left: 0,
        //     top: 0,
        //     bottom: 0,
        //     child: _buildSmokeEffect(),
        //   ),
      ],
    );
  }

  Widget _buildSmokeEffect() {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(1),
            Colors.white.withOpacity(0),
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
    );
  }
}
