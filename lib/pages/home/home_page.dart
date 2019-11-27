import 'package:epandu/services/repo/auth_repo.dart';
import 'package:epandu/services/repo/profile_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/drawer.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final authRepo = AuthRepo();
  final profileRepo = ProfileRepo();
  final localStorage = LocalStorage();
  final primaryColor = ColorConstant.primaryColor;
  var profileData;

  @override
  void initState() {
    super.initState();

    _getStudentProfile();
  }

  _getStudentProfile() async {
    profileData = await profileRepo.getStudentProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      drawer: DrawerMenu(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: ScreenUtil.getInstance().setHeight(200),
                    width: ScreenUtil.getInstance().setWidth(600),
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent.shade700,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Text(
                        'Kecemasan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: ScreenUtil.getInstance().setHeight(200),
                    width: ScreenUtil.getInstance().setWidth(600),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Text(
                        'KPP',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: ScreenUtil.getInstance().setHeight(200),
                    width: ScreenUtil.getInstance().setWidth(600),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade700,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Text(
                        'Payment Selection',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: ScreenUtil.getInstance().setHeight(400),
                    width: ScreenUtil.getInstance().setWidth(600),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade700,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, bottom: 15.0),
                          child: Text(
                            'Invite Friends',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* RaisedButton(
          child: Text('Sign out'),
          onPressed: _logout,
        ), */

  _logout() async {
    await authRepo.logout();
    Navigator.pushNamedAndRemoveUntil(context, LOGIN, (r) => false);
  }
}
