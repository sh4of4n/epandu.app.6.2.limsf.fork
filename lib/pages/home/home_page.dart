import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:epandu/custom_icon/my_custom_icons_icons.dart';
import 'package:epandu/pages/home/feeds.dart';
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

import 'home_bottom_menu.dart';
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

  // get location
  Location location = Location();
  StreamSubscription<Position> positionStream;
  final geolocator = Geolocator();
  final locationOptions = LocationOptions(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  Uint8List instituteLogo;
  bool isLogoLoaded = false;

  final _iconText = TextStyle(
    fontSize: ScreenUtil().setSp(56),
    fontWeight: FontWeight.w700,
  );

  @override
  void initState() {
    super.initState();

    _openHiveBoxes();
    // getStudentInfo();
    _getCurrentLocation();
    _getArmasterAppPhotoForCode();
  }

  _getArmasterAppPhotoForCode() async {
    String instituteLogoBase64 =
        await localStorage.getArmasterAppPhotoForCode();

    if (instituteLogoBase64.isEmpty) {
      var result = await authRepo.getDiProfile(context: context);

      if (result.data != null) {
        Uint8List decodedImage = base64Decode(result.data);

        setState(() {
          instituteLogo = decodedImage;
          isLogoLoaded = true;
        });
      }
    } else {
      Uint8List decodedImage = base64Decode(instituteLogoBase64);

      setState(() {
        instituteLogo = decodedImage;
        isLogoLoaded = true;
      });
    }
  }

  _getCurrentLocation() async {
    await location.getCurrentLocation();
    await _checkSavedCoord();
    userTracking();
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
  }

  // remember to add positionStream.cancel()
  Future<void> userTracking() async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();

    // print(geolocationStatus);

    if (geolocationStatus == GeolocationStatus.granted) {
      positionStream = geolocator
          .getPositionStream(locationOptions)
          .listen((Position position) async {
        // double distance = await location.getDistance(
        //   locLatitude: position.latitude,
        //   locLongitude: position.longitude,
        // );

        // await Hive.box('emergencyContact').put('distanceInMeters', distance);

        // print(Hive.box('emergencyContact').get('distanceInMeters'));

        localStorage.saveUserLatitude(position.latitude.toString());
        localStorage.saveUserLongitude(position.longitude.toString());
      });
    }
  }

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
        /* appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, SETTINGS,
                arguments: positionStream),
          ),
        ), */
        // drawer: DrawerMenu(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              // margin:
              //     EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(40)),
              height: ScreenUtil.screenHeightDp - ScreenUtil().setHeight(100),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(40)),
                    child: HomePageHeader(instituteLogo: instituteLogo),
                  ),
                  HomeTopMenu(iconText: _iconText),
                  Expanded(child: HomeBottomMenu(iconText: _iconText)),
                  // Feeds(),
                  // HomeMenuTiles(),
                  // HomeMenuButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
