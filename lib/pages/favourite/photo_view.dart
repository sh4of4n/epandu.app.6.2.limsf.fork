import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewPage extends StatefulWidget {
  final List url;
  final String title;
  final int initialIndex;
  final String type;
  const PhotoViewPage({
    super.key,
    required this.url,
    required this.title,
    required this.initialIndex,
    required this.type,
  });

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  PageController? pageController;
  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: _buildItem,
        itemCount: widget.url.length,
        // backgroundDecoration: widget.backgroundDecoration,
        pageController: pageController,
        onPageChanged: onPageChanged,
        // scrollDirection: widget.scrollDirection,
      ),
      // body: PhotoView(
      //   imageProvider: NetworkImage(widget.url),
      // ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    var imageType;
    if (widget.type == 'network') {
      imageType = NetworkImage(widget.url[index]);
    } else if (widget.type == 'asset') {
      imageType = AssetImage(widget.url[index]);
    } else {
      imageType = FileImage(widget.url[index]);
    }
    return PhotoViewGalleryPageOptions(
      imageProvider: imageType,
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: index),
    );
  }
}
