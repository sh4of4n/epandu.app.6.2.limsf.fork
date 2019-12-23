import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterType extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.shade600,
            Colors.amber.shade300,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  ImagesConstant().logo,
                  width: ScreenUtil.getInstance().setWidth(1000),
                  height: ScreenUtil.getInstance().setHeight(600),
                ),
              ],
            ),
            Text('Register as',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w800)),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, SIGN_UP,
                            arguments: 'NORMAL');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange.shade900,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(1.0, 2.0),
                              blurRadius: 5.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        width: ScreenUtil().setWidth(550),
                        height: ScreenUtil().setHeight(600),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.account_circle,
                              size: 80,
                              color: Colors.white,
                            ),
                            Text(
                              'Normal user',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(56),
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, SIGN_UP,
                            arguments: 'STUDENT');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(1.0, 2.0),
                              blurRadius: 5.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        width: ScreenUtil().setWidth(550),
                        height: ScreenUtil().setHeight(600),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.location_city,
                              size: 80,
                              color: Colors.white,
                            ),
                            Text(
                              'Institute student',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(56),
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
