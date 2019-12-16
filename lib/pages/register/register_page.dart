import 'package:epandu/pages/register/register_form.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final primaryColor = ColorConstant.primaryColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: WaveClipperTwo(),
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
                          radius: 0.9,
                        ),
                      ),
                      height: ScreenUtil().setHeight(1100),
                    ),
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: Image.asset(
                            'images/ePandu-logo.png',
                            width: ScreenUtil.getInstance().setWidth(1000),
                            height: ScreenUtil.getInstance().setHeight(600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
