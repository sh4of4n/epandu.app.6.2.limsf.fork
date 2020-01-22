import 'package:epandu/app_localizations.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AirtimeBillDetail extends StatelessWidget {
  final data;
  final primaryColor = ColorConstant.primaryColor;

  AirtimeBillDetail(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text(AppLocalizations.of(context).translate('airtime_lbl'))),
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
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Enter number to top-up'),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),
                    labelText: AppLocalizations.of(context)
                        .translate('country_code_lbl'),
                    fillColor: Colors.grey.withOpacity(.25),
                    filled: true,
                    prefixIcon: Icon(Icons.account_circle),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  enabled: false,
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),
                    labelText:
                        AppLocalizations.of(context).translate('phone_lbl'),
                    fillColor: Colors.grey.withOpacity(.25),
                    filled: true,
                    prefixIcon: Icon(Icons.account_circle),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Text('Select a top-up amount'),
                FlatButton(
                  onPressed: () {},
                  child: Text('RM5.00'),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text('RM10.00'),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text('RM15.00'),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text('RM30.00'),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text('RM50.00'),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text('RM60.00'),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text('RM100.00'),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text('Custom'),
                ),
                Text('Total: '),
                RaisedButton(onPressed: () {}, child: Text('Next')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
