import 'package:epandu/pages/register/register_form.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Register extends StatefulWidget {
  final String argument;

  Register(this.argument);

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
                            Colors.amber.shade400,
                            Colors.amber.shade600,
                          ],
                          stops: [0.7, 1],
                          radius: 0.7,
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
                            ImagesConstant().logo,
                            width: ScreenUtil.getInstance().setWidth(1000),
                            height: ScreenUtil.getInstance().setHeight(600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              RegisterForm(widget.argument),
            ],
          ),
        ),
      ),
    );
  }
}
