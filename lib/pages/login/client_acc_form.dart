import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/services/repo/auth_repo.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:epandu/app_localizations.dart';

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
  String _caUid;
  String _caPwd;
  bool _obscureText = true;
  // String _connectedCa;

  var _height = ScreenUtil.getInstance().setHeight(1200);

  // var _height = ScreenUtil.screenHeight / 4.5;

  /* @override
  void initState() {
    super.initState();

    _getConnectedCa();
  }

  _getConnectedCa() async {
    String _clientAcc = await localStorage.getCaUid();

    setState(() {
      _connectedCa = _clientAcc;
    });
  } */

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1500),
      curve: Curves.elasticOut,
      width: double.infinity,
      height: _height,
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
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(35),
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
                },
                onSaved: (value) {
                  if (value != _caUid) {
                    _caUid = value;
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(70),
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
                },
                onSaved: (value) {
                  if (value != _caPwd) {
                    _caPwd = value;
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(60),
              ),
              // _showConnectedCa(),
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
                height: ScreenUtil.getInstance().setHeight(40),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      if (widget.data == 'SETTINGS')
                        Navigator.pushReplacementNamed(context, LOGIN);
                      else
                        Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('go_back_lbl'),
                      style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(56),
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

  /* _showConnectedCa() {
    if (_connectedCa.isNotEmpty) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
                '${AppLocalizations.of(context).translate('connected_ca')}: $_connectedCa'),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(60),
          ),
        ],
      );
    }
  } */

  _saveButton() {
    return Container(
      child: _isLoading
          ? SpinKitFoldingCube(
              color: primaryColor,
            )
          : ButtonTheme(
              minWidth: ScreenUtil.getInstance().setWidth(420),
              padding: EdgeInsets.symmetric(vertical: 11.0),
              buttonColor: primaryColor,
              shape: StadiumBorder(),
              child: RaisedButton(
                onPressed: _submit,
                textColor: Colors.white,
                child: Text(
                  AppLocalizations.of(context).translate('save_btn'),
                  style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(56),
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
        _height = ScreenUtil.getInstance().setHeight(1200);
        _message = '';
        _isLoading = true;
      });

      var result = await authRepo.getWsUrl(
        acctUid: _caUid,
        acctPwd: _caPwd,
        loginType: appConfig.wsCodeCrypt,
      );

      if (result.isSuccess) {
        localStorage.saveServerType('DEVP');
        localStorage.saveCaUid(_caUid);
        localStorage.saveCaPwd(_caPwd);
        localStorage.saveCaPwdEncode(Uri.encodeQueryComponent(_caPwd));

        if (widget.data == 'SETTINGS')
          Navigator.pushReplacementNamed(context, LOGIN);
        else
          Navigator.pop(context);
      } else {
        setState(() {
          _message = result.message.toString();
        });
      }

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _height = ScreenUtil.getInstance().setHeight(1350);
      });
    }
  }
}
