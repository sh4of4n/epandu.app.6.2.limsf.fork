import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';
import 'sos_button.dart';

class EmergencyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(120)),
      child: Column(
        children: <Widget>[
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
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(70),
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
