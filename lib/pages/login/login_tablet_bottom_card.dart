import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/model/provider_model.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/common_library/utils/language_options.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';
import '../../router.gr.dart';

class LoginTabletBottomCard extends StatefulWidget {
  @override
  _LoginTabletBottomCardState createState() => _LoginTabletBottomCardState();
}

class _LoginTabletBottomCardState extends State<LoginTabletBottomCard> {
  final customDialog = CustomDialog();
  final localStorage = LocalStorage();
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

    localStorage.saveAppVersion(appVersion);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 40.h),
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
                    style:
                        TextStyle(fontSize: 35.sp, fontWeight: FontWeight.w500),
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
                      ExtendedNavigator.of(context).pop();
                      ExtendedNavigator.of(context).push(Routes.clientAccount);
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
                      fontSize: 35.sp,
                    ),
                  ),
                  Text(
                    ': $appVersion',
                    style: TextStyle(
                      fontSize: 35.sp,
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
