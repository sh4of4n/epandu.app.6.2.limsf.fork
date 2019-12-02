import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_color/random_color.dart';

RandomColor _randomColor = RandomColor();

class KppModuleIcon extends StatelessWidget {
  final snapshot;
  final index;
  final icon;
  final component;
  final argument;

  KppModuleIcon({
    this.snapshot,
    this.index,
    this.icon,
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
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(width: 1.0, color: Colors.black12),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(1.0, 2.0),
                blurRadius: 5.0,
                spreadRadius: 2.0),
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(360),
              height: ScreenUtil().setHeight(430),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: _randomColor.randomColor(
                  // colorHue: ColorHue.multiple(
                  //     colorHues: [ColorHue.green, ColorHue.blue]),
                  colorBrightness: ColorBrightness.light,
                  colorSaturation: ColorSaturation.highSaturation,
                ),
              ),
              child: Center(
                child: icon,
              ),
            ),
            SizedBox(height: 15.0),
            Text(
              '${snapshot.data[index]["paper_no"]}',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(60),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
