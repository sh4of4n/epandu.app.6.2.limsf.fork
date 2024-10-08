import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/model/provider_model.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/common_library/utils/device_info.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/common_library/utils/language_options.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:epandu/common_library/utils/loading_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import '../../router.gr.dart';
import '../chat/socketclient_helper.dart';

class Settings extends StatefulWidget {
  final data;

  const Settings(this.data, {super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  DeviceInfo deviceInfo = DeviceInfo();
  String? _deviceBrand = '';
  String? _deviceModel = '';
  String? deviceVersion = '';
  String? _deviceId;
  String? deviceOs = '';

  String? _regId = '';

  String appVersion = '';
  int count = 0;
  final authRepo = AuthRepo();
  final customDialog = CustomDialog();
  final double _defIconSize = 30;
  final primaryColor = ColorConstant.primaryColor;
  final localStorage = LocalStorage();
  String? _clientAcc = '';

  bool _isLoading = false;

  bool isDebug = false;

  @override
  void initState() {
    super.initState();

    _getPackageInfo();
    _getDeviceInfo();
  }

  _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // get client acc
    _clientAcc = await localStorage.getCaUid();

    setState(() {
      appVersion = packageInfo.version;
    });
  }

  _getDeviceInfo() async {
    // get device info
    await deviceInfo.getDeviceInfo();

    _regId = await Hive.box('ws_url').get('push_token');

    _deviceBrand = deviceInfo.manufacturer;
    _deviceModel = deviceInfo.model;
    deviceVersion = deviceInfo.version;
    // _deviceId = deviceInfo.id;
    _deviceId = await localStorage.getLoginDeviceId();
    deviceOs = deviceInfo.os;

    // print('deviceId: ' + deviceId);
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
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          margin: const EdgeInsets.all(12.0),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.language, size: _defIconSize),
                title: Consumer<LanguageModel>(
                  builder: (context, lang, child) {
                    return Text(
                      '${AppLocalizations.of(context)!.translate('language_lbl')} ${lang.language}',
                    );
                  },
                ),
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return LanguageOptions();
                  },
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.lock, size: _defIconSize),
                title: Text(AppLocalizations.of(context)!
                    .translate('change_password_lbl')),
                onTap: () {
                  context.router.push(const ChangePassword());
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app, size: _defIconSize),
                title:
                    Text(AppLocalizations.of(context)!.translate('logout_lbl')),
                onTap: _logout,
              ),
              const Divider(),
              ListTile(
                onLongPress: () {
                  setState(() {
                    isDebug = true;
                  });
                },
                onTap: () async {
                  count += 1;

                  if (count == 4) {
                    customDialog.show(
                      context: context,
                      title: Text(AppLocalizations.of(context)!
                          .translate('delete_account')),
                      content: AppLocalizations.of(context)!
                          .translate('confirm_delete_account'),
                      customActions: <Widget>[
                        TextButton(
                          onPressed: _deleteAccount,
                          child: Text(AppLocalizations.of(context)!
                              .translate('yes_lbl')),
                        ),
                        TextButton(
                          child: Text(AppLocalizations.of(context)!
                              .translate('no_lbl')),
                          onPressed: () {
                            count = 0;
                            context.router.pop();
                          },
                        ),
                      ],
                      type: DialogType.general,
                      barrierDismissable: true,
                    );
                  }
                },
                leading: Icon(Icons.apps, size: _defIconSize),
                title: Text(
                    AppLocalizations.of(context)!.translate('version_lbl')),
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
                              arguments: 'SETTINGS');
                          await authRepo.logout();
                        },
                      );
                    }
                  }, */
              ),
              isDebug
                  ? Column(
                      children: [
                        const Divider(),
                        ListTile(
                          leading: Icon(Icons.code, size: _defIconSize),
                          title: Text(AppLocalizations.of(context)!
                              .translate('client_acc')),
                          subtitle: Text(_clientAcc!),
                        ),
                        const Divider(),
                        ListTile(
                          leading: Icon(Icons.code, size: _defIconSize),
                          title: const Text('Device ID'),
                          subtitle: SelectableText(_deviceId ?? ''),
                        ),
                        const Divider(),
                        ListTile(
                          leading: Icon(Icons.code, size: _defIconSize),
                          title: const Text('Reg ID'),
                          subtitle: SelectableText(_regId ?? ''),
                        ),
                        const Divider(),
                        ListTile(
                          leading: Icon(Icons.code, size: _defIconSize),
                          title: const Text('Model'),
                          subtitle:
                              SelectableText('$_deviceBrand $_deviceModel'),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        LoadingModel(isVisible: _isLoading, color: primaryColor),
      ],
    );
  }

  _logout() {
    customDialog.show(
        context: context,
        title: Text(AppLocalizations.of(context)!.translate('confirm_lbl')),
        content: AppLocalizations.of(context)!.translate('confirm_log_out'),
        customActions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context)!.translate('yes_lbl')),
            onPressed: () async {
              // if (widget.data != null) widget.data.cancel();

              setState(() {
                _isLoading = true;
              });

              context.router.pop();             
              context.read<SocketClientHelper>().disconnectSocket();
              if (!context.mounted) return;
              await authRepo.logout(context: context, type: 'CLEAR');
              if (!context.mounted) return;
              context.router
                  .pushAndPopUntil(const Login(), predicate: (r) => false);

              setState(() {
                _isLoading = false;
              });
            },
          ),
          TextButton(
            child: Text(AppLocalizations.of(context)!.translate('no_lbl')),
            onPressed: () {
              context.router.pop();
            },
          ),
        ],
        type: DialogType.general);
  }

  _deleteAccount() async {
    context.router.pop();

    setState(() {
      _isLoading = true;
    });

    var result = await authRepo.deleteAppMemberAccount(context: context);

    if (result.isSuccess) {
      if (!context.mounted) return;
      context.router.pushAndPopUntil(const Login(), predicate: (r) => false);
    } else {
      if (!context.mounted) return;
      customDialog.show(
        context: context,
        type: DialogType.error,
        content: result.message.toString(),
        onPressed: () => context.router.pop(),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
