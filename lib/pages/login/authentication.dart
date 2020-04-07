import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/api/model/language_model.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/device_info.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final AuthRepo authRepo = AuthRepo();
  final AppConfig appConfig = AppConfig();
  final LocalStorage localStorage = LocalStorage();

  DeviceInfo deviceInfo = DeviceInfo();
  // String deviceModel = '';
  // String deviceVersion = '';
  String deviceId = '';

  @override
  void initState() {
    super.initState();

    _getWsUrl();
    _setLocale();
    _checkExistingLogin();
    _getDeviceInfo();
  }

  _getWsUrl() async {
    final wsUrlBox = Hive.box('ws_url');

    // localStorage.reset();

    String wsUrl = wsUrlBox.get('wsUrl');
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    if (wsUrl == null) {
      await authRepo.getWsUrl(
        context: context,
        acctUid: caUid,
        acctPwd: caPwd,
        loginType: appConfig.wsCodeCrypt,
      );
    }
  }

  _setLocale() async {
    String locale = await localStorage.getLocale();

    if (locale == 'en') {
      Provider.of<LanguageModel>(context, listen: false).selectedLanguage(
          AppLocalizations.of(context).translate('english_lbl'));
    } else {
      Provider.of<LanguageModel>(context, listen: false).selectedLanguage(
          AppLocalizations.of(context).translate('malay_lbl'));
    }
  }

  _checkExistingLogin() async {
    String userId = await localStorage.getUserId();

    if (userId.isNotEmpty) {
      Navigator.pushReplacementNamed(context, HOME);
    } else {
      Navigator.pushReplacementNamed(context, LOGIN);
    }
  }

  _getDeviceInfo() async {
    // get device info
    await deviceInfo.getDeviceInfo();

    // deviceModel = deviceInfo.model;
    // deviceVersion = deviceInfo.version;
    deviceId = deviceInfo.id;

    localStorage.saveDeviceId(deviceId);

    // print('deviceId: ' + deviceId);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 1440,
      height: 2960,
      allowFontScaling: true,
    );

    return Scaffold(
      body: Container(),
    );
  }
}
