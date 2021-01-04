import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/model/provider_model.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/common_library/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/common_library/utils/language_options.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import '../../router.gr.dart';

class Menu extends StatefulWidget {
  final data;

  Menu(this.data);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
          // title: Text(AppLocalizations.of(context).translate('Menu_lbl')),
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
                  ExtendedNavigator.of(context).push(Routes.changePassword);
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
                /* onTap: () async {
                  count += 1;

                  if (count == 4) {
                    customDialog.show(
                      barrierDismissable: false,
                      context: context,
                      title: AppLocalizations.of(context)
                          .translate('client_acc_title'),
                      content: AppLocalizations.of(context)
                          .translate('client_acc_desc'),
                      type: DialogType.SUCCESS,
                      onPressed: () async {
                        Navigator.pushAndRemoveUntil(
                            context, CLIENT_ACC, (r) => false,
                            arguments: 'Menu');
                        await authRepo.logout();
                      },
                    );
                  }
                }, */
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
              if (widget.data != null) widget.data.cancel();

              ExtendedNavigator.of(context)
                  .pushAndRemoveUntil(Routes.login, (r) => false);
              await authRepo.logout(context: context);
            },
          ),
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('no_lbl')),
            onPressed: () {
              ExtendedNavigator.of(context).pop();
            },
          ),
        ],
        type: DialogType.GENERAL);
  }
}
