part of '../parser.dart';

class _ParseNumberedList extends StatelessWidget {
  const _ParseNumberedList({
    required this.child,
  });
  final Map<String, dynamic> child;

  @override
  Widget build(BuildContext context) {
    final numberedPadding = PropsInheritedWidget.of(context)?.numberedPadding ??
        const EdgeInsets.only(left: 20.0, bottom: 20);
    List<Widget> childrenWidgets = parseJsonChildrenWidget(
      child['children'] ?? [],
    );

    if (child['listType'] == 'number') {
      int count = 1;
      return Padding(
        padding: numberedPadding,
        child: Column(
          children: childrenWidgets.map((widget) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${count++}. '),
                Expanded(child: widget),
              ],
            );
          }).toList(),
        ),
      );
    } else {
      return Padding(
        padding: numberedPadding,
        child: Column(
          children: childrenWidgets.map((widget) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('• '),
                Expanded(child: widget),
              ],
            );
          }).toList(),
        ),
      );
    }
  }
}
