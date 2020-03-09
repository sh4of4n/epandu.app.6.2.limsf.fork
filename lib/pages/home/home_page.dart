import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:epandu/pages/home/feeds.dart';
import 'package:epandu/pages/home/home_menu_buttons.dart';
import 'package:epandu/services/location.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/services/repository/kpp_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';

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

  // getStudentInfo() async {
  //   String _name = await localStorage.getUsername();
  //   String _firstName;

  //   if (_name.isEmpty) {
  //     await authRepo.getUserRegisteredDI(context: context);

  //     _name = await localStorage.getUsername();
  //     _firstName = _name.split(' ')[0];

  //     setState(() {
  //       _username = _firstName;
  //     });
  //   } else {
  //     _firstName = _name.split(' ')[0];

  //     setState(() {
  //       _username = _firstName;
  //     });
  //   }
  // }

  _customContainer() {
    return Container(
      width: 294,
      height: 154,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onPressed: () => Navigator.pushNamed(context, SETTINGS,
                arguments: positionStream),
          ),
        ),
        // drawer: DrawerMenu(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /* Padding(
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
              ), */
              Center(
                child: AnimatedCrossFade(
                  crossFadeState: isLogoLoaded
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 1500),
                  firstChild: instituteLogo != null
                      ? Image.memory(
                          instituteLogo,
                          semanticLabel: 'ePandu',
                        )
                      : _customContainer(),
                  secondChild: _customContainer(),
                ),
              ),
              // HomeMenuTiles(),
              HomeMenuButtons(),
              Feeds(),
            ],
          ),
        ),
      ),
    );
  }
}
