import 'package:epandu/app_localizations.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_snackbar.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterForm extends StatefulWidget {
  final String argument;

  RegisterForm(this.argument);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> with PageBaseClass {
  final authRepo = AuthRepo();
  final customSnackbar = CustomSnackbar();

  final _formKey = GlobalKey<FormState>();

  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _idFocus = FocusNode();
  final FocusNode _diCodeFocus = FocusNode();
  final FocusNode _add1Focus = FocusNode();
  // final FocusNode _add2Focus = FocusNode();
  // final FocusNode _add3Focus = FocusNode();
  final FocusNode _postCodeFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  final primaryColor = ColorConstant.primaryColor;

  final localStorage = LocalStorage();

  bool _isLoading = false;

  String _phone;
  String _name;
  String _icNo;
  String _diCode;
  String _add1;
  String _add2;
  String _add3;
  String _postcode;
  String _city;
  String _state;
  String _country;
  String _email;
  String _message = '';

  _renderDiCodeField() {
    if (widget.argument == 'STUDENT') {
      return Column(
        children: <Widget>[
          TextFormField(
            focusNode: _diCodeFocus,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 16.0),
              hintStyle: TextStyle(
                color: primaryColor,
              ),
              labelText: AppLocalizations.of(context)
                  .translate('institute_code_required_lbl'),
              fillColor: Colors.grey.withOpacity(.25),
              filled: true,
              prefixIcon: Icon(Icons.assignment_ind),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(30),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onFieldSubmitted: (term) {
              fieldFocusChange(context, _diCodeFocus, _add1Focus);
            },
            validator: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context)
                    .translate('institute_code_msg');
              }
              return null;
            },
            onSaved: (value) {
              if (value != _diCode) {
                _diCode = value;
              }
            },
          ),
          SizedBox(
            height: ScreenUtil().setHeight(70),
          ),
        ],
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
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
                onFieldSubmitted: (term) {
                  fieldFocusChange(context, _phoneFocus, _nameFocus);
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
                height: ScreenUtil().setHeight(70),
              ),
              TextFormField(
                focusNode: _nameFocus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                  hintStyle: TextStyle(
                    color: primaryColor,
                  ),
                  labelText: AppLocalizations.of(context)
                      .translate('name_required_lbl'),
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
                  fieldFocusChange(context, _nameFocus, _idFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('name_required_msg');
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != _name) {
                    _name = value;
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(70),
              ),
              TextFormField(
                focusNode: _idFocus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                  hintStyle: TextStyle(
                    color: primaryColor,
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('ic_required_lbl'),
                  fillColor: Colors.grey.withOpacity(.25),
                  filled: true,
                  prefixIcon: Icon(Icons.assignment_ind),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onFieldSubmitted: (term) {
                  fieldFocusChange(
                    context,
                    _idFocus,
                    widget.argument == 'STUDENT' ? _diCodeFocus : _add1Focus,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('ic_required_msg');
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != _icNo) {
                    _icNo = value;
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(70),
              ),
              _renderDiCodeField(),
              TextFormField(
                focusNode: _add1Focus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                  hintStyle: TextStyle(
                    color: primaryColor,
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('address_lbl'),
                  fillColor: Colors.grey.withOpacity(.25),
                  filled: true,
                  prefixIcon: Icon(Icons.location_on),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onFieldSubmitted: (term) {
                  fieldFocusChange(context, _add1Focus, _postCodeFocus);
                },
                /* validator: (value) {
                  if (value.isEmpty) {
                    return 'Address is required.';
                  }
                }, */
                onSaved: (value) {
                  if (value != _add1) {
                    _add1 = value;
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(70),
              ),
              TextFormField(
                focusNode: _postCodeFocus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                  hintStyle: TextStyle(
                    color: primaryColor,
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('postcode_lbl'),
                  fillColor: Colors.grey.withOpacity(.25),
                  filled: true,
                  prefixIcon: Icon(Icons.confirmation_number),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onFieldSubmitted: (term) {
                  fieldFocusChange(context, _postCodeFocus, _cityFocus);
                },
                /* validator: (value) {
                  if (value.isEmpty) {
                    return 'Postcode is required.';
                  }
                }, */
                onSaved: (value) {
                  if (value != _postcode) {
                    _postcode = value;
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(70),
              ),
              TextFormField(
                focusNode: _cityFocus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                  hintStyle: TextStyle(
                    color: primaryColor,
                  ),
                  labelText: AppLocalizations.of(context).translate('city_lbl'),
                  fillColor: Colors.grey.withOpacity(.25),
                  filled: true,
                  prefixIcon: Icon(Icons.location_city),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onFieldSubmitted: (term) {
                  fieldFocusChange(context, _cityFocus, _stateFocus);
                },
                /* validator: (value) {
                  if (value.isEmpty) {
                    return 'City is required.';
                  }
                }, */
                onSaved: (value) {
                  if (value != _city) {
                    _city = value;
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(70),
              ),
              TextFormField(
                focusNode: _stateFocus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                  hintStyle: TextStyle(
                    color: primaryColor,
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('state_lbl'),
                  fillColor: Colors.grey.withOpacity(.25),
                  filled: true,
                  prefixIcon: Icon(Icons.map),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onFieldSubmitted: (term) {
                  fieldFocusChange(context, _stateFocus, _countryFocus);
                },
                /* validator: (value) {
                  if (value.isEmpty) {
                    return 'State is required.';
                  }
                }, */
                onSaved: (value) {
                  if (value != _state) {
                    _state = value;
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(70),
              ),
              TextFormField(
                focusNode: _countryFocus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                  hintStyle: TextStyle(
                    color: primaryColor,
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('country_lbl'),
                  fillColor: Colors.grey.withOpacity(.25),
                  filled: true,
                  prefixIcon: Icon(Icons.flag),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onFieldSubmitted: (term) {
                  fieldFocusChange(context, _countryFocus, _emailFocus);
                },
                /* validator: (value) {
                  if (value.isEmpty) {
                    return 'Country is required.';
                  }
                }, */
                onSaved: (value) {
                  if (value != _country) {
                    _country = value;
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(70),
              ),
              TextFormField(
                focusNode: _emailFocus,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                  hintStyle: TextStyle(
                    color: primaryColor,
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('email_lbl'),
                  fillColor: Colors.grey.withOpacity(.25),
                  filled: true,
                  prefixIcon: Icon(Icons.mail),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                /* validator: (value) {
                  if (value.isEmpty) {
                    return 'Email is required.';
                  }
                }, */
                onSaved: (value) {
                  if (value != _email) {
                    _email = value;
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(70),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "GO BACK",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(56),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signUpButton() {
    return Container(
      child: _isLoading
          ? SpinKitFoldingCube(
              color: primaryColor,
            )
          : ButtonTheme(
              minWidth: ScreenUtil().setWidth(420),
              padding: EdgeInsets.symmetric(vertical: 11.0),
              buttonColor: primaryColor,
              shape: StadiumBorder(),
              child: RaisedButton(
                onPressed: _submit,
                textColor: Colors.white,
                child: Text(
                  'SIGNUP',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(56),
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

      var result = await authRepo.getUserByUserPhone(
        context: context,
        type: 'REGISTER',
        countryCode: '+60',
        phone: _phone,
        userId: '',
        diCode: _diCode,
        name: _name,
        icNo: _icNo,
        add1: _add1,
        add2: _add2,
        add3: _add3,
        postcode: _postcode,
        city: _city,
        state: _state,
        country: _country,
        email: _email,
        registerAs: widget.argument,
      );

      if (result.isSuccess) {
        Navigator.pushNamedAndRemoveUntil(context, LOGIN, (r) => false);
        customSnackbar.show(
          context,
          message: result.message.toString(),
          type: MessageType.SUCCESS,
          duration: 3000,
        );
      } else {
        customSnackbar.show(
          context,
          message: result.message.toString(),
          type: MessageType.ERROR,
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }
}
