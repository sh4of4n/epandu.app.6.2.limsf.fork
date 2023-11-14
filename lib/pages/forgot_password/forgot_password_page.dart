import 'package:auto_route/auto_route.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'form.dart';
import 'tablet_form.dart';

@RoutePage(name: 'ForgotPassword')
class ForgotPassword extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;

  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) {
          return defaultLayout(context);
        }
        return tabLayout(context);
      },
    );
  }

  defaultLayout(context) {
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
            stops: const [0.2, 0.4, 0.6, 0.7, 1],
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
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Image.asset(
                        ImagesConstant().logo,
                        width: 1000.w,
                        height: 600.h,
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 180.w, right: 180.w, top: 230.h),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 510.h,
                        ),
                        const ForgotPasswordForm(),
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

  tabLayout(context) {
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
            stops: const [0.2, 0.4, 0.6, 0.7, 1],
            radius: 0.7,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 220.w, right: 220.w, top: 250.0.h, bottom: 100.h),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      ImagesConstant().logo,
                      width: 1000.w,
                      height: 600.h,
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    const ForgotPasswordTabletForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
