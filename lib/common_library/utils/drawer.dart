/* import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../router.gr.dart';
import '../services/repository/auth_repository.dart';
import 'custom_dialog.dart';

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
            title: Text(AppLocalizations.of(context).translate('language_lbl')),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              ExtendedNavigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate('settings_lbl')),
            onTap: () {
              ExtendedNavigator.of(context).push(Routes.settings);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate('logout_lbl')),
            onTap: _logout,
          )
        ],
      ),
    );
  }

  _logout() {
    customDialog.show(
        context: context,
        title: Text(AppLocalizations.of(context).translate('confirm_lbl')),
        content: AppLocalizations.of(context).translate('confirm_log_out'),
        customActions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context).translate('yes_lbl')),
            onPressed: () async {
              ExtendedNavigator.of(context)
                  .pushAndRemoveUntil(Routes.login, (r) => false);
              await authRepo.logout();
            },
          ),
          TextButton(
            child: Text(AppLocalizations.of(context).translate('no_lbl')),
            onPressed: () {
              ExtendedNavigator.of(context).pop();
            },
          ),
        ],
        type: DialogType.GENERAL);
  }
}
 */
