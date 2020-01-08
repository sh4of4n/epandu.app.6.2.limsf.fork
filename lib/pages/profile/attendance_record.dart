import 'package:epandu/pages/profile/profile_loading.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../app_localizations.dart';

class AttendanceRecord extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;
  final response;
  final String message;

  AttendanceRecord({this.response, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: _renderAttendanceList(),
    );
  }

  _renderAttendanceList() {
    if (response == null && message.isEmpty) {
      return SpinKitFoldingCube(
        color: primaryColor,
      );
    } else if (response == null && message.isNotEmpty) {
      return ProfileLoading(message);
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: response.data.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              'Date ${response.data[index].testDate}',
            ),
            subtitle: Text('Type ${response.data[index].testType}'),
          );
        },
      ),
    );
  }
}
