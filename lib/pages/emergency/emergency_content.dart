import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_localizations.dart';
import 'sos_button.dart';

class EmergencyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(120)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: ScreenUtil().setHeight(70),
          ),
          Text(AppLocalizations.of(context).translate('having_emergency_lbl'),
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
    );
  }

  _sendSos() {
    // print('Send SOS');
  }
}
