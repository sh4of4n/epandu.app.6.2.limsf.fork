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

  final TextStyle _titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade700,
  );

  final TextStyle _subtitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade600,
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
          title:
              Text(AppLocalizations.of(context).translate('attendance_title')),
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
                          return ListTile(
                            title: Text(
                              'Date ${snapshot.data[index].testDate.substring(0, 10)}',
                              style: _titleStyle,
                            ),
                            subtitle: Text(
                              'Type ${snapshot.data[index].testType}',
                              style: _subtitleStyle,
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
              }),
        ),
      ),
    );
  }
}
