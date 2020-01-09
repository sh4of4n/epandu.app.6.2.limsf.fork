import 'package:epandu/app_localizations.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'sos_button.dart';

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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(120)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Text(
                AppLocalizations.of(context).translate('having_emergency_desc'),
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(70),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(120),
              ),
              Center(
                child: SosButton(onTap: _sendSos),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _sendSos() {
    // print('Send SOS');
  }
}
