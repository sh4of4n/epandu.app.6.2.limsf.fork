import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class KppModuleIcon extends StatelessWidget {
  final snapshot;
  final index;
  final icon;
  final component;
  final iconColor;
  final String? label;

  KppModuleIcon({
    this.snapshot,
    this.index,
    this.icon,
    this.component,
    this.iconColor,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        component != null ? context.router.push(component) : SizedBox.shrink();
      },
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        width: ScreenUtil().setWidth(650),
        height: ScreenUtil().setHeight(650),
        decoration: BoxDecoration(
          color: iconColor,
          // border: Border.all(width: 1.0, color: Colors.black12),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(1.0, 2.0),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: icon,
            ),
            SizedBox(height: 15.0),
            Text(
              label != null ? label! : '${snapshot[index].paperNo}',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(60),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
