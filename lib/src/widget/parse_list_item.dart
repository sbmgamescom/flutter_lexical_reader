part of '../parser.dart';

class _ParseListItem extends StatelessWidget {
  const _ParseListItem({
    required this.child,
  });
  final Map<String, dynamic> child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: parseJsonChildrenWidget(child['children'] ?? []),
    );
  }
}
