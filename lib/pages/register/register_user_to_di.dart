// import 'dart:convert';
import 'dart:convert';

import 'package:epandu/services/api/model/auth_model.dart';
import 'package:epandu/utils/custom_button.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
// import 'package:epandu/services/api/model/auth_model.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../app_localizations.dart';

class RegisterUserToDi extends StatefulWidget {
  final barcode;

  RegisterUserToDi(this.barcode);

  @override
  _RegisterUserToDiState createState() => _RegisterUserToDiState();
}

class _RegisterUserToDiState extends State<RegisterUserToDi> {
  final authRepo = AuthRepo();
  final localStorage = LocalStorage();
  final customDialog = CustomDialog();
  final image = ImagesConstant();
  final primaryColor = ColorConstant.primaryColor;
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String phoneCountryCode = '';
  String phone = '';
  String _bodyTemp = '';
  String _message = '';
  bool _isLoading = false;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    /* ScanResponse scanResponse =
        ScanResponse.fromJson(jsonDecode(widget.barcode));

    setState(() {
      name = scanResponse.qRCode[0].name;
      phone = scanResponse.qRCode[0].phone;
    }); */

    nameController.addListener(nameValue);
    phoneController.addListener(phoneValue);

    _getData();
  }

  nameValue() {
    setState(() {
      name = nameController.text;
    });
  }

  phoneValue() {
    setState(() {
      phone = phoneController.text;
    });
  }

  _getData() async {
    // String getPhoneCountryCode = await localStorage.getCountryCode();
    String getPhone = await localStorage.getUserPhone();
    String getName = await localStorage.getUsername();

    setState(() {
      // phoneCountryCode = getPhoneCountryCode;
      phoneController.text = getPhone;
      // gender = getGender;
      nameController.text = getName;
    });
  }

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
        diCode: scanResponse.qRCode[0].merchantDbCode,
        // name: scanResponse.qRCode[0].name,
        // nationality: scanResponse.nationality,
        // phoneCountryCode: scanResponse.qRCode[0].phoneCountryCode,
        // phone: scanResponse.qRCode[0].phone,
        // userId: scanResponse.userId,
        bodyTemperature: _bodyTemp,
        scanCode: widget.barcode,
      );

      if (result.isSuccess) {
        Navigator.popUntil(context, ModalRoute.withName(HOME));
        /* customDialog.show(
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
        ); */
      } else {
        customDialog.show(
          context: context,
          content: result.message.toString(),
          onPressed: () => Navigator.pop(context),
          type: DialogType.ERROR,
        );
      }

      setState(() {
        _isLoading = false;
      });
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
                        enabled: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: -10.h),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('date_time'),
                          prefixIcon: Icon(Icons.phone_android),
                        ),
                        initialValue: DateFormat('yyyy/MM/dd:HH:mm')
                            .format(DateTime.now()),
                      ),
                      SizedBox(height: 50.h),
                      TextFormField(
                        controller: nameController,
                        enabled: false,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: -10.h),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('name_lbl'),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      TextFormField(
                        controller: phoneController,
                        enabled: false,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: -10.h),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('phone_lbl'),
                          prefixIcon: Icon(Icons.phone_android),
                        ),
                      ),
                      SizedBox(height: 50.h),
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
                          prefixIcon: Icon(Icons.people),
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
