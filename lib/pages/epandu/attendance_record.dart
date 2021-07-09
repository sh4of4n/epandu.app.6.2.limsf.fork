import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class AttendanceRecord extends StatefulWidget {
  final attendanceData;
  final bool? isLoading;

  AttendanceRecord({required this.attendanceData, required this.isLoading});

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

  attendanceList() {
    if (widget.attendanceData != null && !widget.isLoading!) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.attendanceData.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Table(
                  children: [
                    TableRow(
                      children: [
                        Text(
                          '${widget.attendanceData[index].transtamp.substring(0, 10)}',
                          style: _subtitleStyle,
                        ),
                        Text(
                          '${widget.attendanceData[index].groupId ?? ''}',
                          style: _subtitleStyle,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            '${widget.attendanceData[index].vehNo ?? ''}',
                            style: _subtitleStyle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            'Cert: ${widget.attendanceData[index].certNo ?? ''}',
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
                          'Begin Time: ${widget.attendanceData[index].bgTime ?? '00:00'}',
                          style: _subtitleStyle,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(),
                        Text(
                          'End Time: ${widget.attendanceData[index].endTime ?? '00:00'}',
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
    } else if (widget.isLoading!) {
      return Center(
        child: SpinKitChasingDots(
          color: primaryColor,
        ),
      );
    }
    return Center(
      child: Text(
        AppLocalizations.of(context)!.translate('no_records_found'),
      ),
    );
  }
/* 
  attendanceList() {
    if (widget.attendanceData != null && !widget.isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.attendanceData.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Table(
                  children: [
                    TableRow(
                      children: [
                        Text(
                          '${widget.attendanceData[index].testDate.substring(0, 10)}',
                          style: _subtitleStyle,
                        ),
                        Text(
                          'Test type: ${widget.attendanceData[index].testType ?? ''}',
                          style: _subtitleStyle,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            '${widget.attendanceData[index].bookNo ?? ''}',
                            style: _subtitleStyle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            'Status: ${widget.attendanceData[index].apprvBooking ?? ''}',
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
                          'Time: ${widget.attendanceData[index].time ?? '00:00'}',
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
    } else if (widget.isLoading) {
      return Center(
        child: SpinKitChasingDots(
          color: primaryColor,
        ),
      );
    }
    return Center(
      child: Text(
        AppLocalizations.of(context).translate('no_records_found'),
      ),
    );
  } */

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
      child: attendanceList(),
    );
  }
}
