import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CheckInRecord extends StatefulWidget {
  final checkInData;

  CheckInRecord({@required this.checkInData});

  @override
  _CheckInRecordState createState() => _CheckInRecordState();
}

class _CheckInRecordState extends State<CheckInRecord> {
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.checkInData.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Table(
                  children: [
                    TableRow(
                      children: [
                        Text(
                          'Date',
                          style: _subtitleStyle,
                        ),
                        Text(
                          widget.checkInData[index].regDate.substring(0, 10) ??
                              '',
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
                            'Queue No',
                            style: _subtitleStyle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            widget.checkInData[index].queueNo ?? '',
                            style: _subtitleStyle,
                            textAlign: TextAlign.right,
                          ),
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
      ),
    );
  }
}
