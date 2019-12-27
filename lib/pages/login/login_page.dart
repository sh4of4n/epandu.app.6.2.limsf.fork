import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/api/model/language_model.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/language_options.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'login_form.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final primaryColor = ColorConstant.primaryColor;
  final localStorage = LocalStorage();
  final customDialog = CustomDialog();
  int count = 0;
  String appVersion = '';

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.amber.shade50,
              Colors.amber.shade100,
              Colors.amber.shade200,
              Colors.amber.shade300,
              primaryColor
            ],
            stops: [0.2, 0.4, 0.6, 0.7, 1],
            radius: 0.7,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Image.asset(
                      ImagesConstant().logo,
                      width: ScreenUtil.getInstance().setWidth(1000),
                      height: ScreenUtil.getInstance().setHeight(600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0, right: 40.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(120),
                        ),
                        LoginForm(),
                      ],
                    ),
                  ),
                  Container(
                    height: ScreenUtil().setHeight(700),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            return showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return LanguageOptions();
                              },
                            );
                          },
                          child: Text(
                            '${AppLocalizations.of(context).translate('language_lbl')} ${Provider.of<LanguageModel>(context).language}',
                            style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(56),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        GestureDetector(
                          onTap: () {
                            count += 1;

                            if (count == 6) {
                              customDialog.show(
                                context: context,
                                title: AppLocalizations.of(context)
                                    .translate('developer_title'),
                                content: AppLocalizations.of(context)
                                    .translate('developer_desc'),
                                type: DialogType.SUCCESS,
                                onPressed: () async {
                                  count = 0;
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, CLIENT_ACC);
                                },
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate('version_lbl'),
                                style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(52),
                                ),
                              ),
                              Text(
                                ': $appVersion',
                                style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(52),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
