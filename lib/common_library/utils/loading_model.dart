import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingModel extends StatelessWidget {
  final isVisible;
  final Color color;
  final Color backgroundColor;
  final double opacity;

  LoadingModel({
    this.isVisible,
    this.color,
    this.backgroundColor,
    this.opacity,
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
          Center(
            child: SpinKitChasingDots(
              color: color ?? Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
