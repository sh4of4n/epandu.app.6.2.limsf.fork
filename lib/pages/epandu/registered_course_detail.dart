import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';

class RegisteredCourseDetail extends StatefulWidget {
  final groupId;

  RegisteredCourseDetail(this.groupId);

  @override
  _RegisteredCourseDetailState createState() => _RegisteredCourseDetailState();
}

class _RegisteredCourseDetailState extends State<RegisteredCourseDetail> {
  final authRepo = AuthRepo();
  var _enrollHistoryData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _getEnrollHistory();
  }

  Future<dynamic> _getEnrollHistory() async {
    var result = await authRepo.getEnrollHistory(
      groupId: widget.groupId,
    );

    if (result.isSuccess) {
      setState(() {
        _enrollHistoryData = result.data;
      });
    } else {
      setState(() {
        _enrollHistoryData = result.message;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  _loadHistoryData() {
    if (_isLoading && _enrollHistoryData == null)
      return Column(
        children: <Widget>[
          Expanded(
            child: SpinKitFoldingCube(
              color: Colors.blue,
            ),
          ),
        ],
      );
    else if (!_isLoading && _enrollHistoryData is String)
      return Column(
        children: <Widget>[
          Expanded(
            child: Text(
              _enrollHistoryData,
            ),
          ),
        ],
      );

    return SingleChildScrollView(
      child: Container(
        width: ScreenUtil().screenWidth,
        padding: EdgeInsets.symmetric(horizontal: 80.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100.h),
            Text(
              AppLocalizations.of(context).translate('you_have_enrolled_desc'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 80.sp,
              ),
            ),
            SizedBox(height: 100.h),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20.h, 40.w, 20.h),
              child: Table(
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          _enrollHistoryData[0].icNo != null
                              ? 'IC: ' + _enrollHistoryData[0].icNo
                              : '',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          _enrollHistoryData[0].groupId != null
                              ? 'Class ' + _enrollHistoryData[0].groupId
                              : '',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          _enrollHistoryData[0].stuNo != null
                              ? 'Student no: ' + _enrollHistoryData[0].stuNo
                              : '',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          _enrollHistoryData[0].status != null
                              ? 'Status: ' + _enrollHistoryData[0].status
                              : '',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          _enrollHistoryData[0].tlHrsTak != null
                              ? 'Hours taken: ' + _enrollHistoryData[0].tlHrsTak
                              : '0',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          _enrollHistoryData[0].totalTime != null
                              ? 'Total time: ' + _enrollHistoryData[0].totalTime
                              : '00:00',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          _enrollHistoryData[0].totalPaid != null
                              ? 'Total paid: RM' +
                                  NumberFormat('#,##0.00').format(
                                      double.tryParse(
                                          _enrollHistoryData[0].totalPaid))
                              : '0.00',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          _enrollHistoryData[0].fee != null
                              ? 'Fee: RM' +
                                  NumberFormat('#,##0.00').format(
                                      double.tryParse(
                                          _enrollHistoryData[0].fee))
                              : '0.00',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            Center(
              child: ButtonTheme(
                padding: EdgeInsets.all(0.0),
                shape: StadiumBorder(),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffdd0e0e),
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => context.router.pop(),
                  child: Text(
                    AppLocalizations.of(context).translate('back_btn'),
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(60),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffdc013),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context).translate('registered_class_lbl'),
        ),
      ),
      body: _loadHistoryData(),
    );
  }
}
