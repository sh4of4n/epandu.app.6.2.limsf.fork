import 'dart:async';

import 'package:epandu/services/location.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/services/repository/kpp_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';

import 'bottom_menu.dart';
import 'feeds.dart';
import 'home_page_header.dart';
import 'home_top_menu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final authRepo = AuthRepo();
  final kppRepo = KppRepo();
  final localStorage = LocalStorage();
  final primaryColor = ColorConstant.primaryColor;
  // String _username = '';
  var studentEnrollmentData;
  var feed;
  final myImage = ImagesConstant();
  // get location
  Location location = Location();
  StreamSubscription<Position> positionStream;
  final geolocator = Geolocator();
  final locationOptions = LocationOptions(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  String instituteLogo = '';
  bool isLogoLoaded = false;

  final _iconText = TextStyle(
    fontSize: ScreenUtil().setSp(55),
    fontWeight: FontWeight.w500,
  );

  @override
  void initState() {
    super.initState();

    _openHiveBoxes();
    // getStudentInfo();
    // _getCurrentLocation();
    _getDiProfile();
    _getActiveFeed();
  }

  @override
  void dispose() {
    // positionStream.cancel();
    super.dispose();
  }

  Future<void> _getDiProfile() async {
    // String instituteLogoPath = await localStorage.getInstituteLogo();

    var result = await authRepo.getDiProfile(context: context);

    if (result.isSuccess && result.data != null) {
      // Uint8List decodedImage = base64Decode(
      //     result.data);

      setState(() {
        instituteLogo = result.data;
        isLogoLoaded = true;
      });
    }

    /* if (instituteLogoPath.isEmpty) {
      var result = await authRepo.getDiProfile(context: context);

      if (result.isSuccess && result.data != null) {
        // Uint8List decodedImage = base64Decode(
        //     result.data);

        setState(() {
          instituteLogo = result.data;
          isLogoLoaded = true;
        });
      }
    } else {
      // Uint8List decodedImage = base64Decode(instituteLogoPath);

      setState(() {
        instituteLogo = instituteLogoPath;
        isLogoLoaded = true;
      });
    } */
  }

  Future<void> _getActiveFeed() async {
    var result = await authRepo.getActiveFeed(
      context: context,
      feedType: 'MAIN',
    );

    if (result.isSuccess) {
      setState(() {
        feed = result.data;
      });
    }
  }

  /* _getCurrentLocation() async {
    await location.getCurrentLocation();
    await _checkSavedCoord();
    // userTracking();
  }

  // Check if stored latitude and longitude is null
  _checkSavedCoord() async {
    double _savedLatitude =
        double.tryParse(await localStorage.getUserLatitude());
    double _savedLongitude =
        double.tryParse(await localStorage.getUserLongitude());

    if (_savedLatitude == null || _savedLongitude == null) {
      localStorage.saveUserLatitude(location.latitude.toString());
      localStorage.saveUserLongitude(location.longitude.toString());
    }
  } */

  // remember to add positionStream.cancel()
  /* Future<void> userTracking() async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();

    // print(geolocationStatus);

    if (geolocationStatus == GeolocationStatus.granted) {
      positionStream = geolocator
          .getPositionStream(locationOptions)
          .listen((Position position) async {
        localStorage.saveUserLatitude(position.latitude.toString());
        localStorage.saveUserLongitude(position.longitude.toString());
      });
    }
  } */

  _openHiveBoxes() async {
    await Hive.openBox('telcoList');
    await Hive.openBox('serviceList');
    // await Hive.openBox('emergencyContact');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: EdgeInsets.only(top: 120.h),
          height: 350.h,
          width: 450.w,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, EMERGENCY_DIRECTORY);
            },
            child: Image.asset(
              myImage.sos,
              // width: ScreenUtil().setWidth(300),
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
        bottomNavigationBar:
            BottomMenu(iconText: _iconText, positionStream: positionStream),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _getActiveFeed,
            child: SingleChildScrollView(
              child: Container(
                // margin:
                //     EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(40)),
                // height: ScreenUtil.screenHeightDp - ScreenUtil().setHeight(100),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(60)),
                      child: HomePageHeader(
                          instituteLogo: instituteLogo,
                          positionStream: positionStream),
                    ),
                    HomeTopMenu(iconText: _iconText),
                    LimitedBox(maxHeight: ScreenUtil().setHeight(30)),
                    Feeds(feed: feed),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
