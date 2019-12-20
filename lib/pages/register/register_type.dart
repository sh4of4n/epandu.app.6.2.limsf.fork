import 'package:flutter/material.dart';

class RegisterType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Text('Are you registering as...'),
            GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                GridTile(
                  child: Icon(
                    Icons.account_circle,
                    size: 120,
                  ),
                  footer: Text('Normal user'),
                ),
                GridTile(
                  child: Icon(
                    Icons.directions_car,
                    size: 120,
                  ),
                  footer: Text('Institute student'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
