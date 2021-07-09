import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final String? title;
  final NetworkImage? image;

  ImageViewer({this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: Container(
        child: PhotoView(
          backgroundDecoration: BoxDecoration(
            color: Colors.white,
          ),
          imageProvider: image,
        ),
      ),
    );
  }
}
