import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class CheckInRecord extends StatefulWidget {
  final checkInData;
  final bool isLoading;

  const CheckInRecord(
      {super.key, required this.checkInData, required this.isLoading});

  @override
  State<CheckInRecord> createState() => _CheckInRecordState();
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
    color: const Color(
      0xff666666,
    ),
  );

  final epanduRepo = EpanduRepo();

  checkInList() {
    if (widget.checkInData != null && !widget.isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
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
        AppLocalizations.of(context)!.translate('no_records_found'),
      ),
    );
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
          stops: const [0.45, 0.95],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: checkInList(),
    );
  }
}
