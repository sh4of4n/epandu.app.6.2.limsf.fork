import 'package:epandu/app_localizations.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/services/location.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/custom_snackbar.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterForm extends StatefulWidget {
  final data;

  RegisterForm(this.data);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> with PageBaseClass {
  final authRepo = AuthRepo();
  final customDialog = CustomDialog();

  final _formKey = GlobalKey<FormState>();

  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final primaryColor = ColorConstant.primaryColor;

  final localStorage = LocalStorage();
  Location location = Location();

  bool _isLoading = false;
  final image = ImagesConstant();

  String _phone = '';
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _message = '';
  String _latitude = '';
  String _longitude = '';

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();

    setState(() {
      _phone = widget.data.phoneCountryCode + widget.data.phone;
    });

    _getCurrentLocation();
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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              primaryColor,
            ],
            stops: [0.60, 0.90],
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
          body: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 130.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: ScreenUtil().setHeight(35),
                      ),
                      TextFormField(
                        focusNode: _phoneFocus,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        enabled: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: -10.h),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('login_id'),
                          prefixIcon: Icon(Icons.phone_android),
                        ),
                        onFieldSubmitted: (term) {
                          fieldFocusChange(context, _phoneFocus, _nameFocus);
                        },
                        initialValue: _phone,
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context)
                                .translate('phone_required_msg');
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value != _phone) {
                            _phone = value;
                          }
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(70),
                      ),
                      TextFormField(
                        focusNode: _nameFocus,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: -10.h),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('nick_name_lbl'),
                          prefixIcon: Icon(Icons.account_circle),
                        ),
                        onFieldSubmitted: (term) {
                          fieldFocusChange(context, _nameFocus, _emailFocus);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context)
                                .translate('name_required_msg');
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value != _name) {
                            _name = value;
                          }
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(70),
                      ),
                      TextFormField(
                        focusNode: _emailFocus,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: -10.h),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('email_lbl'),
                          prefixIcon: Icon(Icons.mail),
                        ),
                        onFieldSubmitted: (term) {
                          fieldFocusChange(
                              context, _emailFocus, _passwordFocus);
                        },
                        /* validator: (value) {
                          if (value.isEmpty) {
                            return 'Email is required.';
                          }
                        }, */
                        onChanged: (value) {
                          if (value != _email) {
                            _email = value;
                          }
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(70),
                      ),
                      TextFormField(
                        focusNode: _passwordFocus,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: -10.h),
                          hintStyle: TextStyle(color: primaryColor),
                          labelText: AppLocalizations.of(context)
                              .translate('password_lbl'),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(
                                () {
                                  _obscurePassword = !_obscurePassword;
                                },
                              );
                            },
                          ),
                        ),
                        obscureText: _obscurePassword,
                        onFieldSubmitted: (term) {
                          fieldFocusChange(
                              context, _passwordFocus, _confirmPasswordFocus);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context)
                                .translate('password_required_msg');
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value != _password) {
                            _password = value;
                          }
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(70),
                      ),
                      TextFormField(
                        focusNode: _confirmPasswordFocus,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: -10.h),
                          hintStyle: TextStyle(color: primaryColor),
                          labelText: AppLocalizations.of(context)
                              .translate('confirm_password'),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(
                                () {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                },
                              );
                            },
                          ),
                        ),
                        obscureText: _obscureConfirmPassword,
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context)
                                .translate('confirm_password_required');
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value != _confirmPassword) {
                            _confirmPassword = value;
                          }
                        },
                      ),
                      SizedBox(height: 40.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _message.isNotEmpty
                              ? Text(
                                  _message,
                                  style: TextStyle(color: Colors.red),
                                )
                              : SizedBox.shrink(),
                          _signUpButton(),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(40),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _signUpButton() {
    return Container(
      alignment: Alignment.center,
      child: _isLoading
          ? SpinKitFoldingCube(
              color: primaryColor,
            )
          : ButtonTheme(
              padding: EdgeInsets.all(0.0),
              shape: StadiumBorder(),
              child: RaisedButton(
                onPressed: _submit,
                color: Color(0xffdd0e0e),
                textColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  child: Text(
                    AppLocalizations.of(context).translate('sign_up_btn'),
                    style: TextStyle(
                      fontSize: 56.sp,
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FocusScope.of(context).requestFocus(new FocusNode());

      setState(() {
        _isLoading = true;
        _message = '';
      });

      if (_password == _confirmPassword) {
        var result = await authRepo.register(
          context: context,
          countryCode: widget.data.phoneCountryCode,
          phone: widget.data.phone,
          name: _name,
          signUpPwd: _password,
          email: _email,
          latitude: _latitude,
          longitude: _longitude,
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
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, LOGIN, (r) => false),
              ),
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

        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _message =
              AppLocalizations.of(context).translate('password_not_match_msg');
          _isLoading = false;
        });
      }
    }
  }
}
