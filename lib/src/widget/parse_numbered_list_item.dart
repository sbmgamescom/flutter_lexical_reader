part of '../parser.dart';

class _ParseNumberedListItem extends StatelessWidget {
  const _ParseNumberedListItem({
    required this.child,
  });
  final Map<String, dynamic> child;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: parseJsonChild(child['children'] ?? [])),
    );
  }
}
