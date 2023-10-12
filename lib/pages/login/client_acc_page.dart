import 'package:auto_route/auto_route.dart';
import 'package:epandu/pages/login/client_acc_tablet_form.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'client_acc_form.dart';

@RoutePage(name: 'ClientAccount')
class ClientAccount extends StatefulWidget {
  final data;

  const ClientAccount({super.key, this.data});

  @override
  State<ClientAccount> createState() => _ClientAccountState();
}

class _ClientAccountState extends State<ClientAccount> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final primaryColor = ColorConstant.primaryColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) return defaultLayout();
        return tabLayout();
      },
    );
  }

  defaultLayout() {
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
                      padding: EdgeInsets.only(top: 60.h),
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
                    padding: EdgeInsets.only(
                        left: 120.w, right: 120.w, top: 180.0.h),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 510.h,
                        ),
                        ClientAccountForm(widget.data),
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

  tabLayout() {
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
                      height: 600.h,
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    ClientAccountTabletForm(widget.data),
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
