import 'package:auto_route/auto_route.dart';
import 'package:epandu/router.gr.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_button.dart';
import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class PackageDetail extends StatelessWidget {
  final String packageCode;
  final String packageDesc;

  PackageDetail(this.packageCode, this.packageDesc);

  final primaryColor = ColorConstant.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('enroll_lbl'),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  onPressed: () {},
                  buttonColor: primaryColor,
                  title: 'Enquiry',
                ),
                CustomButton(
                  onPressed: () => ExtendedNavigator.of(context)
                      .push(Routes.enrollConfirmation),
                  buttonColor: primaryColor,
                  title: 'Enroll',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
