import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final buttonColor;
  final onPressed;
  final title;
  final fontSize;

  CustomButton(
      {@required this.buttonColor,
      @required this.onPressed,
      @required this.title,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      buttonColor: buttonColor,
      shape: StadiumBorder(),
      child: RaisedButton(
        onPressed: onPressed,
        textColor: Colors.white,
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
