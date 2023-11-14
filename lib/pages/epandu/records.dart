import 'package:auto_route/auto_route.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';
import '../../router.gr.dart';

@RoutePage(name: 'Records')
class Records extends StatelessWidget {
  final iconText = TextStyle(
    fontSize: ScreenUtil().setSp(60),
    color: Colors.black,
  );
  final myImage = ImagesConstant();

  Records({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Color(0xffffd225),
          ],
          stops: [0.50, 1.2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: FadeInImage(
            alignment: Alignment.center,
            height: 110.h,
            placeholder: MemoryImage(kTransparentImage),
            image: AssetImage(
              myImage.logo2,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FadeInImage(
                alignment: Alignment.center,
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(
                  myImage.advertBanner,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(60),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(60)),
                child: Table(
                  // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  // border: TableBorder.all(),
                  children: [
                    TableRow(
                      children: [
                        InkWell(
                          onTap: () =>
                              context.router.push(const RegisteredCourse()),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(350),
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.classIcon,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('class_title'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => context.router.push(const PaymentList()),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(350),
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.paymentIcon,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('payment_lbl'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              context.router.push(const AttendanceTab()),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(350),
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.attendanceIcon,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('attendance_title'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
