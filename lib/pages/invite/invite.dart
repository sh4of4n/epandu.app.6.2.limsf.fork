import 'package:epandu/app_localizations.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Invite extends StatefulWidget with PageBaseClass {
  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> with PageBaseClass {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  bool _isLoading = false;
  final primaryColor = ColorConstant.primaryColor;
  final image = ImagesConstant();

  String _countryCode = '+60';
  String _phone = '';
  String _name = '';
  String _message = '';
  TextStyle _messageStyle = TextStyle(color: Colors.red);

  final AuthRepo authRepo = AuthRepo();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.amberAccent,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate('invite_your_friends_lbl'),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Opacity(
              opacity: 0.9,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image.friend),
                    fit: BoxFit.cover,
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: ScreenUtil().setHeight(800),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
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
                        labelText:
                            AppLocalizations.of(context).translate('phone_lbl'),
                        fillColor: Colors.white,
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
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        hintStyle: TextStyle(
                          color: primaryColor,
                        ),
                        labelText:
                            AppLocalizations.of(context).translate('name_lbl'),
                        fillColor: Colors.white,
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
                      height: ScreenUtil().setHeight(80),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            _message.isNotEmpty
                                ? Text(
                                    _message,
                                    style: _messageStyle,
                                  )
                                : SizedBox.shrink(),
                            _inviteButton(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _inviteButton() {
    return Container(
      child: _isLoading
          ? SpinKitFoldingCube(
              color: primaryColor,
            )
          : ButtonTheme(
              padding: EdgeInsets.all(0.0),
              shape: StadiumBorder(),
              child: RaisedButton(
                color: Colors.red,
                onPressed: _submit,
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    AppLocalizations.of(context).translate('invite_btn'),
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(56),
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

      String _userId = await LocalStorage().getUserId();

      setState(() {
        _isLoading = true;
        _message = '';
      });

      var result = await authRepo.getUserByUserPhone(
        context: context,
        type: 'INVITE',
        countryCode: _countryCode,
        phone: _phone,
        userId: _userId,
        name: _name,
      );

      if (result.isSuccess) {
        setState(() {
          _message = result.message;
          _messageStyle = TextStyle(color: Colors.green);
        });
      } else {
        setState(() {
          _message = result.message;
          _messageStyle = TextStyle(color: Colors.red);
        });
      }

      setState(() {
        _isLoading = false;
      });
    }
  }
}
