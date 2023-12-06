part of '../parser.dart';

WidgetSpan _parseImage(Map<String, dynamic> child) {
  final double width = double.parse(child['maxWidth'].toString());
  final imageSource = child['src'];

  if (imageSource is String && imageSource.startsWith('data:image')) {
    // Убираем часть описания MIME типа для Base64 строки
    final String base64String = imageSource.split(',')[1];
    Uint8List bytes = base64Decode(base64String);
    return WidgetSpan(
      child: Image.memory(
        bytes,
        fit: BoxFit.fitWidth,
        errorBuilder: (context, error, stackTrace) {
          return const Row(
            children: [
              Text('Не удалось загрузить BASE изображение'),
              Icon(Icons.error),
            ],
          );
        },
      ),
    );
  }
  return WidgetSpan(
    child: Image.network(
      child['src'][0],
      width: width / 2,
      fit: BoxFit.fitWidth,
      errorBuilder: (context, error, stackTrace) {
        return const Row(
          children: [
            Text('Не удалось загрузить изображение'),
            Icon(Icons.error),
          ],
        );
      },
    ),
  );
}
