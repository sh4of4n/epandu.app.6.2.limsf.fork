import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingModal extends StatelessWidget {
  final isVisible;
  final color;

  LoadingModal({this.isVisible, this.color});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Opacity(
        opacity: 0.7,
        child: Container(
          color: Colors.grey[900],
          width: ScreenUtil.screenWidthDp,
          height: ScreenUtil.screenHeightDp,
          child: Center(
            child: SpinKitFoldingCube(
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
