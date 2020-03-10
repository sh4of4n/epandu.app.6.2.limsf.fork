import 'package:epandu/custom_icon/my_custom_icons_icons.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class BottomMenu extends StatelessWidget {
  final iconText;

  BottomMenu({this.iconText});

  final myImage = ImagesConstant();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(450),
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Ink(
              color: Colors.white,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      InkWell(
                        onTap: () => Navigator.popUntil(
                            context, ModalRoute.withName(HOME)),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 12.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                MyCustomIcons.home_icon,
                                size: 25,
                                color: Color(0xff666666),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(20)),
                              Text('Home', style: iconText),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, PAYMENT),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 12.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                MyCustomIcons.v_club_icon,
                                size: 25,
                                color: Color(0xff666666),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(20)),
                              Text('V Club', style: iconText),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 12.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            Image.memory(kTransparentImage,
                                width: ScreenUtil().setWidth(150)),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, INVITE),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 12.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                MyCustomIcons.invite_icon,
                                size: 25,
                                color: Color(0xff666666),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(20)),
                              Text('Invite', style: iconText),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, MENU),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 12.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                MyCustomIcons.menu_icon,
                                size: 25,
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
              onTap: () => Navigator.pushNamed(context, EMERGENCY),
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                myImage.sos,
                // height: ScreenUtil().setHeight(400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
