import 'package:epandu/app_localizations.dart';
import 'package:epandu/pages/emergency/authorities_button.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Emergency extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.amber.shade300, primaryColor],
          stops: [0.5, 1],
          radius: 0.9,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context).translate('emergency_lbl')),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: ScreenUtil().setHeight(70),
              ),
              Text(
                  AppLocalizations.of(context)
                      .translate('having_emergency_lbl'),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(90),
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  )),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Container(
                width: ScreenUtil().setWidth(1200),
                child: Text(
                  AppLocalizations.of(context).translate('authorities_desc'),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(70),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(120),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  AuthoritiesButton(
                    tileFirstColor: Color(0xff08457e),
                    tileSecondColor: Color(0xff0499c7),
                    label: AppLocalizations.of(context).translate('police_lbl'),
                    onTap: () {},
                  ),
                  AuthoritiesButton(
                    tileFirstColor: Color(0xffc90000),
                    tileSecondColor: Color(0xffd43b3b),
                    label:
                        AppLocalizations.of(context).translate('ambulance_lbl'),
                    onTap: () {},
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
