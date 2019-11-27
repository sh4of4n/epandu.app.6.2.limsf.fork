import 'package:flutter/material.dart';

import 'icon_tile.dart';

class HomeMenuTiles extends StatelessWidget {
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
                  title: 'Kecemasan',
                  tileFirstColor: Colors.amber,
                  tileSecondColor: Colors.amber.shade200),
              IconTile(
                title: 'KPP',
                tileFirstColor: Colors.blue.shade600,
                tileSecondColor: Colors.blue.shade300,
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
                title: 'Payment',
                tileFirstColor: Colors.deepPurple,
                tileSecondColor: Colors.deepPurple.shade300,
              ),
              IconTile(
                title: 'Invite Friends',
                tileFirstColor: Colors.orange.shade400,
                tileSecondColor: Colors.orange.shade200,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
