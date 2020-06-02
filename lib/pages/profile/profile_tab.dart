// import 'package:epandu/pages/edompet/edompet.dart';
import 'package:epandu/pages/profile/profile_page.dart';
import 'package:epandu/pages/settings/settings.dart';
import 'package:epandu/services/repository/profile_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app_localizations.dart';

class ProfileTab extends StatefulWidget {
  final positionStream;

  ProfileTab(this.positionStream);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(
      icon: new Icon(
        Icons.account_circle,
        size: 28.0,
      ),
    ),
    /* Tab(
      icon: new Icon(
        Icons.account_balance_wallet,
        size: 28.0,
      ),
    ), */
    Tab(
      icon: new Icon(
        Icons.settings,
        size: 28.0,
      ),
    ),
  ];
  TabController _tabController;
  int _tabIndex = 0;
  final profileRepo = ProfileRepo();
  final localStorage = LocalStorage();
  final primaryColor = ColorConstant.primaryColor;
  // var tagResult;
  // var quoteResult;
  // int count = 0;

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

    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(_getTabSelection);

    // _getEnrollmentData();
    // _getPaymentData();
    // _getAttendanceData();
  }

  /* _getEnrollmentData() async {
    if (enrollmentData == null) {
      enrollmentResponse = await profileRepo.getEnrollByCode(context: context);

      if (enrollmentResponse.isSuccess) {
        if (mounted) {
          setState(() {
            enrollmentData = enrollmentResponse;
            enrollmentMessage = '';
          });
        }
      } else {
        if (mounted) {
          setState(() {
            enrollmentData = null;
            enrollmentMessage =
                AppLocalizations.of(context).translate('no_enrollment_desc');
          });
        }
      }
    }
    // enrolledClassResponse = await profileRepo.getEnrolledClasses();
  } */

  /* _getPaymentData() async {
    if (paymentData == null) {
      paymentResponse =
          await profileRepo.getCollectionByStudent(context: context);

      if (paymentResponse.isSuccess) {
        if (mounted) {
          setState(() {
            paymentData = paymentResponse;
            paymentMessage = '';
          });
        }
      } else {
        if (mounted) {
          setState(() {
            paymentData = null;
            paymentMessage =
                AppLocalizations.of(context).translate('no_payment_desc');
          });
        }
      }
    }
  } */

  /*  _getAttendanceData() async {
    if (attendanceData == null) {
      attendanceResponse = await profileRepo.getDTestByCode(context: context);

      if (attendanceResponse.isSuccess) {
        if (mounted) {
          setState(() {
            attendanceData = attendanceResponse;
            attendanceMessage = '';
          });
        }
      } else {
        if (mounted) {
          setState(() {
            attendanceData = null;
            attendanceMessage =
                AppLocalizations.of(context).translate('no_attendance_desc');
          });
        }
      }
    }
  } */

  _getTabSelection() {
    setState(() {
      _tabIndex = _tabController.index;
    });
  }

  _getTitle() {
    switch (_tabIndex) {
      case 0:
        return Text(AppLocalizations.of(context).translate('profile_title'));
      // case 1:
      //   return Text(AppLocalizations.of(context).translate('edompet_title'));
      case 1:
        return Text(AppLocalizations.of(context).translate('settings_lbl'));
    }
  }

  _getActions() {
    switch (_tabIndex) {
      case 0:
        return <Widget>[
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth < 600) {
                return editProfileBtn('mobile');
              }
              return editProfileBtn('tablet');
            },
          ),
        ];
    }
  }

  editProfileBtn(device) {
    return Container(
      padding: device == 'mobile'
          ? EdgeInsets.symmetric(vertical: 70.h)
          : EdgeInsets.symmetric(vertical: 40.h),
      margin: EdgeInsets.only(right: 15.w),
      child: OutlineButton(
        borderSide: BorderSide(
          color: Colors.blue,
          width: 1.5,
        ),
        shape: StadiumBorder(),
        onPressed: () => Navigator.pushNamed(context, UPDATE_PROFILE),
        child: Text('Edit profile'),
      ),
    );
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
            title: _getTitle(),
            actions: _getActions(),
          ),
          backgroundColor: Colors.transparent,
          body: TabBarView(controller: _tabController, children: [
            Profile(),
            // Edompet(),
            Settings(widget.positionStream),
          ]),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
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
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey.shade700,
              tabs: myTabs,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
