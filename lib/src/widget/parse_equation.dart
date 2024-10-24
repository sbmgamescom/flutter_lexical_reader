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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _checkOverflow() {
    if (mounted) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (mounted) {
              if (notification.metrics.extentAfter == 0 &&
                  _isOverflowingRight) {
                setState(() {
                  _isOverflowingRight = false;
                });
              } else if (notification.metrics.extentAfter > 0 &&
                  !_isOverflowingRight) {
                setState(() {
                  _isOverflowingRight = true;
                });
              }

              if (notification.metrics.extentBefore == 0 &&
                  _isOverflowingLeft) {
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildSmokeEffect(),
                Positioned(
                  right: 15,
                  child: InkWell(
                    onTap: _scrollToEnd,
                    child: const Icon(
                      Icons.chevron_right_outlined,
                      color: Color.fromRGBO(85, 187, 235, 1),
                    ),
                  ),
                )
              ],
            ),
          ),
        // if (_isOverflowingLeft)
        //   Positioned(
        //     left: 0,
        //     top: 0,
        //     bottom: 0,
        //     child: Stack(
        //       alignment: Alignment.center,
        //       children: [
        //         _buildSmokeEffectRight(),
        //         Positioned(
        //           left: 15,
        //           child: InkWell(
        //             onTap: _scrollToEnd,
        //             child: const Icon(
        //               Icons.chevron_left_outlined,
        //               color: Color.fromRGBO(85, 187, 235, 1),
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
      ],
    );
  }

  Widget _buildSmokeEffectRight() {
    return IgnorePointer(
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0),
              Colors.white.withOpacity(1.0),
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
      ),
    );
  }

  Widget _buildSmokeEffect() {
    return IgnorePointer(
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(1),
              Colors.white.withOpacity(0.8),
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.0),
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
      ),
    );
  }

  void _scrollToEnd() {
    if (_scrollController.hasClients) {
      final position = _scrollController.position.maxScrollExtent;
      _scrollController.animateTo(
        position,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
