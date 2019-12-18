import 'package:epandu/pages/profile/attendance_record.dart';
import 'package:epandu/pages/profile/payment_history.dart';
import 'package:epandu/pages/profile/profile_page.dart';
import 'package:epandu/pages/profile/registered_course.dart';
import 'package:epandu/services/repo/profile_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';

// import 'package:epandu/utils/route_path.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final profileRepo = ProfileRepo();
  final primaryColor = ColorConstant.primaryColor;
  var tagResult;
  var quoteResult;
  int count = 0;

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
            RegisteredCourse(),
            PaymentHistory(),
            AttendanceRecord(),
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
