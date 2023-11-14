import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/common_library/services/location.dart';
import 'package:epandu/common_library/services/repository/emergency_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

import '../../router.gr.dart';

@RoutePage(name: 'DirectoryList')
class DirectoryList extends StatefulWidget {
  final directoryType;

  const DirectoryList(this.directoryType, {super.key});

  @override
  State<DirectoryList> createState() => _DirectoryListState();
}

class _DirectoryListState extends State<DirectoryList> {
  final emergencyRepo = EmergencyRepo();
  final primaryColor = ColorConstant.primaryColor;
  final localStorage = LocalStorage();
  final location = Location();
  Future? _getDirectoryContacts;

  var maxRadius = '30';

  @override
  void initState() {
    super.initState();

    _getDirectoryContacts = _getContacts();
  }

  _getContacts() async {
    LocationPermission permission = await location.checkLocationPermission();

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      await location.getCurrentLocation();

      localStorage.saveUserLatitude(location.latitude.toString());
      localStorage.saveUserLongitude(location.longitude.toString());

      if (widget.directoryType == 'INSURANCE') {
        setState(() {
          maxRadius = '0';
        });
      }
      if (!context.mounted) return;
      var response = await emergencyRepo.getSosContactSortByNearest(
          context: context,
          sosContactType: widget.directoryType,
          maxRadius: maxRadius);

      if (mounted && response.isSuccess) {
        return response.data;
      }
      return response.message;
    } else {
      if (!context.mounted) return;
      context.router.popUntil(
        ModalRoute.withName('Home'),
      );
    }
  }

  _listItem(snapshot, index) {
    return GestureDetector(
      onTap: () {
        context.router.push(
          DirectoryDetail(snapshot: snapshot.data[index]),
        );
      },
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (snapshot.data[index].sosContactSubtype != null)
              Text(snapshot.data[index].sosContactSubtype),
            if (snapshot.data[index].areaCode != null)
              Text(snapshot.data[index].areaCode),
            if (snapshot.data[index].sosContactName != null)
              Text(snapshot.data[index].sosContactName),
            if (snapshot.data[index].phone != null)
              Text(snapshot.data[index].phone),
            Text(
                '${double.tryParse(snapshot.data[index].distance)!.toStringAsFixed(2)}km'),
            const SizedBox(height: 10.0),
            const Divider(
              height: 1.0,
              thickness: 1.0,
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  _getAppBarTitle() {
    switch (widget.directoryType) {
      case 'POLICE':
        return Text(AppLocalizations.of(context)!.translate('police_title'));
      case 'AMBULANCE':
        return Text(AppLocalizations.of(context)!.translate('ambulance_title'));
      case 'EMBASSY':
        return Text(AppLocalizations.of(context)!.translate('embassy_title'));
      case 'BOMBA':
        return Text(AppLocalizations.of(context)!.translate('bomba_title'));
      case 'INSURANCE':
        return Text(AppLocalizations.of(context)!.translate('towing_service'));
      case 'WORKSHOP':
        return Text(AppLocalizations.of(context)!.translate('workshop_cars'));
      case 'BIKEWORKSHOP':
        return Text(AppLocalizations.of(context)!.translate('workshop_bike'));
    }
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
          title: _getAppBarTitle(),
        ),
        body: FutureBuilder(
          future: _getDirectoryContacts,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 8.0),
                        blurRadius: 10.0,
                      )
                    ],
                  ),
                  child: Center(
                    child: SpinKitFoldingCube(
                      color: primaryColor,
                    ),
                  ),
                );
              case ConnectionState.done:
                if (snapshot.data is String) {
                  return Center(
                    child: Text(snapshot.data),
                  );
                }

                return Container(
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 8.0),
                        blurRadius: 10.0,
                      )
                    ],
                  ),
                  child: ListView.builder(
                    // itemCount: 10,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.data[0].sosContactType == 'POLICE' &&
                          snapshot.data[index].sosContactSubtype == 'IPD') {
                        return _listItem(snapshot, index);
                      } else if (snapshot.data[0].sosContactType ==
                              'AMBULANCE' ||
                          snapshot.data[0].sosContactType == 'EMBASSY' ||
                          snapshot.data[0].sosContactType == 'BOMBA' ||
                          snapshot.data[0].sosContactType == 'INSURANCE' ||
                          snapshot.data[0].sosContactType == 'WORKSHOP' ||
                          snapshot.data[0].sosContactType == 'BIKEWORKSHOP') {
                        return _listItem(snapshot, index);
                      }
                      return const SizedBox(height: 0, width: 0);
                    },
                  ),
                );
              default:
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!
                        .translate('get_contacts_fail'),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
