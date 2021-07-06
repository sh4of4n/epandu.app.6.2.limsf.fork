import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class KppCategoryIcon extends StatelessWidget {
  final image;
  final width;
  final height;
  final borderWidth;
  final borderColor;
  final component;

  KppCategoryIcon({
    this.image,
    this.width,
    this.height,
    this.borderWidth,
    this.borderColor,
    this.component,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        component != null ? context.router.push(component) : SizedBox.shrink();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: borderWidth ?? 1.0,
              color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        width: width,
        height: height,
      ),
    );
  }
}
