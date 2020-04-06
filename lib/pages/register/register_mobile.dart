import 'package:country_code_picker/country_code_picker.dart';
import 'package:epandu/app_localizations.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterMobile extends StatefulWidget {
  @override
  _RegisterMobileState createState() => _RegisterMobileState();
}

class _RegisterMobileState extends State<RegisterMobile> {
  final primaryColor = ColorConstant.primaryColor;
  final _formKey = GlobalKey<FormState>();

  String _countryCode = '';
  String _phone = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(AppLocalizations.of(context).translate('mobile_number')),
            Text(
                AppLocalizations.of(context).translate('enter_your_mobile_no')),
            Row(
              children: <Widget>[
                CountryCodePicker(
                  onChanged: (value) {
                    setState(() {
                      _countryCode = value.code;
                    });
                  },
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: 'MY',
                  favorite: ['+60', 'MY'],
                  // optional. Shows only country name and flag
                  showCountryOnly: true,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: false,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('phone_required_lbl'),
                          fillColor: Colors.grey.withOpacity(.25),
                          filled: true,
                          prefixIcon: Icon(Icons.phone_android),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
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
                      Container(
                        child: _isLoading
                            ? SpinKitFoldingCube(
                                color: Colors.greenAccent,
                              )
                            : ButtonTheme(
                                padding: EdgeInsets.all(0.0),
                                shape: StadiumBorder(),
                                child: RaisedButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, SIGN_UP_VERIFICATION,
                                      arguments: _countryCode + _phone),
                                  color: Color(0xffdd0e0e),
                                  textColor: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0,
                                      vertical: 10.0,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('next_btn'),
                                      style: TextStyle(
                                        fontSize: 56.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
