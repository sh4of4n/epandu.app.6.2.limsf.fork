import 'package:epandu/pages/profile/profile_loading.dart';
import 'package:epandu/services/repository/epandu_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../app_localizations.dart';

class AttendanceRecord extends StatefulWidget {
  @override
  _AttendanceRecordState createState() => _AttendanceRecordState();
}

class _AttendanceRecordState extends State<AttendanceRecord> {
  final primaryColor = ColorConstant.primaryColor;
  final format = DateFormat("yyyy-MM-dd");

  /* final TextStyle _titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade700,
  ); */

  final TextStyle _subtitleStyle = TextStyle(
    fontSize: 56.sp,
    fontWeight: FontWeight.w400,
    color: Color(
      0xff666666,
    ),
  );

  final epanduRepo = EpanduRepo();
  Future _getData;

  @override
  void initState() {
    super.initState();

    _getData = _getdata();
  }

  _getdata() async {
    var response = await epanduRepo.getDTestByCode(context: context);

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
          elevation: 0,
          backgroundColor: Colors.transparent,
          title:
              Text(AppLocalizations.of(context).translate('attendance_title')),
        ),
        body: Container(
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
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Table(
                                children: [
                                  TableRow(
                                    children: [
                                      Text(
                                        '${snapshot.data[index].testDate.substring(0, 10)}',
                                        style: _subtitleStyle,
                                      ),
                                      Text(
                                        'Test type: ${snapshot.data[index].testType ?? ''}',
                                        style: _subtitleStyle,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: Text(
                                          '${snapshot.data[index].bookNo ?? ''}',
                                          style: _subtitleStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: Text(
                                          'Status: ${snapshot.data[index].apprvBooking ?? ''}',
                                          style: _subtitleStyle,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Container(),
                                      Text(
                                        'Time: ${snapshot.data[index].time ?? '00:00'}',
                                        style: _subtitleStyle,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 40.h),
                                child: Divider(
                                  height: 1.0,
                                  thickness: 1.0,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  default:
                    return Center(
                      child: Text(snapshot.data),
                    );
                }
              }),
        ),
      ),
    );
  }
}
