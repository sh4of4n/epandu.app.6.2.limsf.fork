import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/services/location.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/device_info.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:epandu/app_localizations.dart';

class LoginTabletForm extends StatefulWidget {
  @override
  _LoginTabletFormState createState() => _LoginTabletFormState();
}

class _LoginTabletFormState extends State<LoginTabletForm> with PageBaseClass {
  final authRepo = AuthRepo();

  final _formKey = GlobalKey<FormState>();

  final FocusNode _phoneFocus = FocusNode();

  final FocusNode _passwordFocus = FocusNode();

  final primaryColor = ColorConstant.primaryColor;

  final localStorage = LocalStorage();

  bool _isLoading = false;

  String _phone;
  String _password;
  String _loginMessage = '';
  bool _obscureText = true;

  // var _height = ScreenUtil().setHeight(1300);

  // var _height = ScreenUtil.screenHeight / 4.5;

  Location location = Location();
  String _latitude = '';
  String _longitude = '';

  DeviceInfo deviceInfo = DeviceInfo();
  // String _deviceModel = '';
  String _deviceVersion = '';
  String _deviceId = '';
  String _deviceOs = '';

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
    _getDeviceInfo();
  }

  _getDeviceInfo() async {
    // get device info
    await deviceInfo.getDeviceInfo();

    // _deviceModel = deviceInfo.model;
    _deviceVersion = deviceInfo.version;
    _deviceId = deviceInfo.id;
    _deviceOs = deviceInfo.os;

    // print('deviceId: ' + deviceId);
  }

  _getCurrentLocation() async {
    await location.getCurrentLocation();

    setState(() {
      _latitude =
          location.latitude != null ? location.latitude.toString() : '999';
      _longitude =
          location.longitude != null ? location.longitude.toString() : '999';
    });

    // print('$_latitude, $_longitude');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: _height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 15.0),
            blurRadius: 15.0,
          ),
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, -10.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 50.w, right: 50.w, top: 48.h, bottom: 60.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 35.h,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 35.sp,
                ),
                focusNode: _phoneFocus,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 40.h),
                  hintStyle: TextStyle(
                    color: primaryColor,
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('phone_lbl'),
                  fillColor: Colors.grey.withOpacity(.25),
                  filled: true,
                  prefixIcon: Icon(Icons.account_circle, size: 32),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onFieldSubmitted: (term) {
                  fieldFocusChange(context, _phoneFocus, _passwordFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('phone_required_msg');
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != _phone) {
                    _phone = value;
                  }
                },
              ),
              SizedBox(
                height: 50.h,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 35.sp,
                ),
                focusNode: _passwordFocus,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 40.h),
                  hintStyle: TextStyle(color: primaryColor),
                  labelText:
                      AppLocalizations.of(context).translate('password_lbl'),
                  fillColor: Colors.grey.withOpacity(.25),
                  filled: true,
                  prefixIcon: Icon(Icons.lock, size: 32),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(
                        () {
                          _obscureText = !_obscureText;
                        },
                      );
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                obscureText: _obscureText,
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('password_required_msg');
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != _password) {
                    _password = value;
                  }
                },
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, FORGOT_PASSWORD);
                    },
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('forgot_password_lbl'),
                      style: TextStyle(
                        fontSize: 35.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _loginMessage.isNotEmpty
                          ? LimitedBox(
                              maxWidth: 800.w,
                              child: Text(
                                _loginMessage,
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : SizedBox.shrink(),
                      _loginButton(),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, SIGN_UP_MOBILE);
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('sign_up_btn'),
                      style: TextStyle(
                        fontSize: 35.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loginButton() {
    return Container(
      child: _isLoading
          ? SpinKitFoldingCube(
              color: primaryColor,
            )
          : ButtonTheme(
              minWidth: 250.w,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              buttonColor: primaryColor,
              shape: StadiumBorder(),
              child: RaisedButton(
                onPressed: _submitLogin, // () => localStorage.reset(),
                textColor: Colors.white,
                child: Text(
                  AppLocalizations.of(context).translate('login_btn'),
                  style: TextStyle(
                    fontSize: 35.sp,
                  ),
                ),
              ),
            ),
    );
  }

  _submitLogin() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FocusScope.of(context).requestFocus(new FocusNode());

      setState(() {
        // _height = ScreenUtil().setHeight(1300);
        _isLoading = true;
        _loginMessage = '';
      });

      /* var result = await authRepo.login(
        context: context,
        phone: _phone,
        password: _password,
      ); */

      var result = await authRepo.login(
        context: context,
        phone: _phone,
        password: _password,
        latitude: _latitude,
        longitude: _longitude,
        deviceRemark: '$_deviceOs $_deviceVersion',
        phDeviceId: _deviceId,
      );

      if (result.isSuccess) {
        if (result.data == 'empty') {
          var getRegisteredDi =
              await authRepo.getUserRegisteredDI(context: context);

          if (getRegisteredDi.isSuccess) {
            Navigator.pushReplacementNamed(context, HOME);
          } else {
            setState(() {
              _isLoading = false;
              _loginMessage = result.message;
            });
          }
        } else if (result.data.length > 1) {
          // Navigate to DI selection page
          // Temporary navigate to home
          // Navigator.pushReplacementNamed(context, HOME);

          Navigator.pushReplacementNamed(context, SELECT_DI,
              arguments: result.data);
        } else {
          localStorage.saveDiCode(result.data[0].diCode);

          Navigator.pushReplacementNamed(context, HOME);
        }
      } else {
        setState(() {
          _isLoading = false;
          _loginMessage = result.message;
        });
      }
    } else {
      setState(() {
        // _height = ScreenUtil().setHeight(1450);
      });
    }
  }
}
