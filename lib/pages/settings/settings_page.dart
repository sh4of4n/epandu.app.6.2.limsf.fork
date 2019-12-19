import 'package:epandu/services/repo/auth_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String appVersion = '';
  int count = 0;
  final authRepo = AuthRepo();
  final customDialog = CustomDialog();
  double _defIconSize = 30;
  final primaryColor = ColorConstant.primaryColor;

  @override
  void initState() {
    super.initState();

    _getPackageInfo();
  }

  _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade300, primaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          title: Text('Settings'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          margin: EdgeInsets.all(12.0),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.language, size: _defIconSize),
                title: Text('Language'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.lock, size: _defIconSize),
                title: Text('Change Password'),
                onTap: () {
                  Navigator.pushNamed(context, CHANGE_PASSWORD);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app, size: _defIconSize),
                title: Text('Log out'),
                onTap: _logout,
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.apps, size: _defIconSize),
                title: Text('Version'),
                subtitle: Text('V.$appVersion'),
                onTap: () async {
                  count += 1;

                  if (count == 4) {
                    LocalStorage().saveServerType('DEVP');

                    customDialog.show(
                      context: context,
                      title: 'Developer mode',
                      content: 'Developer mode has been enabled.',
                      type: DialogType.SUCCESS,
                      onPressed: () async {
                        Navigator.pushNamedAndRemoveUntil(
                            context, LOGIN, (r) => false);
                        await authRepo.logout();
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
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
