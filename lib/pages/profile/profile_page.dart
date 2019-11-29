import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatelessWidget {
  final image = ImagesConstant();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        /* Container(
            height: ScreenUtil.getInstance().setHeight(300),
            width: ScreenUtil.screenWidth,
            color: Colors.blue), */
        Positioned(
          bottom: 0.0,
          child: Container(
            height: ScreenUtil.getInstance().setHeight(1900),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 35.0),
          width: ScreenUtil.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /* CircleAvatar(
                backgroundImage: AssetImage(image.iconAbout),
                radius: 80.0,
              ), */
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: AssetImage(image.feedSample),
                    fit: BoxFit.cover,
                  ),
                ),
                width: ScreenUtil.getInstance().setWidth(450),
                height: ScreenUtil.getInstance().setWidth(450),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
