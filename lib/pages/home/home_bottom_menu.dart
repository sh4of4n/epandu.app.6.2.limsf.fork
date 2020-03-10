import 'package:epandu/custom_icon/my_custom_icons_icons.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeBottomMenu extends StatelessWidget {
  final iconText;

  HomeBottomMenu({this.iconText});

  final myImage = ImagesConstant();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            child: Table(
              children: [
                TableRow(
                  children: [
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              MyCustomIcons.home_icon,
                              size: 30,
                              color: Color(0xff666666),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Text('Home', style: iconText),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              MyCustomIcons.v_club_icon,
                              size: 30,
                              color: Color(0xff666666),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Text('V Club', style: iconText),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Image.memory(kTransparentImage,
                              width: ScreenUtil().setWidth(150)),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              MyCustomIcons.invite_icon,
                              size: 30,
                              color: Color(0xff666666),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Text('Invite', style: iconText),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              MyCustomIcons.menu_icon,
                              size: 30,
                              color: Color(0xff666666),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Text('Menu', style: iconText),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              myImage.sos,
              height: ScreenUtil().setHeight(400),
            ),
          ),
        ),
      ],
    );
  }
}
