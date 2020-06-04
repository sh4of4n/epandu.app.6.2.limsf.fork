import 'package:app_settings/app_settings.dart';
import 'package:epandu/services/location.dart';
import 'package:epandu/services/repository/emergency_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/custom_snackbar.dart';
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
  final customSnackbar = CustomSnackbar();
  final geolocator = Geolocator();
  final iconText = TextStyle(
    fontSize: ScreenUtil().setSp(64),
    fontWeight: FontWeight.bold,
    color: Color(0xff5d6767),
  );
  final location = Location();

  String policeNumber = '';
  String ambulanceNumber = '';
  String bombaNumber = '';
  String carWorkshopNumber = '';
  String bikeWorkshopNumber = '';

  @override
  void initState() {
    super.initState();

    _checkLocationPermission();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _checkLocationPermission() async {
    // contactBox = Hive.box('emergencyContact');

    // await location.getCurrentLocation();

    bool serviceLocationStatus = await Geolocator().isLocationServiceEnabled();

    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();

    if (serviceLocationStatus &&
        geolocationStatus == GeolocationStatus.granted) {
      Future.wait([
        _getSosContact('POLICE'),
        _getSosContact('AMBULANCE'),
        _getSosContact('BOMBA'),
        _getSosContact('WORKSHOP'),
        _getSosContact('BIKEWORKSHOP'),
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
      maxRadius: '30',
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

      if (mounted) {
        setState(() {
          ambulanceNumber = ambulanceContacts[0].phone;
        });
      }
    } else if (response.isSuccess && type == 'BOMBA') {
      var bombaContacts = response.data;

      for (int i = 0; i < bombaContacts.length; i += 1) {
        if (bombaContacts[i].phone != null && mounted) {
          setState(() {
            bombaNumber = bombaContacts[i].phone;
          });
          break;
        }
      }

      // setState(() {
      //   bombaNumber = bombaContacts[0].phone;
      // });
    } else if (response.isSuccess && type == 'WORKSHOP') {
      var carWorkshopContacts = response.data;

      if (mounted) {
        setState(() {
          carWorkshopNumber = carWorkshopContacts[0].phone;
        });
      }
    } else if (response.isSuccess && type == 'BIKEWORKSHOP') {
      var bikeWorkshopContacts = response.data;

      if (mounted) {
        setState(() {
          bikeWorkshopNumber = bikeWorkshopContacts[0].phone;
        });
      }
    }
  }

  _callPoliceNumber() async {
    if (policeNumber.isEmpty) {
      customSnackbar.show(
        context,
        message: AppLocalizations.of(context).translate('no_nearby_contacts'),
        duration: 5000,
        type: MessageType.INFO,
      );
    } else {
      String trimNumber = policeNumber.replaceAll('-', '').replaceAll(' ', '');

      await launch('tel:$trimNumber');
    }
  }

  _callEmergencyNumber() async {
    if (ambulanceNumber.isEmpty) {
      customSnackbar.show(
        context,
        message: AppLocalizations.of(context).translate('no_nearby_contacts'),
        duration: 5000,
        type: MessageType.INFO,
      );
    } else {
      String trimNumber =
          ambulanceNumber.replaceAll('-', '').replaceAll(' ', '');

      await launch('tel:$trimNumber');
    }
  }

  _callBombaNumber() async {
    if (bombaNumber.isEmpty) {
      customSnackbar.show(
        context,
        message: AppLocalizations.of(context).translate('no_nearby_contacts'),
        duration: 5000,
        type: MessageType.INFO,
      );
    } else {
      String trimNumber = bombaNumber.replaceAll('-', '').replaceAll(' ', '');

      await launch('tel:$trimNumber');
    }
  }

  _callCarWorkshopNumber() async {
    if (carWorkshopNumber.isEmpty) {
      customSnackbar.show(
        context,
        message: AppLocalizations.of(context).translate('no_nearby_contacts'),
        duration: 5000,
        type: MessageType.INFO,
      );
    } else {
      String trimNumber =
          carWorkshopNumber.replaceAll('-', '').replaceAll(' ', '');

      await launch('tel:$trimNumber');
    }
  }

  _callBikeWorkshopNumber() async {
    if (bikeWorkshopNumber.isEmpty) {
      customSnackbar.show(
        context,
        message: AppLocalizations.of(context).translate('no_nearby_contacts'),
        duration: 5000,
        type: MessageType.INFO,
      );
    } else {
      String trimNumber =
          bikeWorkshopNumber.replaceAll('-', '').replaceAll(' ', '');

      await launch('tel:$trimNumber');
    }
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
                    myImage.sosBanner,
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
                                      onPressed: _callBombaNumber,
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
                                            arguments: 'BOMBA');
                                      },
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
                                      onPressed: _callCarWorkshopNumber,
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
                                            arguments: 'WORKSHOP');
                                      },
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
                                  height: 300.h,
                                  width: 400.w,
                                  child: Image.asset(myImage.ambulanceIcon)),
                              Wrap(
                                children: <Widget>[
                                  Container(
                                    height: 200.h,
                                    width: 300.w,
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
                                  margin: EdgeInsets.symmetric(vertical: 10.h),
                                  height: 300.h,
                                  width: 400.w,
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
                                      onPressed: () => {
                                        customSnackbar.show(
                                          context,
                                          message: AppLocalizations.of(context)
                                              .translate('select_insurance'),
                                          duration: 5000,
                                          type: MessageType.INFO,
                                        ),
                                      },
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
                                            arguments: 'INSURANCE');
                                      },
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
                                      onPressed: _callBikeWorkshopNumber,
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
                                            arguments: 'BIKEWORKSHOP');
                                      },
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
