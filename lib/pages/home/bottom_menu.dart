import 'package:epandu/custom_icon/my_custom_icons_icons.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../app_localizations.dart';

class BottomMenu extends StatelessWidget {
  final iconText;
  final positionStream;

  BottomMenu({this.iconText, this.positionStream});

  final myImage = ImagesConstant();
  final primaryColor = ColorConstant.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      color: Colors.transparent,
      // color: primaryColor,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(500),
              color: primaryColor,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
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
                        onTap: () => Navigator.pushNamed(context, PAYMENT),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                MyCustomIcons.v_club_icon,
                                size: 18,
                                color: Color(0xff808080),
                              ),
                              /* Image.asset(
                                myImage.vClub,
                                height: 20,
                              ), */
                              SizedBox(height: ScreenUtil().setHeight(20)),
                              Text(
                                  AppLocalizations.of(context)
                                      .translate('v_club_lbl'),
                                  style: iconText),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Image.memory(kTransparentImage,
                              width: ScreenUtil().setWidth(150)),
                        ],
                      ),
                      InkWell(
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
                        onTap: () => Navigator.pushNamed(context, MENU,
                            arguments: positionStream),
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, EMERGENCY_DIRECTORY),
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                myImage.sos,
                // width: ScreenUtil().setWidth(300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
