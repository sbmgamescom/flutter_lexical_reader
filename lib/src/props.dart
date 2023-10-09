part of 'parser.dart';

class _PropsInheritedWidget extends InheritedWidget {
  final TextStyle textStyle;
  final EdgeInsets? tablePadding;
  final EdgeInsets? tableCellPadding;

  final EdgeInsets? paragraphPadding;
  final EdgeInsets? numberedPadding;

  const _PropsInheritedWidget({
    Key? key,
    required this.textStyle,
    required Widget child,
    this.tablePadding,
    this.paragraphPadding,
    this.numberedPadding,
    this.tableCellPadding,
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
    return textStyle != oldWidget.textStyle;
  }
}
