// import 'package:epandu/pages/edompet/edompet.dart';
import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:epandu/pages/epandu/epandu.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';

class AttendanceTab extends StatefulWidget {
  @override
  _AttendanceTabState createState() => _AttendanceTabState();
}

class _AttendanceTabState extends State<AttendanceTab>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<AttendanceTab> {
  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Attendance',
    ),
    /* Tab(
      icon: new Icon(
        Icons.account_balance_wallet,
        size: 28.0,
      ),
    ), */
    Tab(
      text: 'Check In',
    ),
  ];
  TabController? _tabController;
  int _tabIndex = 0;
  final epanduRepo = EpanduRepo();
  final localStorage = LocalStorage();
  final primaryColor = ColorConstant.primaryColor;
  final customDialog = CustomDialog();

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  var attendanceData;
  var checkInData;

  String enrollmentMessage = '';
  String paymentMessage = '';
  String attendanceMessage = '';

  var enrollData;
  bool stuPracIsLoading = false;
  bool checkInLoading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController!.addListener(_getTabSelection);

    Future.wait([
      _getStuPracByCode(),
      _getJpjTestCheckIn(),
    ]);
  }

  Future<void> _getStuPracByCode() async {
    setState(() {
      stuPracIsLoading = true;
    });

    var response = await epanduRepo.getStuPracByCode(context: context);

    if (response.isSuccess) {
      setState(() {
        attendanceData = response.data;
      });
    }

    setState(() {
      stuPracIsLoading = false;
    });
  }

  Future<void> _getJpjTestCheckIn() async {
    setState(() {
      checkInLoading = true;
    });

    var result = await epanduRepo.getJpjTestCheckIn();

    if (result.isSuccess) {
      checkInData = result.data;
    }

    setState(() {
      checkInLoading = false;
    });
  }

  _getTabSelection() {
    setState(() {
      _tabIndex = _tabController!.index;
    });
  }

  _getTitle() {
    switch (_tabIndex) {
      case 0:
        return Text('Attendance');
      // case 1:
      //   return Text(AppLocalizations.of(context).translate('edompet_title'));
      case 1:
        return Text('Check In');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
          ),
          backgroundColor: Colors.transparent,
          body: TabBarView(controller: _tabController, children: [
            AttendanceRecord(
              attendanceData: attendanceData,
              isLoading: stuPracIsLoading,
            ),
            // Edompet(),
            CheckInRecord(
              checkInData: checkInData,
              isLoading: checkInLoading,
            ),
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
    _tabController!.dispose();
    super.dispose();
  }
}
