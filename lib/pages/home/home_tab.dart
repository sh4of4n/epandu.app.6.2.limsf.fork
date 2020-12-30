import 'package:epandu/custom_icon/my_custom_icons_icons.dart';
import 'package:epandu/pages/home/home.dart';
import 'package:epandu/pages/invite/invite.dart';
// import 'package:epandu/pages/menu/menu.dart';
import 'package:epandu/common_library/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_localizations.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  final primaryColor = ColorConstant.primaryColor;
  final myImage = ImagesConstant();

  final List<Tab> myTabs = <Tab>[
    Tab(
      icon: new Icon(
        MyCustomIcons.home_icon,
        size: 30,
        color: Color(0xff808080),
      ),
    ),
    Tab(
      icon: new Icon(
        MyCustomIcons.v_club_icon,
        size: 30,
        color: Color(0xff808080),
      ),
    ),
    Tab(
      icon: new Icon(
        MyCustomIcons.invite_icon,
        size: 30,
        color: Color(0xff808080),
      ),
    ),
    /* Tab(
      icon: new Icon(
        MyCustomIcons.menu_icon,
        size: 30,
        color: Color(0xff808080),
      ),
    ), */
  ];

  TabController _tabController;
  // int _tabIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: myTabs.length);
    // _tabController.addListener(_getTabSelection);
  }

  /* _getTabSelection() {
    setState(() {
      _tabIndex = _tabController.index;
    });
  } */

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              primaryColor,
            ],
            stops: [0.45, 0.65],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Ink(
                  height: ScreenUtil().setHeight(400),
                  color: Colors.white,
                  child: TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(
                          MyCustomIcons.home_icon,
                          size: 30,
                          color: Color(0xff808080),
                        ),
                        text:
                            AppLocalizations.of(context).translate('home_lbl'),
                      ),
                      Tab(
                        icon: Icon(
                          MyCustomIcons.v_club_icon,
                          size: 30,
                          color: Color(0xff808080),
                        ),
                        text: AppLocalizations.of(context)
                            .translate('v_club_lbl'),
                      ),
                      Image.asset(myImage.sos,
                          width: ScreenUtil().setWidth(300)),
                      Tab(
                        icon: Icon(
                          MyCustomIcons.invite_icon,
                          size: 30,
                          color: Color(0xff808080),
                        ),
                        text: AppLocalizations.of(context)
                            .translate('invite_lbl'),
                      ),
                      /* Tab(
                        icon: Icon(
                          MyCustomIcons.menu_icon,
                          size: 30,
                          color: Color(0xff808080),
                        ),
                        text:
                            AppLocalizations.of(context).translate('menu_lbl'),
                      ), */
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Home(),
              Invite(),
              // Menu(),
            ],
          ),
        ),
      ),
    );
  }
}
