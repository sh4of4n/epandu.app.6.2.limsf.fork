import 'package:epandu/pages/profile/profile_loading.dart';
import 'package:epandu/services/repository/epandu_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../../app_localizations.dart';

class RegisteredCourse extends StatefulWidget {
  @override
  _RegisteredCourseState createState() => _RegisteredCourseState();
}

class _RegisteredCourseState extends State<RegisteredCourse> {
  final primaryColor = ColorConstant.primaryColor;

  final TextStyle _titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  final TextStyle _subtitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade700,
  );

  final epanduRepo = EpanduRepo();
  Future _getData;

  @override
  void initState() {
    super.initState();

    _getData = _getdata();
  }

  _getdata() async {
    var response = await epanduRepo.getEnrollByCode(context: context);

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
        gradient: RadialGradient(
          colors: [Colors.amber.shade300, primaryColor],
          stops: [0.5, 1],
          radius: 0.9,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context).translate('class_title')),
        ),
        body: Container(
          height: ScreenUtil().setHeight(1800),
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(100.0),
              horizontal: ScreenUtil().setWidth(35.0)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 8.0),
                blurRadius: 10.0,
              )
            ],
          ),
          child: FutureBuilder(
            future: _getData,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return SpinKitFoldingCube(
                    color: primaryColor,
                  );
                case ConnectionState.done:
                  if (snapshot.data is String) {
                    return ProfileLoading(snapshot.data);
                  }
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          '${AppLocalizations.of(context).translate('class_lbl')}  ',
                                      style: _titleStyle,
                                    ),
                                    TextSpan(
                                      text: snapshot.data[index].groupId,
                                      style: _subtitleStyle,
                                    ),
                                  ],
                                ),
                              ),
                              /* RichText(
                  text: TextSpan(
                    style: GoogleFonts.dosis(
                      textStyle: TextStyle(color: Colors.black),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              '${AppLocalizations.of(context).translate('stu_no_lbl')}  ',
                          style: _titleStyle),
                      TextSpan(
                          text: response.data[index].stuNo,
                          style: _subtitleStyle),
                    ],
                  ),
                ), */
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '${AppLocalizations.of(context).translate('fees_lbl')}  ',
                                        style: _titleStyle),
                                    TextSpan(
                                        text: snapshot.data[index].feesAgree,
                                        style: _subtitleStyle),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                default:
                  return Center(
                    child: Text(snapshot.data),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
