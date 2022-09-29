import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatefulWidget {
  const PhotoViewPage({super.key});

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
        imageProvider: NetworkImage(
            "https://3u8dbs16f2emlqxkbc8tbvgf-wpengine.netdna-ssl.com/wp-content/uploads/2019/06/Coffee-bean-Tea-Leaf-Logo-Cups.jpg"),
      ),
    );
  }
}
