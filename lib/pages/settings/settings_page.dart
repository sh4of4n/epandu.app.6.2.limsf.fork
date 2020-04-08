import 'package:epandu/services/api/model/language_model.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/language_options.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';

class Settings extends StatefulWidget {
  final data;

  Settings(this.data);

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

  bool _isLoading = false;

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
    return Stack(
      children: <Widget>[
        Container(
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
                onTap: () async {
                  count += 1;

                  if (count == 4) {
                    customDialog.show(
                      context: context,
                      title: Text(AppLocalizations.of(context)
                          .translate('delete_account')),
                      content: AppLocalizations.of(context)
                          .translate('confirm_delete_account'),
                      customActions: <Widget>[
                        FlatButton(
                          child: Text(AppLocalizations.of(context)
                              .translate('yes_lbl')),
                          onPressed: _deleteAccount,
                        ),
                        FlatButton(
                          child: Text(
                              AppLocalizations.of(context).translate('no_lbl')),
                          onPressed: () {
                            count = 0;
                            Navigator.pop(context);
                          },
                        ),
                      ],
                      type: DialogType.GENERAL,
                      barrierDismissable: true,
                    );
                  }
                },
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
                          Navigator.pushNamedAndRemoveUntil(
                              context, CLIENT_ACC, (r) => false,
                              arguments: 'SETTINGS');
                          await authRepo.logout();
                        },
                      );
                    }
                  }, */
              ),
            ],
          ),
        ),
        Visibility(
          visible: _isLoading,
          child: Opacity(
            opacity: 0.7,
            child: Container(
              color: Colors.grey[900],
              width: ScreenUtil.screenWidthDp,
              height: ScreenUtil.screenHeightDp,
              child: Center(
                child: SpinKitFoldingCube(
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
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

              Navigator.pushNamedAndRemoveUntil(context, LOGIN, (r) => false);
              await authRepo.logout(context: context);
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

  _deleteAccount() async {
    Navigator.pop(context);

    setState(() {
      _isLoading = true;
    });

    var result = await authRepo.deleteAppMemberAccount(context: context);

    if (result.isSuccess) {
      Navigator.pushNamedAndRemoveUntil(context, LOGIN, (r) => false);
    } else {
      customDialog.show(
        context: context,
        type: DialogType.ERROR,
        content: result.message.toString(),
        onPressed: () => Navigator.pop(context),
      );
    }
  }
}
