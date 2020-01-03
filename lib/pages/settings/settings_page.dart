import 'package:epandu/services/api/model/language_model.dart';
import 'package:epandu/services/repo/auth_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/language_options.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';

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
  final localStorage = LocalStorage();

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
          title: Text(AppLocalizations.of(context).translate('settings_lbl')),
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
                title: Consumer<LanguageModel>(
                  builder: (context, lang, child) {
                    return Text(
                      '${AppLocalizations.of(context).translate('language_lbl')} ${lang.language}',
                    );
                  },
                ),
                onTap: () {
                  // Navigator.pop(context);
                  return showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return LanguageOptions();
                    },
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.lock, size: _defIconSize),
                title: Text(AppLocalizations.of(context)
                    .translate('change_password_lbl')),
                onTap: () {
                  Navigator.pushNamed(context, CHANGE_PASSWORD);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app, size: _defIconSize),
                title:
                    Text(AppLocalizations.of(context).translate('logout_lbl')),
                onTap: _logout,
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.apps, size: _defIconSize),
                title:
                    Text(AppLocalizations.of(context).translate('version_lbl')),
                subtitle: Text('V.$appVersion'),
                onTap: () async {
                  count += 1;
                  String serverType = await localStorage.getServerType();

                  if (count == 4 && serverType == 'PROD') {
                    customDialog.show(
                      barrierDismissable: false,
                      context: context,
                      title: AppLocalizations.of(context)
                          .translate('developer_title'),
                      content: AppLocalizations.of(context)
                          .translate('developer_desc'),
                      type: DialogType.SUCCESS,
                      onPressed: () async {
                        Navigator.pushNamedAndRemoveUntil(
                            context, CLIENT_ACC, (r) => false,
                            arguments: 'SETTINGS');
                        await authRepo.logout();
                      },
                    );
                  } else if (count == 4 && serverType == 'DEVP') {
                    customDialog.show(
                      barrierDismissable: false,
                      context: context,
                      title: AppLocalizations.of(context)
                          .translate('production_title'),
                      content: AppLocalizations.of(context)
                          .translate('production_desc'),
                      type: DialogType.SUCCESS,
                      onPressed: () async {
                        Navigator.pushNamedAndRemoveUntil(
                            context, LOGIN, (r) => false);
                        await authRepo.logout();

                        localStorage.saveServerType('PROD');
                        localStorage.saveCaUid('epandu_prod');
                        localStorage.saveCaPwd('vWh7SmgDRJ%TW4xa');
                        localStorage.saveCaPwdEncode('vWh7SmgDRJ%25TW4xa');
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
        title: Text(AppLocalizations.of(context).translate('confirm_lbl')),
        content: AppLocalizations.of(context).translate('confirm_log_out'),
        customActions: <Widget>[
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('yes_lbl')),
            onPressed: () async {
              Navigator.pushNamedAndRemoveUntil(context, LOGIN, (r) => false);
              await authRepo.logout();
            },
          ),
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('no_lbl')),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        type: DialogType.GENERAL);
  }
}
