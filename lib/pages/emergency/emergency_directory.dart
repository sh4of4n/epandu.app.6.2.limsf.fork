import 'package:epandu/services/location.dart';
import 'package:epandu/services/repo/emergency_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';

import '../../app_localizations.dart';
import 'authorities_button.dart';

class EmergencyDirectory extends StatefulWidget {
  @override
  _EmergencyDirectoryState createState() => _EmergencyDirectoryState();
}

class _EmergencyDirectoryState extends State<EmergencyDirectory> {
  final primaryColor = ColorConstant.primaryColor;
  final contactBox = Hive.box('emergencyContact');
  final emergencyRepo = EmergencyRepo();
  Location location = Location();
  var policeContacts;
  var ambulanceContacts;
  var embassyContacts;

  @override
  void initState() {
    super.initState();

    _getContacts();
  }

  _getContacts() {
    Future.wait([
      getPoliceContact(),
      getAmbulanceContact(),
      getEmbassyContact(),
    ]);
  }

  Future<void> getPoliceContact() async {
    if (contactBox.get('policeContact') != null &&
        location.distanceInMeters.roundToDouble() < 100) {
      if (mounted) {
        setState(() {
          policeContacts = contactBox.get('policeContact');
        });
      }
    } else {
      await emergencyRepo.getEmergencyContact(
          context: context, sosContactType: 'POLICE');

      if (mounted) {
        setState(() {
          policeContacts = contactBox.get('policeContact');
        });
      }
    }
  }

  Future<void> getAmbulanceContact() async {
    if (contactBox.get('ambulanceContact') != null &&
        location.distanceInMeters.roundToDouble() < 100) {
      if (mounted) {
        setState(() {
          ambulanceContacts = contactBox.get('ambulanceContact');
        });
      }
    } else {
      await emergencyRepo.getEmergencyContact(
          context: context, sosContactType: 'AMBULANCE');

      if (mounted) {
        setState(() {
          ambulanceContacts = contactBox.get('ambulanceContact');
        });
      }
    }
  }

  Future<void> getEmbassyContact() async {
    if (contactBox.get('embassyContact') != null &&
        location.distanceInMeters.roundToDouble() < 100) {
      if (mounted) {
        setState(() {
          embassyContacts = contactBox.get('embassyContact');
        });
      }
    } else {
      await emergencyRepo.getEmergencyContact(
          context: context, sosContactType: 'EMBASSY');

      if (mounted) {
        setState(() {
          embassyContacts = contactBox.get('embassyContact');
        });
      }
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
          title: Text(AppLocalizations.of(context).translate('directory_lbl')),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(2600),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                AnimatedCrossFade(
                  crossFadeState: policeContacts != null
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 1500),
                  firstChild: AuthoritiesButton(
                    tileFirstColor: Color(0xff08457e),
                    tileSecondColor: Color(0xff0499c7),
                    label: AppLocalizations.of(context).translate('police_lbl'),
                    onTap: () => Navigator.pushNamed(context, DIRECTORY_LIST,
                        arguments: 'POLICE'),
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
                  crossFadeState: ambulanceContacts != null
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 1500),
                  firstChild: AuthoritiesButton(
                    tileFirstColor: Color(0xffc90000),
                    tileSecondColor: Color(0xffd43b3b),
                    label:
                        AppLocalizations.of(context).translate('ambulance_lbl'),
                    onTap: () => Navigator.pushNamed(context, DIRECTORY_LIST,
                        arguments: 'AMBULANCE'),
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
                        label: AppLocalizations.of(context)
                            .translate('ambulance_lbl'),
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
                AnimatedCrossFade(
                  crossFadeState: embassyContacts != null
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 1500),
                  firstChild: AuthoritiesButton(
                    tileFirstColor: Color(0xff17ad2d),
                    tileSecondColor: Color(0xff15cf75),
                    label:
                        AppLocalizations.of(context).translate('embassy_lbl'),
                    onTap: () => Navigator.pushNamed(context, DIRECTORY_LIST,
                        arguments: 'EMBASSY'),
                  ),
                  secondChild: SizedBox(
                    width: ScreenUtil().setWidth(600),
                    height: ScreenUtil().setHeight(450),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: AuthoritiesButton(
                        tileFirstColor: Color(0xff17ad2d),
                        tileSecondColor: Color(0xff15cf75),
                        label: AppLocalizations.of(context)
                            .translate('embassy_lbl'),
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void dispose() {
    super.dispose();
  }
}
