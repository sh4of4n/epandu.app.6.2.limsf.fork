import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'form.dart';

class ForgotPassword extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.amber.shade50,
              Colors.amber.shade100,
              Colors.amber.shade200,
              Colors.amber.shade300,
              primaryColor
            ],
            stops: [0.2, 0.4, 0.6, 0.7, 1],
            radius: 0.7,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Image.asset(
                        ImagesConstant().logo,
                        width: ScreenUtil().setWidth(1000),
                        height: ScreenUtil().setHeight(600),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 40.0, right: 40.0, top: 60.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil().setHeight(510),
                        ),
                        ForgotPasswordForm(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
