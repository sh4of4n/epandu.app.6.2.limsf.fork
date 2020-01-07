import 'package:epandu/app_localizations.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/services/repo/auth_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_snackbar.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm>
    with PageBaseClass {
  final authRepo = AuthRepo();

  final _formKey = GlobalKey<FormState>();

  final FocusNode _phoneFocus = FocusNode();

  final primaryColor = ColorConstant.primaryColor;

  final localStorage = LocalStorage();

  bool _isLoading = false;

  String _phone;
  String _message = '';

  var _height = ScreenUtil.getInstance().setHeight(1150);

  // var _height = ScreenUtil.screenHeight / 4.5;

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
                focusNode: _phoneFocus,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                  hintStyle: TextStyle(
                    color: primaryColor,
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('phone_lbl'),
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
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('phone_required_msg');
                  }
                },
                onSaved: (value) {
                  if (value != _phone) {
                    _phone = value;
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(60),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Wrap(
                  children: <Widget>[
                    Text(AppLocalizations.of(context)
                        .translate('forgot_password_msg')),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(40),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      /* _message.isNotEmpty
                          ? Text(
                              _message,
                              style: TextStyle(color: Colors.red),
                            )
                          : SizedBox.shrink(), */
                      _submitButton(),
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

  _submitButton() {
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
                  AppLocalizations.of(context).translate('submit_btn'),
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
        _height = ScreenUtil.getInstance().setHeight(1150);
        _isLoading = true;
      });

      var result = await authRepo.login(
        phone: _phone,
        password: '',
      );

      if (result.isSuccess) {
        Navigator.pop(context);
        CustomSnackbar().show(
          context,
          message: result.message.toString(),
          type: MessageType.SUCCESS,
        );
      } else {
        if (result.message.contains('timeout')) {
          setState(() {
            _message =
                AppLocalizations.of(context).translate('timeout_exception');
          });
        } else if (result.message.contains('socket')) {
          setState(() {
            _message =
                AppLocalizations.of(context).translate('socket_exception');
          });
        } else {
          setState(() {
            _message = result.message;
          });
        }

        CustomSnackbar().show(
          context,
          message: _message,
          type: MessageType.ERROR,
        );

        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _height = ScreenUtil.getInstance().setHeight(1250);
      });
    }
  }
}
