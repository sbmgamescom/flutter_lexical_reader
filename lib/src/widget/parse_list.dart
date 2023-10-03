part of '../parser.dart';

class _ParseList extends StatelessWidget {
  const _ParseList({
    required this.child,
  });
  final Map<String, dynamic> child;

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenWidgets = parseJsonChildrenWidget(
      child['children'] ?? [],
    );

    if (child['listType'] == 'number') {
      int count = 1;
      return Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          children: childrenWidgets.map((widget) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${count++}.'),
                Expanded(child: widget),
              ],
            );
          }).toList(),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          children: childrenWidgets.map((widget) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('•'),
                Expanded(child: widget),
              ],
            );
          }).toList(),
        ),
      );
    }
  }
}
