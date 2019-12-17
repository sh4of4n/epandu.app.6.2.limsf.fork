import 'package:epandu/services/repo/auth_repo.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

enum AppState { free, picked, cropped }

class _DrawerMenuState extends State<DrawerMenu> {
  final authRepo = AuthRepo();
  final customDialog = CustomDialog();

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
            child: Container(),
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
          ),
          ListTile(
            title: Text('Language'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, SETTINGS);
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

  _logout() {
    customDialog.show(
        context: context,
        title: Text('Confirm'),
        content: 'Are you sure you want to log out?',
        customActions: <Widget>[
          FlatButton(
            child: Text("Yes"),
            onPressed: () async {
              Navigator.pushNamedAndRemoveUntil(context, LOGIN, (r) => false);
              await authRepo.logout();
            },
          ),
          FlatButton(
            child: Text("No"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        type: DialogType.GENERAL);
  }
}
