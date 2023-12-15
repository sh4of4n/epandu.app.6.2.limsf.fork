import 'dart:io';

import 'package:flutter/material.dart';

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;
  final String heroTag;

  const FullScreenImagePage(
      {super.key, required this.imageUrl, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: heroTag,
            child: Image.file(
              File(imageUrl),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
