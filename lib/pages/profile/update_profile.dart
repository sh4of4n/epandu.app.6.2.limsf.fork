import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/services/repository/profile_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../app_localizations.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> with PageBaseClass {
  final profileRepo = ProfileRepo();
  final authRepo = AuthRepo();
  final _formKey = GlobalKey<FormState>();
  final customDialog = CustomDialog();
  final primaryColor = ColorConstant.primaryColor;
  final localStorage = LocalStorage();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  String _getName = '';
  String _getEmail = '';

  String _name = '';
  String _email = '';
  String _message = '';
  bool _isLoading = false;

  TextStyle _messageStyle = TextStyle(color: Colors.red);
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_nameValue);
    _emailController.addListener(_emailValue);

    _getUserInfo();
  }

  _getUserInfo() async {
    _getName = await localStorage.getUsername();
    _getEmail = await localStorage.getEmail();
  }

  _nameValue() {
    setState(() {
      _name = _nameController.text;
    });
  }

  _emailValue() {
    setState(() {
      _email = _emailController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Color(0xfffdc013),
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate('update_profile'),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 70.w),
            margin: EdgeInsets.symmetric(vertical: 100.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    focusNode: _nameFocus,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      hintStyle: TextStyle(
                        color: primaryColor,
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xff808080),
                      ),
                      labelText: AppLocalizations.of(context)
                          .translate('nick_name_lbl'),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.assignment_ind),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          _nameController.text = '';
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue[700], width: 1.6),
                        // borderRadius: BorderRadius.circular(0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onFieldSubmitted: (term) {
                      fieldFocusChange(
                        context,
                        _nameFocus,
                        _emailFocus,
                      );
                    },
                    /* validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('ic_name_required_msg');
                      }
                      return null;
                    }, */
                    /* onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    }, */
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      hintStyle: TextStyle(
                        color: primaryColor,
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xff808080),
                      ),
                      labelText:
                          AppLocalizations.of(context).translate('email_lbl'),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.mail),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          _emailController.text = '';
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue[700], width: 1.6),
                        // borderRadius: BorderRadius.circular(0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    /* validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('ic_name_required_msg');
                      }
                      return null;
                    }, */
                    /* onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    }, */
                  ),
                  SizedBox(height: 40.h),
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
        ),
      ),
    );
  }

  _inviteButton() {
    return Container(
      child: _isLoading
          ? SpinKitFoldingCube(
              color: Colors.blue,
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
                    vertical: 10.0,
                  ),
                  child: Text(
                    AppLocalizations.of(context).translate('save_btn'),
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

      setState(() {
        _isLoading = true;
        _message = '';
      });

      var result = await profileRepo.saveUserProfile(
        context: context,
        name: _name.isNotEmpty ? _name : _getName,
        email: _email.isNotEmpty ? _email : _getEmail,
      );

      if (result.isSuccess) {
        setState(() {
          _message = result.message;
          _messageStyle = TextStyle(color: Colors.green);
        });

        await authRepo.getUserRegisteredDI(context: context);

        Navigator.pop(context);
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
