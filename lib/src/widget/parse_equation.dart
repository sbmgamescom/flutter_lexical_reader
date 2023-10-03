part of '../parser.dart';

class _ParseEquation extends StatelessWidget {
  const _ParseEquation({required this.child});

  final Map<String, dynamic> child;

  @override
  Widget build(BuildContext context) {
    return Math.tex(
      child['equation'],
      options: MathOptions(style: MathStyle.display),
    );
  }
}
