part of '../parser.dart';

class ImageOptions {}

WidgetSpan _parseImage(Map<String, dynamic> child, BuildContext context) {
  final double width = double.parse(child['maxWidth'].toString());
  final imageSource = child['src'];
  final Image image;

  if (imageSource is String && imageSource.startsWith('data:image')) {
    final String base64String = imageSource.split(',')[1];
    Uint8List bytes = base64Decode(base64String);
    image = Image.memory(
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
    );
  } else {
    image = Image.network(
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
    );
  }
  return WidgetSpan(
    child: GestureDetector(
      onTap: () {
        log('tap');
        _fullScreenImage(context, image);
      },
      child: image,
    ),
  );
}

void _fullScreenImage(BuildContext context, Widget child) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              )),
        ),
        body: Center(
          child: InteractiveViewer(
            panEnabled: false,
            // boundaryMargin: const EdgeInsets.all(80),
            minScale: 0.5,
            maxScale: 4.0,
            child: child,
          ),
        ),
      ),
    ),
  );
}
