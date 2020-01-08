import 'package:epandu/pages/profile/attendance_record.dart';
import 'package:epandu/pages/profile/payment_history.dart';
import 'package:epandu/pages/profile/profile_page.dart';
import 'package:epandu/pages/profile/registered_course.dart';
import 'package:epandu/services/repo/profile_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import '../../app_localizations.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final profileRepo = ProfileRepo();
  final localStorage = LocalStorage();
  final primaryColor = ColorConstant.primaryColor;
  var tagResult;
  var quoteResult;
  int count = 0;

  var enrollmentResponse;
  var enrollmentData;
  // var enrolledClassResponse;

  var paymentResponse;
  var paymentData;

  var attendanceResponse;
  var attendanceData;

  String enrollmentMessage = '';
  String paymentMessage = '';
  String attendanceMessage = '';

  @override
  void initState() {
    super.initState();

    _getEnrollmentData();
    _getPaymentData();
    _getAttendanceData();
  }

  _getEnrollmentData() async {
    if (enrollmentData == null) {
      enrollmentResponse = await profileRepo.getStudentEnrollmentData();

      if (enrollmentResponse.isSuccess) {
        setState(() {
          enrollmentData = enrollmentResponse;
          enrollmentMessage = '';
        });
      } else {
        setState(() {
          enrollmentData = null;
          enrollmentMessage =
              AppLocalizations.of(context).translate('no_enrollment_desc');
        });
      }
    }
    // enrolledClassResponse = await profileRepo.getEnrolledClasses();
  }

  _getPaymentData() async {
    if (paymentData == null) {
      paymentResponse = await profileRepo.getStudentPayment();

      if (paymentResponse.isSuccess) {
        setState(() {
          paymentData = paymentResponse;
          paymentMessage = '';
        });
      } else {
        setState(() {
          paymentData = null;
          paymentMessage =
              AppLocalizations.of(context).translate('no_payment_desc');
        });
      }
    }
  }

  _getAttendanceData() async {
    if (attendanceData == null) {
      attendanceResponse = await profileRepo.getStudentAttendance();

      if (attendanceResponse.isSuccess) {
        setState(() {
          attendanceData = attendanceResponse;
          attendanceMessage = '';
        });
      } else {
        setState(() {
          attendanceData = null;
          attendanceMessage =
              AppLocalizations.of(context).translate('no_attendance_desc');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.amber.shade300, primaryColor],
            stops: [0.5, 1],
            radius: 0.9,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: TabBarView(children: [
            Profile(),
            RegisteredCourse(
              response: enrollmentData,
              message: enrollmentMessage,
            ),
            PaymentHistory(
              response: paymentData,
              message: paymentMessage,
            ),
            AttendanceRecord(
              response: attendanceData,
              message: attendanceMessage,
            )
          ]),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0, 10.0),
                  blurRadius: 15.0,
                  spreadRadius: 5.0,
                ),
              ],
            ),
            padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
            child: TabBar(
              indicatorColor: Colors.transparent,
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey.shade700,
              tabs: [
                Tab(
                  icon: new Icon(
                    Icons.account_circle,
                    size: 28.0,
                  ),
                ),
                Tab(
                  icon: new Icon(
                    Icons.library_books,
                    size: 28.0,
                  ),
                ),
                Tab(
                  icon: new Icon(
                    Icons.account_balance_wallet,
                    size: 28.0,
                  ),
                ),
                Tab(
                  icon: new Icon(
                    Icons.check_circle,
                    size: 28.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
