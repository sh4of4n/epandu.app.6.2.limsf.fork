import 'package:epandu/pages/profile/profile_loading.dart';
import 'package:epandu/services/repository/profile_repository.dart';
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

  final profileRepo = ProfileRepo();
  var response;
  var data;
  String _message = '';

  @override
  void initState() {
    super.initState();

    _getdata();
  }

  _getdata() async {
    if (data == null) {
      response = await profileRepo.getEnrollByCode(context: context);

      if (response.isSuccess) {
        if (mounted) {
          setState(() {
            data = response;
            _message = '';
          });
        }
      } else {
        if (mounted) {
          setState(() {
            data = null;
            _message =
                AppLocalizations.of(context).translate('no_enrollment_desc');
          });
        }
      }
    }
    // enrolledClassResponse = await profileRepo.getEnrolledClasses();
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
          child: _renderEnrolledClass(),
        ),
      ),
    );
  }

  _renderEnrolledClass() {
    if (response == null && _message.isEmpty) {
      return SpinKitFoldingCube(
        color: primaryColor,
      );
    } else if (response == null && _message.isNotEmpty) {
      return ProfileLoading(_message);
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: response.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
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
                        text: response.data[index].groupId,
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
                          text: response.data[index].feesAgree,
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
  }
}
