import 'package:auto_route/auto_route.dart';
import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../router.gr.dart';

// import 'bottom_menu.dart';

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
          stops: [0.60, 0.8],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
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
        // bottomNavigationBar: BottomMenu(),
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
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: Table(
                  // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  // border: TableBorder.all(),
                  children: [
                    TableRow(
                      children: [
                        InkWell(
                          onTap: () => ExtendedNavigator.of(context)
                              .push(Routes.comingSoon),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: 330.h,
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.infoIcon,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                AppLocalizations.of(context).translate('info'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => ExtendedNavigator.of(context)
                              .push(Routes.enrollment),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: 330.h,
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.enrollIcon,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
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
                          onTap: () => ExtendedNavigator.of(context)
                              .push(Routes.booking),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: 330.h,
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.bookingIcon,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
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
                      ],
                    ),
                    TableRow(
                      children: [
                        InkWell(
                          onTap: () => ExtendedNavigator.of(context)
                              .push(Routes.kppCategory),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: 330.h,
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.classIcon,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('elearning'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => ExtendedNavigator.of(context)
                              .push(Routes.records),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: 330.h,
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.attendanceIcon,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('records'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              // Navigator.push(context, PICKUP_HISTORY),
                              ExtendedNavigator.of(context)
                                  .push(Routes.comingSoon),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: 330.h,
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.pickupIcon,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('pickup'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        /* InkWell(
                          onTap: () {},
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: 330.h,
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.driverJob,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('driver_jobs'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ), */
                      ],
                    ),
                    TableRow(
                      children: [
                        InkWell(
                          onTap: () => ExtendedNavigator.of(context)
                              .push(Routes.comingSoon),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: 330.h,
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.pickupIcon,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('pickup'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => ExtendedNavigator.of(context)
                              .push(Routes.comingSoon),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: 330.h,
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.webinarIcon,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('webinar'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => ExtendedNavigator.of(context)
                              .push(Routes.chatHomeScreen),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: 330.h,
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.chatIcon,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                AppLocalizations.of(context).translate('chat'),
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
