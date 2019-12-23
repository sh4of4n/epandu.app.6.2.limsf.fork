import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:epandu/utils/route_path.dart';

import '../../app_localizations.dart';
import 'icon_tile.dart';

class HomeMenuTiles extends StatelessWidget {
  final image = ImagesConstant();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconTile(
                tileImage: image.iconEmergency,
                title: AppLocalizations.of(context).translate('emergency_lbl'),
                tileFirstColor: Colors.teal,
                tileSecondColor: Colors.cyan,
              ),
              IconTile(
                component: KPP,
                tileImage: image.iconCampus,
                title: AppLocalizations.of(context).translate('kpp_lbl'),
                tileFirstColor: Colors.blue.shade900,
                tileSecondColor: Colors.lightBlue,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconTile(
                tileImage: image.iconProgramme,
                title: AppLocalizations.of(context).translate('payment_lbl'),
                tileFirstColor: Colors.deepPurple,
                tileSecondColor: Colors.indigoAccent,
              ),
              IconTile(
                component: INVITE,
                tileImage: image.iconProfile,
                title: AppLocalizations.of(context)
                    .translate('invite_friends_lbl'),
                tileFirstColor: Colors.red,
                tileSecondColor: Colors.orange,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
