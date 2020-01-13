import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class EmergencyDirectory extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;

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
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: () => Navigator.pushNamed(context, DIRECTORY_LIST,
                    arguments: 'POLICE'),
                child: Text('Police'),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, DIRECTORY_LIST,
                    arguments: 'AMBULANCE'),
                child: Text('Ambulance'),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, DIRECTORY_LIST,
                    arguments: 'EMBASSY'),
                child: Text('Embassy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
