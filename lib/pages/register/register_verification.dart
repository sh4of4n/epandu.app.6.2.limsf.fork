import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiver/async.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';
import '../../router.gr.dart';

class RegisterVerification extends StatefulWidget {
  final data;

  RegisterVerification(this.data);

  @override
  _RegisterVerificationState createState() => _RegisterVerificationState();
}

class _RegisterVerificationState extends State<RegisterVerification> {
  final primaryColor = ColorConstant.primaryColor;
  final authRepo = AuthRepo();
  final image = ImagesConstant();
  final _formKey = GlobalKey<FormState>();

  String _verificationCode = '';
  String? _correctVerificationCode = '';
  String? _message = '';
  TextStyle? _messageStyle;
  bool _isLoading = false;
  bool _resend = false;

  int _time = 60;
  int _current = 60;
  String convertedCountdown = '';
  var timer;

  @override
  void initState() {
    super.initState();

    setState(() {
      _correctVerificationCode = widget.data.verificationCode;
    });
  }

  _requestVerificationCode() async {
    if (_resend == false) {
      var result = await authRepo.requestVerificationCode(
        context: context,
        phoneCountryCode: widget.data.phoneCountryCode,
        phone: widget.data.phone,
      );

      if (result.isSuccess) {
        setState(() {
          _correctVerificationCode = result.data.toString();
          _resend = true;
          _message = result.message;
          _messageStyle = TextStyle(color: Colors.green);
        });

        startTimer();
      } else {
        setState(() {
          _resend = false;
          _message = result.message;
          _messageStyle = TextStyle(color: Colors.red);
        });
      }
    }
  }

  void startTimer() {
    CountdownTimer countdownTimer =
        CountdownTimer(Duration(seconds: _time), Duration(seconds: 1));

    timer = countdownTimer.listen(null);

    timer.onData((duration) {
      setState(() {
        _current = _time - duration.elapsed.inSeconds as int;
      });
    });

    timer.onDone(() {
      setState(() {
        _resend = false;
        _time = 60;
        _current = 60;
      });

      timer.cancel();
    });
  }

  @override
  void dispose() {
    if (timer != null) timer.cancel();

    super.dispose();
  }

  /* Future<bool> _onWillPop() async {
    timer.cancel();

    Navigator.pop(context);

    return Future.value(false);
  } */

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) {
          return defaultLayout();
        }
        return tabLayout();
      },
    );
  }

  defaultLayout() {
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 20.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 130.w),
                  child: Text(AppLocalizations.of(context)!
                      .translate('enter_verification')),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 130.w),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 58.sp,
                            color: Color(0xff808080),
                          ),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              // contentPadding:
                              //     EdgeInsets.symmetric(vertical: 120.h),
                              suffixIcon: IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: _resend == false
                                ? _requestVerificationCode
                                : null,
                          )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .translate('verification_required');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value != _verificationCode) {
                              _verificationCode = value;
                            }
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _message!.isNotEmpty
                              ? Container(
                                  margin: EdgeInsets.symmetric(vertical: 20.h),
                                  alignment: Alignment.center,
                                  width: 1300.w,
                                  child: Text(
                                    '$_message ${_resend == true ? _current : ''}',
                                    style: _messageStyle,
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(vertical: 20.h),
                                ),
                          Container(
                            alignment: Alignment.center,
                            child: _isLoading
                                ? SpinKitFoldingCube(
                                    color: Colors.greenAccent,
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(420.w, 45.h),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 11.0),
                                      shape: StadiumBorder(),
                                      primary: Color(0xffdd0e0e),
                                      textStyle: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: _next,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .translate('next_btn'),
                                        style: TextStyle(
                                          fontSize: 56.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  tabLayout() {
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 20.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 130.w),
                  child: Text(
                    AppLocalizations.of(context)!
                        .translate('enter_verification'),
                    style: TextStyle(
                      fontSize: 35.sp,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 130.w),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 40.sp,
                            color: Color(0xff808080),
                          ),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              // contentPadding:
                              //     EdgeInsets.symmetric(vertical: 120.h),
                              suffixIcon: IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: _resend == false
                                ? _requestVerificationCode
                                : null,
                          )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .translate('verification_required');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value != _verificationCode) {
                              _verificationCode = value;
                            }
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _message!.isNotEmpty
                              ? Container(
                                  margin: EdgeInsets.symmetric(vertical: 20.h),
                                  alignment: Alignment.center,
                                  width: 1300.w,
                                  child: Text(
                                    '$_message ${_resend == true ? _current : ''}',
                                    style: _messageStyle,
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(vertical: 20.h),
                                ),
                          Container(
                            alignment: Alignment.center,
                            child: _isLoading
                                ? SpinKitFoldingCube(
                                    color: Colors.greenAccent,
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(420.w, 45.h),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 11.0),
                                      shape: StadiumBorder(),
                                      primary: Color(0xffdd0e0e),
                                      textStyle: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: _next,
                                    child: Container(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .translate('next_btn'),
                                        style: TextStyle(
                                          fontSize: 35.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _next() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).requestFocus(new FocusNode());

      if (_verificationCode == _correctVerificationCode) {
        context.router.push(
          RegisterForm(data: widget.data),
        );

        setState(() {
          _message = '';
        });
      } else
        setState(() {
          _message = AppLocalizations.of(context)!
              .translate('incorrect_verification_code');
          _messageStyle = TextStyle(color: Colors.red);
        });
    }

    // Navigator.push(context, SIGN_UP_FORM, arguments: widget.data);
  }
}
