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
  final api = ProfileRepo();
  final primaryColor = ColorConstant.primaryColor;
  var tagResult;
  var quoteResult;
  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.amber.shade300, primaryColor],
            radius: 0.8,
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
          bottomNavigationBar: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)),
            ),
            /* borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)), */
            child: Padding(
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
      ),
    );
  }
}
