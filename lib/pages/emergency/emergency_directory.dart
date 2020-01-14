import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';

import '../../app_localizations.dart';
import 'authorities_button.dart';

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              AuthoritiesButton(
                tileFirstColor: Color(0xff08457e),
                tileSecondColor: Color(0xff0499c7),
                label: AppLocalizations.of(context).translate('police_lbl'),
                onTap: () => Navigator.pushNamed(context, DIRECTORY_LIST,
                    arguments: 'POLICE'),
              ),
              AuthoritiesButton(
                tileFirstColor: Color(0xffc90000),
                tileSecondColor: Color(0xffd43b3b),
                label: AppLocalizations.of(context).translate('ambulance_lbl'),
                onTap: () => Navigator.pushNamed(context, DIRECTORY_LIST,
                    arguments: 'AMBULANCE'),
              ),
              AuthoritiesButton(
                tileFirstColor: Color(0xff17ad2d),
                tileSecondColor: Color(0xff15cf75),
                label: AppLocalizations.of(context).translate('embassy_lbl'),
                onTap: () => Navigator.pushNamed(context, DIRECTORY_LIST,
                    arguments: 'EMBASSY'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
