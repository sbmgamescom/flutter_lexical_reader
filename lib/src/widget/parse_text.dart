part of '../parser.dart';

class _ParseText extends StatelessWidget {
  const _ParseText({required this.child});

  final Map<String, dynamic> child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _OutputText(child: child),
    );
  }
}
