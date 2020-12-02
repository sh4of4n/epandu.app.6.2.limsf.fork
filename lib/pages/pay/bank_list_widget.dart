import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankListWidget extends StatelessWidget {
  final isVisible;
  final Color color;
  final Color backgroundColor;
  final double opacity;
  final bankData;

  BankListWidget({
    this.isVisible,
    this.color,
    this.backgroundColor,
    this.opacity,
    this.bankData,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: opacity ?? 0.7,
            child: Container(
              color: backgroundColor ?? Colors.grey[900],
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
            ),
          ),
          ListView(
            children: [],
          ),
        ],
      ),
    );
  }
}
