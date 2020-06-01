import 'dart:convert';
import 'package:epandu/utils/custom_button.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:epandu/services/api/model/auth_model.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../app_localizations.dart';

class RegisterUserToDi extends StatefulWidget {
  final barcode;

  RegisterUserToDi(this.barcode);

  @override
  _RegisterUserToDiState createState() => _RegisterUserToDiState();
}

class _RegisterUserToDiState extends State<RegisterUserToDi> {
  final authRepo = AuthRepo();
  final customDialog = CustomDialog();
  final image = ImagesConstant();
  final primaryColor = ColorConstant.primaryColor;
  final _formKey = GlobalKey<FormState>();

  String _bodyTemp = '';
  String _message = '';
  bool _isLoading = false;

  registerUserToDi() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FocusScope.of(context).requestFocus(new FocusNode());

      setState(() {
        _isLoading = true;
        _message = '';
      });

      ScanResponse scanResponse =
          ScanResponse.fromJson(jsonDecode(widget.barcode));

      var result = await authRepo.registerUserToDI(
        context: context,
        diCode: scanResponse.diCode,
        // name: scanResponse.name,
        nationality: scanResponse.nationality,
        // phoneCountryCode: scanResponse.phoneCountryCode,
        // phone: scanResponse.phone,
        // userId: scanResponse.userId,
        bodyTemperature: _bodyTemp,
        scanCode: widget.barcode,
      );

      if (result.isSuccess) {
        customDialog.show(
          context: context,
          title: Center(
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 120,
            ),
          ),
          content: result.message.toString(),
          barrierDismissable: false,
          customActions: <Widget>[
            FlatButton(
              child: Text(AppLocalizations.of(context).translate('ok_btn')),
              onPressed: () => Navigator.popUntil(
                context,
                ModalRoute.withName(HOME),
              ),
            )
          ],
          type: DialogType.GENERAL,
        );
      } else {
        customDialog.show(
          context: context,
          content: result.message.toString(),
          onPressed: () => Navigator.pop(context),
          type: DialogType.ERROR,
        );
      }
    }
  }

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
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: -10.h),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('body_temp'),
                          prefixIcon: Icon(Icons.phone_android),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context)
                                .translate('body_temp_required_msg');
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _bodyTemp = value;
                          });
                        },
                      ),
                    ],
                  ),
                  _message.isNotEmpty
                      ? Text(
                          _message,
                          style: TextStyle(color: Colors.red),
                        )
                      : SizedBox.shrink(),
                  _isLoading
                      ? SpinKitFoldingCube(
                          color: primaryColor,
                        )
                      : CustomButton(
                          onPressed: registerUserToDi,
                          buttonColor: Color(0xffdd0e0e),
                          title: AppLocalizations.of(context)
                              .translate('submit_btn'),
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
