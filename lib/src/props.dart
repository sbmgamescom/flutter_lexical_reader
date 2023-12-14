part of 'parser.dart';

class _PropsInheritedWidget extends InheritedWidget {
  final TextStyle? paragraphStyle;
  final TextStyle? h1Style;
  final TextStyle? h2Style;
  final EdgeInsets? tablePadding;
  final EdgeInsets? tableCellPadding;

  final EdgeInsets? paragraphPadding;
  final EdgeInsets? numberedPadding;
  final MathOptions? mathOptions;
  final ImageOptions? imageOptions;

  const _PropsInheritedWidget({
    Key? key,
    this.paragraphStyle,
    required Widget child,
    this.tablePadding,
    this.paragraphPadding,
    this.numberedPadding,
    this.tableCellPadding,
    this.mathOptions,
    this.h1Style,
    this.h2Style,
    this.imageOptions,
  }) : super(key: key, child: child);

  static _PropsInheritedWidget? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_PropsInheritedWidget>();
  }

  static _PropsInheritedWidget? of(BuildContext context) {
    final _PropsInheritedWidget? result = maybeOf(context);
    assert(result != null, 'No _PropsInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant _PropsInheritedWidget oldWidget) {
    return true;
  }
}
