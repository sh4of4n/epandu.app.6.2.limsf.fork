import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KppCategoryIcon extends StatelessWidget {
  final image;
  final width;
  final height;
  final borderWidth;
  final borderColor;
  final component;
  final argument;

  KppCategoryIcon({
    this.image,
    this.width,
    this.height,
    this.borderWidth,
    this.borderColor,
    this.component,
    this.argument,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        component != null
            ? Navigator.pushNamed(context, component, arguments: argument)
            : SizedBox.shrink();
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
