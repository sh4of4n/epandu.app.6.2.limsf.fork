import 'package:auto_route/auto_route.dart';
import 'package:epandu/app_localizations.dart';
import 'package:epandu/router.gr.dart';
import 'package:epandu/common_library/services/model/provider_model.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/common_library/utils/app_config.dart';
import 'package:epandu/common_library/utils/constants.dart';

import 'package:epandu/common_library/utils/device_info.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final AuthRepo authRepo = AuthRepo();
  final AppConfig appConfig = AppConfig();
  final LocalStorage localStorage = LocalStorage();
  final image = ImagesConstant();

  DeviceInfo deviceInfo = DeviceInfo();
  String deviceModel = '';
  String deviceVersion = '';
  String deviceId = '';

  @override
  void initState() {
    super.initState();

    _getWsUrl();
    _setLocale();
  }

  _getWsUrl() async {
    // final wsUrlBox = Hive.box('ws_url');

    // localStorage.reset();

    // String wsUrl = wsUrlBox.get('wsUrl');
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    // if (wsUrl == null) {
    await authRepo.getWsUrl(
      context: context,
      acctUid: caUid,
      acctPwd: caPwd,
      loginType: appConfig.wsCodeCrypt,
    );
    // }

    _checkExistingLogin();
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
    String diCode = await localStorage.getDiCode();

    if (userId.isNotEmpty && diCode.isNotEmpty) {
      ExtendedNavigator.of(context).replace(Routes.home);
    } else if (userId.isNotEmpty && diCode.isEmpty) {
      await authRepo.logout(context: context, type: '');

      ExtendedNavigator.of(context).replace(Routes.login);
    } else {
      ExtendedNavigator.of(context).replace(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(1440, 2960),
      allowFontScaling: true,
    );

    return Scaffold(
      backgroundColor: ColorConstant.primaryColor,
      body: Container(
        height: ScreenUtil().screenHeight,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* FadeInImage(
              alignment: Alignment.center,
              placeholder: MemoryImage(kTransparentImage),
              image: AssetImage(
                image.logo2,
              ),
            ), */
            Image.asset(image.logo2),
            SpinKitThreeBounce(
              color: Color(0xFF3696A8),
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
