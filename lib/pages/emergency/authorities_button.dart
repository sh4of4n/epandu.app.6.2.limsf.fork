import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthoritiesButton extends StatelessWidget {
  final onTap;
  final label;
  final tileFirstColor;
  final tileSecondColor;

  AuthoritiesButton({
    required this.onTap,
    required this.label,
    required this.tileFirstColor,
    required this.tileSecondColor,
  })  : assert(onTap != null),
        assert(label != null),
        assert(tileFirstColor != null),
        assert(tileSecondColor != null);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // customBorder:
      //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      child: Container(
        width: ScreenUtil().setWidth(600),
        height: ScreenUtil().setHeight(450),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              tileFirstColor,
              tileSecondColor,
            ],
            // stops: [0.5, 1],
          ),
          borderRadius: BorderRadius.circular(25.0),
          /* boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0.0, 6.0),
              spreadRadius: 2.0,
              blurRadius: 10.0,
            ),
          ], */
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(100),
            fontWeight: FontWeight.w900,
            color: Colors.grey.shade200,
          ),
        ),
      ),
    );
  }
}
