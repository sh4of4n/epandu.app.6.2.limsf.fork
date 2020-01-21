import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/repo/emergency_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';

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
  final contactBox = Hive.box('emergencyContact');

  _getContacts() async {
    switch (widget.data) {
      case 'POLICE':
        return contactBox.get('policeContact');
      case 'AMBULANCE':
        return contactBox.get('ambulanceContact');
      case 'EMBASSY':
        return contactBox.get('embassyContact');
    }
  }

  _listItem(snapshot, index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DIRECTORY_DETAIL,
            arguments: snapshot.data[index]);
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(snapshot.data[index].sosContactSubtype ?? ''),
            Text(snapshot.data[index].areaCode ?? ''),
            Text(snapshot.data[index].sosContactName ?? ''),
            Text(snapshot.data[index].phone ?? ''),
            Text(snapshot.data[index].distance ?? ''),
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
          future: _getContacts(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
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
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    if (widget.data == 'POLICE' &&
                        snapshot.data[index].sosContactSubtype == 'IPD') {
                      return _listItem(snapshot, index);
                    } else if (widget.data == 'AMBULANCE' ||
                        widget.data == 'EMBASSY') {
                      return _listItem(snapshot, index);
                    }
                    return Container(height: 0, width: 0);
                  },
                ),
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
              child: Center(
                child: SpinKitFoldingCube(
                  color: primaryColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
