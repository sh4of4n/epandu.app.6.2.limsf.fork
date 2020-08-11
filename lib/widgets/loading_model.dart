import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingModel extends StatelessWidget {
  final isVisible;
  final color;

  LoadingModel({this.isVisible, this.color});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisible,
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.7,
              child: Container(
                color: Colors.grey[900],
                width: ScreenUtil.screenWidth,
                height: ScreenUtil.screenHeight,
              ),
            ),
            Center(
              child: SpinKitFoldingCube(
                color: color,
              ),
            ),
          ],
        ));
  }
}
