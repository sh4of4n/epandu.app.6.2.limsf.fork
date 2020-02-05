import 'package:epandu/app_localizations.dart';
import 'package:epandu/pages/emergency/authorities_button.dart';
import 'package:epandu/services/location.dart';
import 'package:epandu/services/repo/emergency_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';
import 'package:app_settings/app_settings.dart';

class Emergency extends StatefulWidget {
  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  Box<dynamic> contactBox;
  final primaryColor = ColorConstant.primaryColor;
  final emergencyRepo = EmergencyRepo();
  final localStorage = LocalStorage();
  Location location = Location();
  String policeNumber;
  final customDialog = CustomDialog();
  final geolocator = Geolocator();
  final locationOptions = LocationOptions(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  _checkLocationPermission() async {
    contactBox = Hive.box('emergencyContact');

    if (contactBox.get('nearestPoliceContact') != null && mounted)
      setState(() {
        policeNumber = contactBox.get('nearestPoliceContact');
      });

    // await location.getCurrentLocation();

    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();

    if (geolocationStatus == GeolocationStatus.granted) {
      // print('distance: ${location.distanceInMeters}');

      if (location.distanceInMeters > 100 ||
          contactBox.get('nearestPoliceContact') == null)
        _getContacts();
      else {
        // if positionStream is not initiated
        await location.getCurrentLocation();
        double distance = await location.getDistance(
            locLatitude: location.latitude, locLongitude: location.longitude);

        if (distance > 100) _getContacts();

        location.distanceInMeters = distance;

        localStorage.saveUserLatitude(location.latitude.toString());
        localStorage.saveUserLongitude(location.longitude.toString());
      }
    } else {
      customDialog.show(
        context: context,
        barrierDismissable: false,
        title: Text(
            AppLocalizations.of(context).translate('loc_permission_title')),
        content: AppLocalizations.of(context).translate('loc_permission_desc'),
        customActions: <Widget>[
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('yes_lbl')),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              AppSettings.openLocationSettings();
            },
          ),
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('no_lbl')),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
        type: DialogType.GENERAL,
      );
    }
  }

  _getContacts() async {
    // if (emergencyContacts.isEmpty) {
    await emergencyRepo.getEmergencyContact(
        context: context, sosContactType: 'POLICE');

    var policeContacts = contactBox.get('policeContact');

    for (int i = 0; i < policeContacts.length; i += 1) {
      if (policeContacts[i].sosContactSubtype == 'IPD' && mounted) {
        setState(() {
          policeNumber = policeContacts[i].phone;
        });
        contactBox.put('nearestPoliceContact', policeContacts[i].phone);
        break;
      }
    }
  }

  _callPoliceNumber() async {
    String trimNumber = policeNumber.replaceAll('-', '').replaceAll(' ', '');

    await launch('tel:$trimNumber');
  }

  _callEmergencyNumber({@required String number}) async {
    await launch('tel:999');
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
              icon: Icon(Icons.view_list),
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
                  AnimatedCrossFade(
                    crossFadeState: policeNumber != null
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 1500),
                    firstChild: AuthoritiesButton(
                      tileFirstColor: Color(0xff08457e),
                      tileSecondColor: Color(0xff0499c7),
                      label:
                          AppLocalizations.of(context).translate('police_lbl'),
                      onTap: _callPoliceNumber,
                    ),
                    secondChild: SizedBox(
                      width: ScreenUtil().setWidth(600),
                      height: ScreenUtil().setHeight(450),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: AuthoritiesButton(
                          tileFirstColor: Color(0xff08457e),
                          tileSecondColor: Color(0xff0499c7),
                          label: AppLocalizations.of(context)
                              .translate('police_lbl'),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                  AnimatedCrossFade(
                    crossFadeState: policeNumber != null
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 1500),
                    firstChild: AuthoritiesButton(
                      tileFirstColor: Color(0xffc90000),
                      tileSecondColor: Color(0xffd43b3b),
                      label: AppLocalizations.of(context).translate('999_lbl'),
                      onTap: _callEmergencyNumber,
                    ),
                    secondChild: SizedBox(
                      width: ScreenUtil().setWidth(600),
                      height: ScreenUtil().setHeight(450),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: AuthoritiesButton(
                          tileFirstColor: Color(0xffc90000),
                          tileSecondColor: Color(0xffd43b3b),
                          label:
                              AppLocalizations.of(context).translate('999_lbl'),
                          onTap: () {},
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dispose() {
    super.dispose();
  }
}
