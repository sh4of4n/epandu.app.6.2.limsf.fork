import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopUpButton extends StatelessWidget {
  final String? value;
  final TextStyle? textStyle;
  final onTap;

  TopUpButton({this.value, this.textStyle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5.0),
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          alignment: Alignment.topLeft,
          width: ScreenUtil().setWidth(630),
          height: ScreenUtil().setHeight(250),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.transparent,
          ),
          child: Text(value!, style: textStyle),
        ),
      ),
    );
  }
}
