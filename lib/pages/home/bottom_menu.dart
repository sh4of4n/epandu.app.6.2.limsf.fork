import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class BottomMenu extends StatelessWidget {
  final iconText;
  final positionStream;

  BottomMenu({this.iconText, this.positionStream});

  final myImage = ImagesConstant();
  final primaryColor = ColorConstant.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      color: Colors.white,
      child: Table(
        children: [
          TableRow(
            children: [
              /* Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12.0,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 160.h,
                      width: 80.w,
                    ),
                  ],
                ),
              ), */
              /* InkWell(
                onTap: () =>
                    Navigator.popUntil(context, ModalRoute.withName(HOME)),
                borderRadius: BorderRadius.circular(10.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        MyCustomIcons.home_icon,
                        size: 18,
                        color: Color(0xff808080),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Text(AppLocalizations.of(context).translate('home_lbl'),
                          style: iconText),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, VALUE_CLUB),
                borderRadius: BorderRadius.circular(10.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      /* Icon(
                                  MyCustomIcons.v_club_icon,
                                  size: 18,
                                  color: Color(0xff808080),
                                ), */
                      Image.asset(
                        myImage.vClub,
                        height: 18,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Text(AppLocalizations.of(context).translate('v_club_lbl'),
                          style: iconText),
                    ],
                  ),
                ),
              ), */
              Column(
                children: <Widget>[
                  Image.memory(
                    kTransparentImage,
                  ),
                ],
              ),
              /* InkWell(
                onTap: () => Navigator.pushNamed(context, INVITE),
                borderRadius: BorderRadius.circular(10.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        MyCustomIcons.invite_icon,
                        size: 18,
                        color: Color(0xff808080),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Text(
                        AppLocalizations.of(context).translate('invite_lbl'),
                        style: iconText,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                // onTap: () => Navigator.pushNamed(context, MENU,
                //     arguments: positionStream),
                onTap: () {},
                borderRadius: BorderRadius.circular(10.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      /* Icon(
                                  MyCustomIcons.menu_icon,
                                  size: 18,
                                  color: Color(0xff808080),
                                ), */
                      Image.asset(
                        myImage.menu,
                        height: 18,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Text(AppLocalizations.of(context).translate('menu_lbl'),
                          style: iconText),
                    ],
                  ),
                ),
              ), */
            ],
          ),
        ],
      ),
    );
  }
}

/* @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(200),
      color: primaryColor,
      child: Stack(
        children: <Widget>[
          /*Align(
            alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: ScreenUtil().setHeight(400),
                color: Colors.transparent,

              ),
            ),*/
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 160.h,
                              width: 80.w,
                            ),
                          ],
                        ),
                      ),
                      /* InkWell(
                        onTap: () => Navigator.popUntil(
                            context, ModalRoute.withName(HOME)),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                MyCustomIcons.home_icon,
                                size: 18,
                                color: Color(0xff808080),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(20)),
                              Text(
                                  AppLocalizations.of(context)
                                      .translate('home_lbl'),
                                  style: iconText),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, VALUE_CLUB),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              /* Icon(
                                MyCustomIcons.v_club_icon,
                                size: 18,
                                color: Color(0xff808080),
                              ), */
                              Image.asset(
                                myImage.vClub,
                                height: 18,
                              ),
                              SizedBox(height: ScreenUtil().setHeight(20)),
                              Text(
                                  AppLocalizations.of(context)
                                      .translate('v_club_lbl'),
                                  style: iconText),
                            ],
                          ),
                        ),
                      ), */
                      /*Column(
                        children: <Widget>[
                          Image.memory(kTransparentImage,
                              ),
                        ],
                      ),*/
                      /* InkWell(
                        onTap: () => Navigator.pushNamed(context, INVITE),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                MyCustomIcons.invite_icon,
                                size: 18,
                                color: Color(0xff808080),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(20)),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('invite_lbl'),
                                style: iconText,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        // onTap: () => Navigator.pushNamed(context, MENU,
                        //     arguments: positionStream),
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              /* Icon(
                                MyCustomIcons.menu_icon,
                                size: 18,
                                color: Color(0xff808080),
                              ), */
                              Image.asset(
                                myImage.menu,
                                height: 18,
                              ),
                              SizedBox(height: ScreenUtil().setHeight(20)),
                              Text(
                                  AppLocalizations.of(context)
                                      .translate('menu_lbl'),
                                  style: iconText),
                            ],
                          ),
                        ),
                      ), */
                    ],
                  ),
                ],
              ),
            ),
          ),
          /*Align(
            alignment: Alignment.center,

            child: InkWell(

              onTap: () => Navigator.pushNamed(context, EMERGENCY_DIRECTORY),
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                myImage.sos,
                // width: ScreenUtil().setWidth(300),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
} */

/*
class NavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
     var sw = size.width;
    var sh = size.height;

    path.cubicTo(sw / 12, 0, sw / 12, 2 * sh / 5, 2 * sw / 12, 2 * sh / 5);
    path.cubicTo(3 * sw / 12, 2 * sh / 5, 3 * sw / 12, 0, 4 * sw / 12, 0);
    path.cubicTo(
        5 * sw / 12, 0, 5 * sw / 12, 2 * sh / 5, 6 * sw / 12, 2 * sh / 5);
    path.cubicTo(7 * sw / 12, 2 * sh / 5, 7 * sw / 12, 0, 8 * sw / 12, 0);
    path.cubicTo(
        9 * sw / 12, 0, 9 * sw / 12, 2 * sh / 5, 10 * sw / 12, 2 * sh / 5);
    path.cubicTo(11 * sw / 12, 2 * sh / 5, 11 * sw / 12, 0, sw, 0);
    path.lineTo(sw, sh);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
*/
