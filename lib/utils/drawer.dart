import 'package:epandu/services/repo/auth_repo.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

enum AppState { free, picked, cropped }

class _DrawerMenuState extends State<DrawerMenu> {
  final authRepo = AuthRepo();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Log out'),
            onTap: _logout,
          )
        ],
      ),
    );
  }

  _logout() async {
    Navigator.pushNamedAndRemoveUntil(context, LOGIN, (r) => false);
    await authRepo.logout();
  }
}
