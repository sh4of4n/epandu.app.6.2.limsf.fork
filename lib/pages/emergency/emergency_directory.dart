import 'package:epandu/services/location.dart';
import 'package:epandu/services/repo/emergency_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../app_localizations.dart';
import 'authorities_button.dart';

class EmergencyDirectory extends StatefulWidget {
  @override
  _EmergencyDirectoryState createState() => _EmergencyDirectoryState();
}

class _EmergencyDirectoryState extends State<EmergencyDirectory> {
  final primaryColor = ColorConstant.primaryColor;
  // final contactBox = Hive.box('emergencyContact');
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

  @override
  void dispose() {
    super.dispose();
  }

  _getContacts() async {
    // location.distanceInMeters =
    //     await contactBox.get('distanceInMetersDirectory');

    Future.wait([
      getPoliceContact(),
      getAmbulanceContact(),
      getEmbassyContact(),
    ]);

    // distance in emergency directory will be 0.0
    // emergency directory will not be refreshed unless user is at new location
    // contactBox.put('distanceInMetersDirectory', 0.0);
  }

  Future<void> getPoliceContact() async {
    var response = await emergencyRepo.getSosContactSortByNearest(
        context: context, sosContactType: 'POLICE');

    if (mounted && response.isSuccess) {
      setState(() {
        policeContacts = response.data;
      });
    }
  }

  Future<void> getAmbulanceContact() async {
    var response = await emergencyRepo.getSosContactSortByNearest(
        context: context, sosContactType: 'AMBULANCE');

    if (mounted && response.isSuccess) {
      setState(() {
        ambulanceContacts = response.data;
      });
    }
  }

  Future<void> getEmbassyContact() async {
    var response = await emergencyRepo.getSosContactSortByNearest(
        context: context, sosContactType: 'EMBASSY');

    if (mounted && response.isSuccess) {
      setState(() {
        embassyContacts = response.data;
      });
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
                        arguments: policeContacts),
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
                        arguments: ambulanceContacts),
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
                        arguments: embassyContacts),
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
}
