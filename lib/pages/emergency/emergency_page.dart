import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/pages/emergency/authorities_button.dart';
import 'package:epandu/common_library/services/location.dart';
import 'package:epandu/common_library/services/repository/emergency_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:app_settings/app_settings.dart';

import '../../router.gr.dart';

class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  // Box<dynamic> contactBox;
  final primaryColor = ColorConstant.primaryColor;
  final emergencyRepo = EmergencyRepo();
  final localStorage = LocalStorage();
  Location location = Location();
  String? policeNumber;
  final customDialog = CustomDialog();

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  _checkLocationPermission() async {
    // contactBox = Hive.box('emergencyContact');

    // await location.getCurrentLocation();

    LocationPermission geolocationStatus = await Geolocator.checkPermission();

    if (geolocationStatus == LocationPermission.whileInUse ||
        geolocationStatus == LocationPermission.always) {
      if (!context.mounted) return;
      var response = await emergencyRepo.getSosContactSortByNearest(
          context: context, sosContactType: 'POLICE', maxRadius: '30');

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
      if (!context.mounted) return;
      customDialog.show(
        context: context,
        barrierDismissable: false,
        title: Text(
            AppLocalizations.of(context)!.translate('loc_permission_title')),
        content: AppLocalizations.of(context)!.translate('loc_permission_desc'),
        customActions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context)!.translate('yes_lbl')),
            onPressed: () {
              context.router.pop();
              context.router.pop();
              AppSettings.openAppSettings(type: AppSettingsType.location);
            },
          ),
          TextButton(
            child: Text(AppLocalizations.of(context)!.translate('no_lbl')),
            onPressed: () {
              context.router.pop();
              context.router.pop();
            },
          ),
        ],
        type: DialogType.GENERAL,
      );
    }
  }

  _callPoliceNumber() async {
    String trimNumber = policeNumber!.replaceAll('-', '').replaceAll(' ', '');

    await launchUrl(Uri.parse('tel:$trimNumber'));
  }

  _callEmergencyNumber({required String number}) async {
    await launchUrl(Uri.parse('tel:999'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.amber.shade300, primaryColor],
          stops: const [0.5, 1],
          radius: 0.9,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context)!.translate('emergency_lbl')),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.view_list),
              onPressed: () => context.router.push(const EmergencyDirectory()),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: ScreenUtil().setHeight(120),
              ),
              Text(AppLocalizations.of(context)!.translate('authorities_lbl'),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(90),
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  )),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(1200),
                child: Text(
                  AppLocalizations.of(context)!.translate('authorities_desc'),
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
                      tileFirstColor: const Color(0xff08457e),
                      tileSecondColor: const Color(0xff0499c7),
                      label:
                          AppLocalizations.of(context)!.translate('police_lbl'),
                      onTap: _callPoliceNumber,
                    ),
                    secondChild: SizedBox(
                      width: ScreenUtil().setWidth(600),
                      height: ScreenUtil().setHeight(450),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: AuthoritiesButton(
                          tileFirstColor: const Color(0xff08457e),
                          tileSecondColor: const Color(0xff0499c7),
                          label: AppLocalizations.of(context)!
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
                      tileFirstColor: const Color(0xffc90000),
                      tileSecondColor: const Color(0xffd43b3b),
                      label: AppLocalizations.of(context)!.translate('999_lbl'),
                      onTap: _callEmergencyNumber,
                    ),
                    secondChild: SizedBox(
                      width: ScreenUtil().setWidth(600),
                      height: ScreenUtil().setHeight(450),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: AuthoritiesButton(
                          tileFirstColor: const Color(0xffc90000),
                          tileSecondColor: const Color(0xffd43b3b),
                          label: AppLocalizations.of(context)!
                              .translate('999_lbl'),
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

  @override
  void dispose() {
    super.dispose();
  }
}
