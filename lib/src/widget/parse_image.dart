part of '../parser.dart';

class _ParseImage extends StatelessWidget {
  const _ParseImage({required this.child});

  final Map<String, dynamic> child;

  @override
  Widget build(BuildContext context) {
    final double width = double.parse(child['maxWidth'].toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(
        child['src'][0],
        width: width / 2,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
