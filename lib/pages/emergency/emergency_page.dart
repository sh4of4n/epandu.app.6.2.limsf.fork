import 'package:epandu/app_localizations.dart';
import 'package:epandu/pages/emergency/authorities_button.dart';
import 'package:epandu/services/location.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

class Emergency extends StatefulWidget {
  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  final primaryColor = ColorConstant.primaryColor;
  Location location = Location();

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    await location.getCurrentLocation();

    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();

    if (geolocationStatus == GeolocationStatus.granted) {
      print('distance: ${location.distanceInMeters}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.amber.shade300, primaryColor],
          stops: [0.5, 1],
          radius: 0.9,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context).translate('emergency_lbl')),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.collections_bookmark),
              onPressed: () =>
                  Navigator.pushNamed(context, EMERGENCY_DIRECTORY),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: ScreenUtil().setHeight(120),
              ),
              Text(AppLocalizations.of(context).translate('authorities_lbl'),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(90),
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  )),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Container(
                width: ScreenUtil().setWidth(1200),
                child: Text(
                  AppLocalizations.of(context).translate('authorities_desc'),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(70),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(70),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  AuthoritiesButton(
                    tileFirstColor: Color(0xff08457e),
                    tileSecondColor: Color(0xff0499c7),
                    label: AppLocalizations.of(context).translate('police_lbl'),
                    onTap: () {},
                  ),
                  AuthoritiesButton(
                    tileFirstColor: Color(0xffc90000),
                    tileSecondColor: Color(0xffd43b3b),
                    label:
                        AppLocalizations.of(context).translate('ambulance_lbl'),
                    onTap: () {},
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
