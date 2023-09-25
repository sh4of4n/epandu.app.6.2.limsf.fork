import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final VoidCallback onPressed;
  final String title;
  final double? fontSize;
  final Color? fontColor;
  final double? minWidth;
  final double? height;

  const CustomButton({super.key, 
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 5),
        backgroundColor: buttonColor,
        textStyle: TextStyle(
          color: fontColor ?? Colors.white,
        ),
        shape: const StadiumBorder(),
        minimumSize: Size(minWidth ?? 88.0, height ?? 36.0),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize ?? 14,
        ),
      ),
    );
  }
}
