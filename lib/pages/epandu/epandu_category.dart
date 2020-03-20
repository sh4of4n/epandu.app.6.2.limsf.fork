import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class EpanduCategory extends StatelessWidget {
  final authRepo = AuthRepo();
  final image = ImagesConstant();
  final localStorage = LocalStorage();
  final primaryColor = ColorConstant.primaryColor;
  final iconText = TextStyle(
    fontSize: ScreenUtil().setSp(60),
    color: Colors.black,
  );
  final myImage = ImagesConstant();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Color(0xffffd225),
          ],
          stops: [0.85, 1.2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: FadeInImage(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(110),
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
              /* FadeInImage(
                alignment: Alignment.center,
                height: ScreenUtil().setHeight(190),
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(
                  myImage.logo2,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(40),
              ), */
              FadeInImage(
                alignment: Alignment.center,
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(
                  myImage.tyreShop,
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
                              Navigator.pushNamed(context, SELECT_INSTITUTE),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(350),
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.enrollIcon,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('enroll_lbl'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(350),
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.importantInfoIcon,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('important_info_lbl'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, KPP),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(350),
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.kppIcon,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('kpp01_lbl'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(350),
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.jobIcon,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('job_lbl'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(350),
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.bookingIcon,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('booking_lbl'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(350),
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.faqIcon,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('faq_lbl'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, REGISTERED_COURSE),
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
                                AppLocalizations.of(context)
                                    .translate('class_title'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, PAYMENT_HISTORY),
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
                                AppLocalizations.of(context)
                                    .translate('payment_lbl'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, ATTENDANCE_RECORD),
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
                                AppLocalizations.of(context)
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
