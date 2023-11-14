import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/router.gr.dart';
import 'package:epandu/common_library/services/model/provider_model.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/constants.dart';

import 'package:epandu/common_library/utils/device_info.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../chat/chatnotification_count.dart';
import '../chat/socketclient_helper.dart';

@RoutePage()
class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final AuthRepo authRepo = AuthRepo();
  final AppConfig appConfig = AppConfig();
  final primaryColor = ColorConstant.primaryColor;
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
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();

    // if (wsUrl == null) {
    if (Hive.box('ws_url').get('getWsUrl') == '1' ||
        Hive.box('ws_url').get('getWsUrl') == null) {
      if (!context.mounted) return;
      await authRepo.getWsUrl(
        context: context,
        acctUid: caUid,
        acctPwd: caPwd,
        loginType: appConfig.wsCodeCrypt,
      );
    }
    // }

    _checkExistingLogin();
  }

  _setLocale() async {
    String? locale = await localStorage.getLocale();
    if (!context.mounted) return;
    if (locale == 'en') {
      Provider.of<LanguageModel>(context, listen: false).selectedLanguage(
          AppLocalizations.of(context)!.translate('english_lbl'));
    } else {
      Provider.of<LanguageModel>(context, listen: false).selectedLanguage(
          AppLocalizations.of(context)!.translate('malay_lbl'));
    }
  }

  _checkExistingLogin() async {
    String? userId = await localStorage.getUserId();
    String? diCode = await localStorage.getMerchantDbCode();

    if (userId != null && userId.isNotEmpty && diCode!.isNotEmpty) {
      if (!context.mounted) return;
      {
        context.read<SocketClientHelper>().loginUserRoom();
      }

      if (!context.mounted) return;
      context.router.replace(const Home());
    } else if (userId != null && userId.isNotEmpty && diCode!.isEmpty) {
      if (!context.mounted) return;
      Provider.of<ChatNotificationCount>(context, listen: false)
          .clearNotificationBadge();
      context.read<SocketClientHelper>().logoutUserRoom();
      if (!context.mounted) return;
      await authRepo.logout(context: context, type: '');
      if (!context.mounted) return;
      context.router.replace(const Login());
    } else {
      if (!context.mounted) return;
      context.router.replace(const Login());
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(1440, 2960),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.amber.shade50,
              Colors.amber.shade100,
              Colors.amber.shade200,
              Colors.amber.shade300,
              primaryColor
            ],
            stops: const [0.2, 0.4, 0.6, 0.7, 1],
            radius: 0.7,
          ),
        ),
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
            const SpinKitThreeBounce(
              color: Color(0xFFED3833),
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
