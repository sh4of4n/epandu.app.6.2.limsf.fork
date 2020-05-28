import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/repository/emergency_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DirectoryList extends StatefulWidget {
  final data;

  DirectoryList(this.data);

  @override
  _DirectoryListState createState() => _DirectoryListState();
}

class _DirectoryListState extends State<DirectoryList> {
  final emergencyRepo = EmergencyRepo();
  final primaryColor = ColorConstant.primaryColor;
  final localStorage = LocalStorage();
  Future _getDirectoryContacts;

  var maxRadius = '30';

  @override
  void initState() {
    super.initState();

    _getDirectoryContacts = _getContacts();
  }

  _getContacts() async {
    if (widget.data == 'INSURANCE')
      setState(() {
        maxRadius = '0';
      });

    var response = await emergencyRepo.getSosContactSortByNearest(
        context: context, sosContactType: widget.data, maxRadius: maxRadius);

    if (mounted && response.isSuccess) {
      return response.data;
    }
    return response.message;
  }

  _listItem(snapshot, index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DIRECTORY_DETAIL,
            arguments: snapshot.data[index]);
      },
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(snapshot.data[index].sosContactSubtype ?? ''),
            Text(snapshot.data[index].areaCode ?? ''),
            Text(snapshot.data[index].sosContactName ?? ''),
            Text(snapshot.data[index].phone ?? ''),
            Text(double.tryParse(snapshot.data[index].distance)
                        .toStringAsFixed(2) +
                    'km' ??
                'No distance data'),
            SizedBox(height: 10.0),
            Divider(
              height: 1.0,
              thickness: 1.0,
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  _getAppBarTitle() {
    switch (widget.data) {
      case 'POLICE':
        return Text(AppLocalizations.of(context).translate('police_title'));
      case 'AMBULANCE':
        return Text(AppLocalizations.of(context).translate('ambulance_title'));
      case 'EMBASSY':
        return Text(AppLocalizations.of(context).translate('embassy_title'));
      case 'BOMBA':
        return Text(AppLocalizations.of(context).translate('bomba_title'));
      case 'INSURANCE':
        return Text(AppLocalizations.of(context).translate('towing_service'));
      case 'WORKSHOP':
        return Text(AppLocalizations.of(context).translate('workshop_cars'));
      case 'BIKEWORKSHOP':
        return Text(AppLocalizations.of(context).translate('workshop_bike'));
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
          title: _getAppBarTitle(),
        ),
        body: FutureBuilder(
          future: _getDirectoryContacts,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  padding: EdgeInsets.all(15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
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
                  padding: EdgeInsets.all(15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
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
                      return Container(height: 0, width: 0);
                    },
                  ),
                );
              default:
                return Center(
                  child: Text(
                    AppLocalizations.of(context).translate('get_contacts_fail'),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
