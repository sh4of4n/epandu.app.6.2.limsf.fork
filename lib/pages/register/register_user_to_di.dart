import 'package:epandu/utils/custom_button.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:epandu/services/repository/auth_repository.dart';

import '../../app_localizations.dart';

class RegisterUserToDi extends StatelessWidget {
  final data;

  RegisterUserToDi(this.data);

  final authRepo = AuthRepo();
  final customDialog = CustomDialog();
  final image = ImagesConstant();
  final primaryColor = ColorConstant.primaryColor;
  final inputStyle = TextStyle(
    fontSize: 70.sp,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              primaryColor,
            ],
            stops: [0.45, 0.85],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Image.asset(image.logo2, height: 90.h),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 130.w),
            child: Column(
              children: <Widget>[
                data.status == 'success'
                    ? Text(
                        AppLocalizations.of(context).translate('scan_success') +
                            ' ' +
                            data.barcode.qRCode[0].name +
                            ' ' +
                            AppLocalizations.of(context)
                                .translate('organisation'),
                        style: inputStyle)
                    : Text(
                        AppLocalizations.of(context).translate('scan_fail') +
                            ' ' +
                            data.barcode.qRCode[0].name +
                            ' ' +
                            AppLocalizations.of(context)
                                .translate('organisation'),
                        style: inputStyle),
                CustomButton(
                  onPressed: () => Navigator.popUntil(
                    context,
                    ModalRoute.withName(HOME),
                  ),
                  buttonColor: Color(0xffdd0e0e),
                  title: AppLocalizations.of(context).translate('ok_btn'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
