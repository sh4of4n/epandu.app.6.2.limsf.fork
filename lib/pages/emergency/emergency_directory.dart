import 'package:app_settings/app_settings.dart';
import 'package:epandu/services/repository/emergency_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_localizations.dart';

class EmergencyDirectory extends StatefulWidget {
  @override
  _EmergencyDirectoryState createState() => _EmergencyDirectoryState();
}

class _EmergencyDirectoryState extends State<EmergencyDirectory> {
  final primaryColor = ColorConstant.primaryColor;
  final emergencyRepo = EmergencyRepo();
  final myImage = ImagesConstant();
  final customDialog = CustomDialog();
  final geolocator = Geolocator();
  final iconText = TextStyle(
    fontSize: ScreenUtil().setSp(64),
    fontWeight: FontWeight.bold,
    color: Color(0xff5d6767),
  );
  String policeNumber = '';
  String ambulanceNumber = '';

  @override
  void initState() {
    super.initState();

    _checkLocationPermission();
  }

  _checkLocationPermission() async {
    // contactBox = Hive.box('emergencyContact');

    // await location.getCurrentLocation();

    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();

    if (geolocationStatus == GeolocationStatus.granted) {
      Future.wait([
        _getSosContact('POLICE'),
        _getSosContact('AMBULANCE'),
      ]);
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

  Future<void> _getSosContact(type) async {
    var response = await emergencyRepo.getSosContactSortByNearest(
      context: context,
      sosContactType: type,
    );

    if (response.isSuccess && type == 'POLICE') {
      var policeContacts = response.data;

      for (int i = 0; i < policeContacts.length; i += 1) {
        if (policeContacts[i].sosContactSubtype == 'IPD' && mounted) {
          setState(() {
            policeNumber = policeContacts[i].phone;
          });
          break;
        }
      }
    } else if (response.isSuccess && type == 'AMBULANCE') {
      var ambulanceContacts = response.data;

      /* for (int i = 0; i < ambulanceContacts.length; i += 1) {
        if (ambulanceContacts[i].sosContactSubtype == 'PUBLIC' && mounted) {
          setState(() {
            ambulanceNumber = ambulanceContacts[i].phone;
          });
          break;
        }
      } */

      setState(() {
        ambulanceNumber = ambulanceContacts[0].phone;
      });
    }
  }

  _callPoliceNumber() async {
    String trimNumber = policeNumber.replaceAll('-', '').replaceAll(' ', '');

    await launch('tel:$trimNumber');
  }

  _callEmergencyNumber() async {
    String trimNumber = ambulanceNumber.replaceAll('-', '').replaceAll(' ', '');

    await launch('tel:$trimNumber');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xffffcd11)],
          stops: [0.65, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context).translate('sos_lbl')),
        ),
        body: Container(
          // margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(50)),
          height: ScreenUtil.screenHeightDp,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FadeInImage(
                  alignment: Alignment.center,
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage(
                    myImage.emergencyImage,
                  ),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(60)),
                      child: Column(
//
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: ScreenUtil().setHeight(10)),
                                height: ScreenUtil().setHeight(300),
                                width: ScreenUtil().setWidth(400),
                                child: Image.asset(
                                  myImage.policeIcon,
                                ),
                              ),
                              Wrap(
                                children: <Widget>[
                                  Container(
                                    height: ScreenUtil().setHeight(200),
                                    width: ScreenUtil().setWidth(300),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(myImage.phoneButton),
                                      ),
                                    ),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: _callPoliceNumber,
                                      child: null,
                                    ),
                                  ),
                                  Container(
                                    height: ScreenUtil().setHeight(200),
                                    width: ScreenUtil().setWidth(300),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage(myImage.directoryButton),
                                      ),
                                    ),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, DIRECTORY_LIST,
                                            arguments: 'POLICE');
                                      },
                                      child: null,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('police_title'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: ScreenUtil()
                                        .setSp(54, allowFontScalingSelf: true)),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: ScreenUtil().setHeight(10)),
                                  height: ScreenUtil().setHeight(300),
                                  width: ScreenUtil().setWidth(400),
                                  child: Image.asset(myImage.bombaIcon)),
                              Wrap(
                                children: <Widget>[
                                  Container(
                                    height: ScreenUtil().setHeight(200),
                                    width: ScreenUtil().setWidth(300),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(myImage.phoneButton),
                                      ),
                                    ),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: () {},
                                      child: null,
                                    ),
                                  ),
                                  Container(
                                    height: ScreenUtil().setHeight(200),
                                    width: ScreenUtil().setWidth(300),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage(myImage.directoryButton),
                                      ),
                                    ),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: () {},
                                      child: null,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('bomba_title'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: ScreenUtil()
                                        .setSp(54, allowFontScalingSelf: true)),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: ScreenUtil().setHeight(10)),
                                  height: ScreenUtil().setHeight(300),
                                  width: ScreenUtil().setWidth(400),
                                  child: Image.asset(
                                    myImage.workshopCar,
                                  )),
                              Wrap(
                                children: <Widget>[
                                  Container(
                                    height: ScreenUtil().setHeight(200),
                                    width: ScreenUtil().setWidth(300),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(myImage.phoneButton),
                                      ),
                                    ),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: () {},
                                      child: null,
                                    ),
                                  ),
                                  Container(
                                    height: ScreenUtil().setHeight(200),
                                    width: ScreenUtil().setWidth(300),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage(myImage.directoryButton),
                                      ),
                                    ),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: () {},
                                      child: null,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('workshop_cars'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: ScreenUtil()
                                        .setSp(54, allowFontScalingSelf: true)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(60)),
                      child: Column(
//                      direction: Axis.vertical,
//                      spacing: 20.0,
//                      runSpacing: 10.0,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: ScreenUtil().setHeight(10)),
                                  height: ScreenUtil().setHeight(300),
                                  width: ScreenUtil().setWidth(400),
                                  child: Image.asset(myImage.ambulanceIcon)),
                              Wrap(
                                children: <Widget>[
                                  Container(
                                    height: ScreenUtil().setHeight(200),
                                    width: ScreenUtil().setWidth(300),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(myImage.phoneButton),
                                      ),
                                    ),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: _callEmergencyNumber,
                                      child: null,
                                    ),
                                  ),
                                  Container(
                                    height: ScreenUtil().setHeight(200),
                                    width: ScreenUtil().setWidth(300),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage(myImage.directoryButton),
                                      ),
                                    ),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, DIRECTORY_LIST,
                                            arguments: 'AMBULANCE');
                                      },
                                      child: null,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('ambulance_title'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: ScreenUtil()
                                        .setSp(54, allowFontScalingSelf: true)),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: ScreenUtil().setHeight(10)),
                                  height: ScreenUtil().setHeight(300),
                                  width: ScreenUtil().setWidth(400),
                                  child: Image.asset(myImage.towingIcon)),
                              Wrap(
                                children: <Widget>[
                                  Container(
                                    height: ScreenUtil().setHeight(200),
                                    width: ScreenUtil().setWidth(300),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(myImage.phoneButton),
                                      ),
                                    ),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: () {},
                                      child: null,
                                    ),
                                  ),
                                  Container(
                                    height: ScreenUtil().setHeight(200),
                                    width: ScreenUtil().setWidth(300),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage(myImage.directoryButton),
                                      ),
                                    ),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: () {},
                                      child: null,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('towing_service'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: ScreenUtil()
                                        .setSp(54, allowFontScalingSelf: true)),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: ScreenUtil().setHeight(10)),
                                  height: ScreenUtil().setHeight(300),
                                  width: ScreenUtil().setWidth(400),
                                  child: Image.asset(myImage.workshopBike)),
                              Wrap(
                                children: <Widget>[
                                  Container(
                                    height: ScreenUtil().setHeight(200),
                                    width: ScreenUtil().setWidth(300),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(myImage.phoneButton),
                                      ),
                                    ),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: () {},
                                      child: null,
                                    ),
                                  ),
                                  Container(
                                    height: ScreenUtil().setHeight(200),
                                    width: ScreenUtil().setWidth(300),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage(myImage.directoryButton),
                                      ),
                                    ),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: () {},
                                      child: null,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('workshop_bike'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: ScreenUtil()
                                        .setSp(54, allowFontScalingSelf: true)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
