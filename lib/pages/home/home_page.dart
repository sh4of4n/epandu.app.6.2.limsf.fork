import 'package:epandu/pages/home/feeds.dart';
import 'package:epandu/services/repo/auth_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/drawer.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';

import 'home_menu_tiles.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final authRepo = AuthRepo();
  final localStorage = LocalStorage();
  final primaryColor = ColorConstant.primaryColor;
  String _username = '';

  @override
  void initState() {
    super.initState();

    getStudentInfo();
  }

  getStudentInfo() async {
    String _name = await localStorage.getUsername();
    String _firstName;

    if (_name.isEmpty) {
      await authRepo.checkDiList();

      _name = await localStorage.getUsername();
      _firstName = _name.split(' ')[0];

      setState(() {
        _username = _firstName;
      });
    } else {
      _firstName = _name.split(' ')[0];

      setState(() {
        _username = _firstName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.amber.shade300, primaryColor],
          radius: 0.8,
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
        ),
        drawer: DrawerMenu(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: RichText(
                text: TextSpan(
                  text: 'Hello, ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '\n$_username',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            HomeMenuTiles(),
            Feeds(),
            /* RaisedButton(
              child: Text('Sign out'),
              onPressed: _logout,
            ), */
          ],
        ),
      ),
    );
  }

  _logout() async {
    await authRepo.logout();
    Navigator.pushNamedAndRemoveUntil(context, LOGIN, (r) => false);
  }
}
