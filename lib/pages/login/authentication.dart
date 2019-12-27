import 'package:epandu/services/api/model/auth_model.dart';
import 'package:epandu/services/api/model/credentials_model.dart';
import 'package:epandu/services/repo/auth_repo.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final AuthRepo authRepo = AuthRepo();
  final AppConfig appConfig = AppConfig();
  final LocalStorage localStorage = LocalStorage();

  @override
  void initState() {
    super.initState();

    _getWsUrl();
    _checkExistingLogin();
  }

  _getWsUrl() async {
    // localStorage.reset();

    await appConfig.getCredentials(); // get client acc credentials
    String wsUrl = await localStorage.getWsUrl();

    print(Provider.of<CredentialsModel>(context).caUid);

    if (wsUrl.isEmpty) {
      await authRepo.getWsUrl(
        acctUid: Provider.of<CredentialsModel>(context).caUid,
        acctPwd: Provider.of<CredentialsModel>(context).caPwd,
        loginType: Provider.of<CredentialsModel>(context).wsCodeCrypt,
      );
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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 1440, height: 2960, allowFontScaling: true);

    return Scaffold(
      body: Container(),
    );
  }
}
