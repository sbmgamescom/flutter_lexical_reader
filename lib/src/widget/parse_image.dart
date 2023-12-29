part of '../parser.dart';

WidgetSpan _parseImage(Map<String, dynamic> child, BuildContext context) {
  // final double width = double.parse(child['maxWidth'].toString());
  final imageSource = child['src'];
  final Widget image;
  final imageOptions = _PropsInheritedWidget.of(context)?.imageOptions;

  if (imageSource is String && imageSource.startsWith('data:image')) {
    final String base64String = imageSource.split(',')[1];
    Uint8List bytes = base64Decode(base64String);
    image = Image.memory(
      bytes,
      fit: BoxFit.fitWidth,
      errorBuilder: (context, error, stackTrace) => _imageErrorBuilder(),
    );
  } else {
    image = CachedNetworkImage(
      imageUrl: child['src'][0],
      errorWidget: (context, error, stackTrace) => _imageErrorBuilder(),
      fit: BoxFit.fitWidth,
      placeholder: (context, url) => const CircularProgressIndicator(),
    );
  }
  return WidgetSpan(
    child: Padding(
      padding: imageOptions?.padding ?? const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => _fullScreenImage(context, image),
        child: image,
      ),
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
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: InteractiveViewer(
              // constrained: false, // Установите constrained в false
              // panEnabled: false, // Включите возможность панорамирования
              minScale: 0.5,
              maxScale: 4.0,
              // boundaryMargin: EdgeInsets.all(double.infinity),
              child: child,
            ),
          ),
        ),
      ),
    ),
  );
}

Row _imageErrorBuilder() {
  return const Row(
    children: [
      Text('Failed to load BASE64 image'),
      Icon(Icons.error),
    ],
  );
}
