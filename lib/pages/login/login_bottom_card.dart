import 'package:epandu/services/api/model/language_model.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/language_options.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';

class LoginBottomCard extends StatefulWidget {
  @override
  _LoginBottomCardState createState() => _LoginBottomCardState();
}

class _LoginBottomCardState extends State<LoginBottomCard> {
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
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(40)),
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
              child: Consumer<LanguageModel>(
                builder: (context, lang, child) {
                  return Text(
                    '${AppLocalizations.of(context).translate('language_lbl')} ${lang.language}',
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(56),
                        fontWeight: FontWeight.w500),
                  );
                },
              ),
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () async {
                count += 1;

                if (count == 4) {
                  customDialog.show(
                    context: context,
                    title: AppLocalizations.of(context)
                        .translate('client_acc_title'),
                    content: AppLocalizations.of(context)
                        .translate('client_acc_desc'),
                    type: DialogType.SUCCESS,
                    barrierDismissable: false,
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
                    AppLocalizations.of(context).translate('version_lbl'),
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
    );
  }
}
