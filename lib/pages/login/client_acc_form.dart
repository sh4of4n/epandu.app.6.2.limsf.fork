import 'package:auto_route/auto_route.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/common_library/utils/app_config.dart';
import 'package:epandu/common_library/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:epandu/app_localizations.dart';

import '../../router.gr.dart';

class ClientAccountForm extends StatefulWidget {
  final data;

  ClientAccountForm(this.data);

  @override
  _ClientAccountFormState createState() => _ClientAccountFormState();
}

class _ClientAccountFormState extends State<ClientAccountForm>
    with PageBaseClass {
  final authRepo = AuthRepo();
  final AppConfig appConfig = AppConfig();

  final _formKey = GlobalKey<FormState>();

  final FocusNode _caUidFocus = FocusNode();

  final FocusNode _caPwdFocus = FocusNode();

  final primaryColor = ColorConstant.primaryColor;

  final localStorage = LocalStorage();

  bool _isLoading = false;

  String _message = '';
  String _caUid = '';
  String _caPwd = '';
  bool _obscureText = true;
  String _connectedCa = '';

  // var _height = ScreenUtil().setHeight(1300);

  // var _height = ScreenUtil.screenHeight / 4.5;

  @override
  void initState() {
    super.initState();

    _getConnectedCa();
  }

  _getConnectedCa() async {
    String _clientAcc = await localStorage.getCaUid();

    setState(() {
      _connectedCa = _clientAcc;
    });
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
            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 35.h,
              ),
              TextFormField(
                focusNode: _caUidFocus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                  hintStyle: TextStyle(
                    color: primaryColor,
                  ),
                  labelText: AppLocalizations.of(context)
                      .translate('client_acc_id_lbl'),
                  fillColor: Colors.grey.withOpacity(.25),
                  filled: true,
                  prefixIcon: Icon(Icons.account_circle),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onFieldSubmitted: (term) {
                  fieldFocusChange(context, _caUidFocus, _caPwdFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('client_acc_id_required');
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != _caUid) {
                    _caUid = value;
                  }
                },
              ),
              SizedBox(
                height: 70.h,
              ),
              TextFormField(
                focusNode: _caPwdFocus,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                  hintStyle: TextStyle(color: primaryColor),
                  labelText: AppLocalizations.of(context)
                      .translate('client_acc_pwd_lbl'),
                  fillColor: Colors.grey.withOpacity(.25),
                  filled: true,
                  prefixIcon: Icon(Icons.lock),
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
                  if (value != _caPwd) {
                    _caPwd = value;
                  }
                },
              ),
              SizedBox(
                height: 60.h,
              ),
              _showConnectedCa(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _message.isNotEmpty
                          ? Text(
                              _message,
                              style: TextStyle(color: Colors.red),
                            )
                          : SizedBox.shrink(),
                      _saveButton(),
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
                      if (widget.data == 'SETTINGS')
                        ExtendedNavigator.of(context).replace(Routes.login);
                      else
                        ExtendedNavigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('go_back_lbl'),
                      style: TextStyle(
                        fontSize: 56.sp,
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

  _showConnectedCa() {
    if (_connectedCa.isNotEmpty) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
                '${AppLocalizations.of(context).translate('connected_ca')}: $_connectedCa'),
          ),
          SizedBox(
            height: 60.h,
          ),
        ],
      );
    }
    return Container(width: 0, height: 0);
  }

  _saveButton() {
    return Container(
      child: _isLoading
          ? SpinKitFoldingCube(
              color: primaryColor,
            )
          : ButtonTheme(
              minWidth: 420.w,
              padding: EdgeInsets.symmetric(vertical: 11.0),
              buttonColor: primaryColor,
              shape: StadiumBorder(),
              child: RaisedButton(
                onPressed: _submit,
                textColor: Colors.white,
                child: Text(
                  AppLocalizations.of(context).translate('save_btn'),
                  style: TextStyle(
                    fontSize: 56.sp,
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
        _message = '';
        _isLoading = true;
      });

      var result = await authRepo.getWsUrl(
        context: context,
        acctUid: _caUid.replaceAll(' ', ''),
        acctPwd: _caPwd.replaceAll(' ', ''),
        loginType: appConfig.wsCodeCrypt,
      );

      if (result.isSuccess) {
        if (widget.data == 'SETTINGS')
          ExtendedNavigator.of(context).replace(Routes.login);
        else
          ExtendedNavigator.of(context).pop();
      } else {
        setState(() {
          _message = result.message.toString();
        });
      }

      setState(() {
        _isLoading = false;
      });
    }
  }
}
