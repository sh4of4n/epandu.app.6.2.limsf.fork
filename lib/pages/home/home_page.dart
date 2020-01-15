import 'package:epandu/app_localizations.dart';
import 'package:epandu/pages/home/feeds.dart';
import 'package:epandu/services/repo/auth_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/drawer.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  var studentEnrollmentData;

  @override
  void initState() {
    super.initState();

    getStudentInfo();
  }

  getStudentInfo() async {
    String _name = await localStorage.getUsername();
    String _firstName;

    if (_name.isEmpty) {
      await authRepo.checkDiList(context: context);

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
      /* decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.cyan.shade100,
            // Color(0xffbac1ff),
            // Colors.tealAccent.shade100,
            Colors.lightBlueAccent
          ],
          // stops: [0.1, 0.3, 1],
        ),
      ), */
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.shade300,
            primaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, SETTINGS),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle, size: 30),
              onPressed: () {
                Navigator.pushNamed(context, PROFILE);
              },
            ),
          ],
        ),
        drawer: DrawerMenu(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context).translate('hello_lbl'),
                    style: GoogleFonts.dosis(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      textStyle: TextStyle(color: Colors.black),
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
      ),
    );
  }
}
