import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconTile extends StatelessWidget {
  final title;
  final tileFirstColor;
  final tileSecondColor;
  final tileImage;

  IconTile({
    this.title,
    this.tileFirstColor,
    this.tileSecondColor,
    this.tileImage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil.getInstance().setHeight(400),
        width: ScreenUtil.getInstance().setWidth(650),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              tileFirstColor,
              tileSecondColor,
            ],
            // stops: [0.5, 1],
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Opacity(
              opacity: 0.8,
              child: Container(
                alignment: Alignment(0.8, 0.0),
                padding: EdgeInsets.only(bottom: 7.0),
                child: tileImage != null
                    ? Image.asset(
                        tileImage,
                        width: ScreenUtil.getInstance().setHeight(180),
                      )
                    : SizedBox.shrink(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 15.0),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
