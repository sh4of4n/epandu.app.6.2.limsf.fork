import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final VoidCallback onPressed;
  final String title;
  final double? fontSize;
  final Color? fontColor;
  final double? minWidth;
  final double? height;

  CustomButton({
    required this.buttonColor,
    required this.onPressed,
    required this.title,
    this.fontSize,
    this.fontColor,
    this.minWidth,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      minWidth: minWidth ?? 88.0,
      height: height ?? 36.0,
      buttonColor: buttonColor,
      shape: StadiumBorder(),
      child: RaisedButton(
        onPressed: onPressed,
        textColor: fontColor ?? Colors.white,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize ?? 56.sp,
          ),
        ),
      ),
    );
  }
}
