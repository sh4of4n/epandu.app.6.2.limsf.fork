import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_localizations.dart';

class HomeMenuButtons extends StatelessWidget {
  final image = ImagesConstant();
  final textStyle = TextStyle(
    fontSize: ScreenUtil().setSp(60),
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(50),
        vertical: ScreenUtil().setHeight(40),
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: () => Navigator.pushNamed(context, EMERGENCY),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        image.iconEmergency,
                        width: ScreenUtil.getInstance().setWidth(250),
                      ),
                      Text(
                          AppLocalizations.of(context)
                              .translate('emergency_lbl'),
                          style: textStyle),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, KPP),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        image.iconCampus,
                        width: ScreenUtil.getInstance().setWidth(250),
                      ),
                      Text(AppLocalizations.of(context).translate('kpp_lbl'),
                          style: textStyle),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, PAYMENT),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        image.iconProgramme,
                        width: ScreenUtil.getInstance().setWidth(250),
                      ),
                      Text(
                          AppLocalizations.of(context).translate('payment_lbl'),
                          style: textStyle),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: () => Navigator.pushNamed(context, INVITE),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        image.iconProgramme,
                        width: ScreenUtil.getInstance().setWidth(250),
                      ),
                      Text(
                          AppLocalizations.of(context)
                              .translate('invite_friends_lbl'),
                          style: textStyle),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, SELECT_INSTITUTE),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        image.iconAbout,
                        width: ScreenUtil.getInstance().setWidth(250),
                      ),
                      Text(AppLocalizations.of(context).translate('enroll_lbl'),
                          style: textStyle),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, PROFILE),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        image.iconAbout,
                        width: ScreenUtil.getInstance().setWidth(250),
                      ),
                      Text(
                          AppLocalizations.of(context)
                              .translate('profile_title'),
                          style: textStyle),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
