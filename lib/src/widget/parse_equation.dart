part of '../parser.dart';

class _ParseEquation extends StatelessWidget {
  const _ParseEquation({required this.child});

  final Map<String, dynamic> child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Math.tex(child['equation']),
    );
  }
}
