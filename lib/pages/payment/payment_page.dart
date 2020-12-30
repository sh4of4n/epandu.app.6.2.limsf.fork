import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_localizations.dart';
import '../../router.gr.dart';

class PaymentPage extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('payment_lbl')),
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              height: ScreenUtil().setHeight(1000),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: Offset(0, 8),
                    spreadRadius: 2,
                    color: Colors.black26,
                  ),
                ]),
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  onTap: () => ExtendedNavigator.of(context)
                      .push(Routes.airtimeSelection),
                  leading: Icon(Icons.attach_money),
                  title: Text(
                      AppLocalizations.of(context).translate('airtime_lbl')),
                ),
                ListTile(
                  onTap: () =>
                      ExtendedNavigator.of(context).push(Routes.billSelection),
                  leading: Icon(Icons.attach_money),
                  title:
                      Text(AppLocalizations.of(context).translate('bill_lbl')),
                ),
                // ListTile(
                //   onTap: () {},
                //   title: Text('Top-up'),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
