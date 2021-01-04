import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:epandu/common_library/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';
import '../../router.gr.dart';

class RegisteredCourse extends StatefulWidget {
  @override
  _RegisteredCourseState createState() => _RegisteredCourseState();
}

class _RegisteredCourseState extends State<RegisteredCourse> {
  final primaryColor = ColorConstant.primaryColor;

  /* final TextStyle _titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  final TextStyle _subtitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade700,
  ); */

  final epanduRepo = EpanduRepo();
  final authRepo = AuthRepo();
  Future _getClasses;
  final myImage = ImagesConstant();

  @override
  void initState() {
    super.initState();

    _getClasses = _getdata();
  }

  _getdata() async {
    var response = await authRepo.getEnrollHistory(context: context);

    if (response.isSuccess) {
      return response.data;
    } else {
      return response.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            primaryColor,
          ],
          stops: [0.45, 0.95],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('registered_class_lbl'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 300.h,
                width: double.infinity,
                color: Color(0xff0290b7),
                child: Text(
                  AppLocalizations.of(context).translate('installment_scheme'),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 95.sp,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: FadeInImage(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(200),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage(
                    myImage.visaImage,
                  ),
                ),
              ),
              SizedBox(
                width: 1000.w,
                child: Divider(
                  height: 1.0,
                  color: Color(0xffc73143),
                  thickness: 1.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: FadeInImage(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(200),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage(
                    myImage.banksImage,
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
                child: Divider(
                  height: 1.0,
                  color: Color(0xffaaaaaa),
                  thickness: 1.3,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: Text(
                  AppLocalizations.of(context).translate('class_title'),
                  style: TextStyle(
                    color: Color(0xffdd0e0e),
                    fontSize: 85.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              FutureBuilder(
                future: _getClasses,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: SpinKitFoldingCube(
                          color: primaryColor,
                        ),
                      );
                    case ConnectionState.done:
                      if (snapshot.data is String) {
                        return Center(
                            child: Text(AppLocalizations.of(context)
                                .translate('no_classes_desc')));
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () => ExtendedNavigator.of(context).push(
                              Routes.registeredCourseDetail,
                              arguments: RegisteredCourseDetailArguments(
                                  groupId: snapshot.data[index].groupId),
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.fromLTRB(50.w, 30.w, 50.w, 0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                fontSize: 80.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Myriad',
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'class_lbl') +
                                                      ' ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(
                                                      0xff666666,
                                                    ),
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: snapshot.data[index]
                                                          .groupId ??
                                                      '',
                                                  style: TextStyle(
                                                    color: Color(0xffdd0e0e),
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            'RM' +
                                                    NumberFormat('#,##0.00')
                                                        .format(double.tryParse(
                                                            snapshot.data[index]
                                                                .fee)) ??
                                                '0.00',
                                            style: TextStyle(
                                              color: Color(
                                                0xff666666,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index].totalTime !=
                                                    null
                                                ? AppLocalizations.of(context)
                                                        .translate(
                                                            'total_time') +
                                                    ' ' +
                                                    snapshot
                                                        .data[index].totalTime
                                                : /* AppLocalizations.of(context)
                                                    .translate('no_total_time') */
                                                'Total time 00:00',
                                            style: TextStyle(
                                              color: Color(
                                                0xff666666,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 100.w),
                                        child: Text(
                                          snapshot.data[index].status != null
                                              ? snapshot.data[index].status
                                              : '',
                                          style: TextStyle(
                                            fontSize: 70.sp,
                                            color: Color(
                                              0xff666666,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(30)),
                                    child: Divider(
                                      height: 1.0,
                                      color: Colors.white,
                                      thickness: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    default:
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('get_class_list_fail'),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
