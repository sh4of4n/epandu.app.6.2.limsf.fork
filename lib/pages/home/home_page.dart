import 'package:epandu/services/repo/auth_repo.dart';
import 'package:epandu/services/repo/profile_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/drawer.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'icon_tile.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconTile(
                  title: 'Kecemasan',
                  tileColor: Colors.amber,
                ),
                IconTile(
                  title: 'KPP',
                  tileColor: Colors.blue.shade600,
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconTile(
                  title: 'Payment',
                  tileColor: Colors.deepPurple,
                ),
                IconTile(
                  title: 'Invite Friends',
                  tileColor: Colors.orange.shade400,
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
