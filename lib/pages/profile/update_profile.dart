import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/services/repository/profile_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

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
  final FocusNode _dobFocus = FocusNode();
  final FocusNode _icFocus = FocusNode();
  final FocusNode _nickNameFocus = FocusNode();
  final _dobController = TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  String _getName = '';
  String _getEmail = '';
  String _getUserIc = '';
  String _getBirthDate = '';
  String _getNickName = '';

  String _dob = '';
  String _ic = '';
  String _name = '';
  String _nickName = '';
  String _email = '';
  String _message = '';
  bool _isLoading = false;

  TextStyle _messageStyle = TextStyle(color: Colors.red);
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _icController = TextEditingController();
  final _nickNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_nameValue);
    _emailController.addListener(_emailValue);
    _dobController.addListener(_dobValue);
    _icController.addListener(_icValue);
    _nickNameController.addListener(_nickNameValue);

    _getUserInfo();
  }

  _getUserInfo() async {
    _getName = await localStorage.getUsername();
    _getEmail = await localStorage.getEmail();
    _getBirthDate = await localStorage.getBirthDate();
    _getUserIc = await localStorage.getStudentIc();
    _getNickName = await localStorage.getNickName();

    _nameController.text = _getName;
    _emailController.text = _getEmail;
    _dobController.text =
        _getBirthDate.isNotEmpty ? _getBirthDate.substring(0, 10) : '';
    _icController.text = _getUserIc;
    _nickNameController.text = _getNickName;
  }

  _nickNameValue() {
    setState(() {
      _nickName = _nickNameController.text;
    });
  }

  _icValue() {
    setState(() {
      _ic = _icController.text;
    });
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

  _dobValue() {
    setState(() {
      _dob = _dobController.text;
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
                      labelText:
                          AppLocalizations.of(context).translate('ic_name_lbl'),
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
                        _nickNameFocus,
                      );
                    },
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  TextFormField(
                    controller: _nickNameController,
                    focusNode: _nickNameFocus,
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
                          _nickNameController.text = '';
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
                        _nickNameFocus,
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
                    textInputAction: TextInputAction.next,
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
                    onFieldSubmitted: (term) {
                      fieldFocusChange(
                        context,
                        _emailFocus,
                        _icFocus,
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
                        _email = value;
                      });
                    }, */
                  ),
                  SizedBox(height: 60.h),
                  TextFormField(
                    controller: _icController,
                    focusNode: _icFocus,
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
                          .translate('ic_required_lbl'),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.assignment_ind),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          _icController.text = '';
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
                        _icFocus,
                        _dobFocus,
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
                  _dobField(),
                  /* SizedBox(height: 60.h),
                  _raceField(),
*/
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

  _dobField() {
    return DateTimeField(
      focusNode: _dobFocus,
      format: format,
      controller: _dobController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 50.h,
        ),
        labelStyle: TextStyle(
          color: Color(0xff808080),
        ),
        labelText: AppLocalizations.of(context).translate('dob_required_lbl'),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.3),
          borderRadius: BorderRadius.circular(30),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.3),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[700], width: 1.6),
          // borderRadius: BorderRadius.circular(0),
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(Icons.calendar_today),
        suffixIcon: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            _dobController.text = '';
          },
        ),
      ),
      validator: (value) {
        if (_dobController.text.isEmpty) {
          return AppLocalizations.of(context).translate('dob_required_msg');
        }
        return null;
      },
      onShowPicker: (context, currentValue) async {
        if (Platform.isIOS) {
          if (_dobController.text.isEmpty) {
            setState(() {
              _dobController.text = DateFormat('yyyy/MM/dd').format(
                DateTime(2000, 1, 1),
              );
            });
          }

          await showModalBottomSheet(
            context: context,
            builder: (context) {
              return CupertinoDatePicker(
                initialDateTime: DateTime(2000),
                onDateTimeChanged: (DateTime date) {
                  setState(() {
                    _dobController.text = DateFormat('yyyy/MM/dd').format(date);
                  });
                },
                minimumYear: 1920,
                maximumYear: 2020,
                mode: CupertinoDatePickerMode.date,
              );
            },
          );
        } else {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1920),
              initialDate: currentValue ?? DateTime(2000),
              lastDate: DateTime(2020));
        }
        return null;
      },
    );
  }
/*
  _raceField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.h,
        ),
        labelText: AppLocalizations.of(context).translate('race_lbl'),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.3),
          borderRadius: BorderRadius.circular(30),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[700], width: 1.6),
          // borderRadius: BorderRadius.circular(0),
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(Icons.people),
      ),
      disabledHint: Text(AppLocalizations.of(context).translate('race_lbl')),
      value: _race.isEmpty ? null : _race,
      */ /* _nationality.isNotEmpty
          ? _nationality
          : AppLocalizations.of(context).translate('citizen_lbl'), */ /*
      onChanged: (value) {
        setState(() {
          _race = value;
          if (value == AppLocalizations.of(context).translate('malay_race_lbl'))
            _raceParam = 'M';
          else if (value ==
              AppLocalizations.of(context).translate('chinese_lbl'))
            _raceParam = 'C';
          else if (value ==
              AppLocalizations.of(context).translate('indian_lbl'))
            _raceParam = 'I';
          else
            _raceParam = 'O';
        });
      },
      items: <String>[
        AppLocalizations.of(context).translate('malay_race_lbl'),
        AppLocalizations.of(context).translate('chinese_lbl'),
        AppLocalizations.of(context).translate('indian_lbl'),
        AppLocalizations.of(context).translate('others_lbl'),
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return AppLocalizations.of(context).translate('race_required_msg');
        }
        return null;
      },
    );
  }*/

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
        icNo: _ic.isNotEmpty ? _ic : _getUserIc,
        dateOfBirthString: _dob.isNotEmpty ? _dob : _getBirthDate,
        nickName: _nickName.isNotEmpty ? _nickName : _getNickName,
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
