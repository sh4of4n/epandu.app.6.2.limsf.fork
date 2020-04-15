import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_localizations.dart';

class Pay extends StatelessWidget {
  final image = ImagesConstant();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Color(0xffffd225),
          ],
          stops: [0.75, 1.2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('pay_lbl')),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: ScreenUtil.screenWidthDp,
          height: ScreenUtil.screenHeightDp,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                image.comingSoon,
                height: 600.h,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 80.h),
                width: 1300.w,
                child: Text(
                  AppLocalizations.of(context).translate('coming_soon_msg'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
