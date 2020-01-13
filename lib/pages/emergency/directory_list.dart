import 'package:epandu/services/repo/emergency_repo.dart';
import 'package:epandu/utils/constants.dart';
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

  _getContacts() async {
    var result =
        await emergencyRepo.getEmergencyContact(sosContactType: widget.data);

    if (result.isSuccess) {
      return result.data;
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
        ),
        body: FutureBuilder(
          future: _getContacts(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(snapshot.data[index].sosContactSubtype ?? ''),
                        Text(snapshot.data[index].sosContactName),
                        Text(snapshot.data[index].phone),
                      ],
                    ),
                  );
                },
              );
            }

            return Center(
              child: SpinKitFoldingCube(
                color: primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
