import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatefulWidget {
  final String url;
  const PhotoViewPage({super.key, required this.url});

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Coffee Bean & Tea Leaf'),
      ),
      body: PhotoView(
        imageProvider: NetworkImage(widget.url),
      ),
    );
  }
}
