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
import 'directory_card.dart';

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
      var response = await emergencyRepo.getSosContactSortByNearest(
          context: context, sosContactType: 'POLICE');

      if (response.isSuccess) {
        var policeContacts = response.data;

        for (int i = 0; i < policeContacts.length; i += 1) {
          if (policeContacts[i].sosContactSubtype == 'IPD' && mounted) {
            setState(() {
              policeNumber = policeContacts[i].phone;
            });
            break;
          }
        }
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
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Table(
                    // defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    // border: TableBorder.all(),
                    children: [
                      TableRow(
                        children: [
                          DirectoryCard(
                            title: AppLocalizations.of(context)
                                .translate('police_title'),
                            image: myImage.policeIcon,
                            phoneIcon: myImage.phoneButton,
                            directoryIcon: myImage.directoryButton,
                            iconText: iconText,
                            phoneAction: _callPoliceNumber,
                            directoryName: DIRECTORY_LIST,
                            directoryType: 'POLICE',
                          ),
                          DirectoryCard(
                            title: AppLocalizations.of(context)
                                .translate('ambulance_title'),
                            image: myImage.ambulanceIcon,
                            phoneIcon: myImage.phoneButton,
                            directoryIcon: myImage.directoryButton,
                            iconText: iconText,
                            phoneAction: _callEmergencyNumber,
                            directoryName: DIRECTORY_LIST,
                            directoryType: 'AMBULANCE',
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          DirectoryCard(
                            title: AppLocalizations.of(context)
                                .translate('bomba_title'),
                            image: myImage.bombaIcon,
                            phoneIcon: myImage.phoneButton,
                            directoryIcon: myImage.directoryButton,
                            iconText: iconText,
                            // directoryName: DIRECTORY_LIST,
                            // directoryType: 'BOMBA',
                          ),
                          DirectoryCard(
                            title: AppLocalizations.of(context)
                                .translate('towing_service'),
                            image: myImage.towingIcon,
                            phoneIcon: myImage.phoneButton,
                            directoryIcon: myImage.directoryButton,
                            iconText: iconText,
                            // directoryName: DIRECTORY_LIST,
                            // directoryType: 'WORKSHOP',
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          DirectoryCard(
                            title: AppLocalizations.of(context)
                                .translate('workshop_cars'),
                            image: myImage.workshopCar,
                            phoneIcon: myImage.phoneButton,
                            directoryIcon: myImage.directoryButton,
                            iconText: iconText,
                            // directoryName: DIRECTORY_LIST,
                            // directoryType: 'BOMBA',
                          ),
                          DirectoryCard(
                            title: AppLocalizations.of(context)
                                .translate('workshop_bike'),
                            image: myImage.workshopBike,
                            phoneIcon: myImage.phoneButton,
                            directoryIcon: myImage.directoryButton,
                            iconText: iconText,
                            // directoryName: DIRECTORY_LIST,
                            // directoryType: 'WORKSHOP',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(70),
                ),
                /* InkWell(
                  onTap: () {},
                  child: Text(
                    AppLocalizations.of(context).translate('upgrade_sos_lbl'),
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(72),
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ), */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
