import 'package:epandu/custom_icon/my_custom_icons_icons.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_localizations.dart';

class BottomMenu extends StatelessWidget {
  final myImage = ImagesConstant();
  final primaryColor = ColorConstant.primaryColor;
  final iconText = TextStyle(
    fontSize: ScreenUtil().setSp(55),
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      color: Colors.transparent,
      // color: primaryColor,
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
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        /* Icon(
                          MyCustomIcons.v_club_icon,
                          size: 22,
                          color: Color(0xff808080),
                        ), */
                        Image.asset(
                          myImage.vClub,
                          height: 22,
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        Text(
                            AppLocalizations.of(context)
                                .translate('v_club_lbl'),
                            style: iconText),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Image.asset(myImage.promotionsIcon, height: 22),
                        SizedBox(height: 20.h),
                        Text(
                          AppLocalizations.of(context)
                              .translate('promotions_lbl'),
                          style: iconText,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          MyCustomIcons.gift_icon,
                          size: 22,
                          color: Color(0xff808080),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        Text(
                            AppLocalizations.of(context)
                                .translate('rewards_lbl'),
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
    );
  }
}
