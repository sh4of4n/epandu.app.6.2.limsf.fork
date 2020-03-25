import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/custom_snackbar.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../app_localizations.dart';

enum Gender { male, female }

class Enrollment extends StatefulWidget {
  final data;

  Enrollment(this.data);

  @override
  _EnrollmentState createState() => _EnrollmentState();
}

class _EnrollmentState extends State<Enrollment> with PageBaseClass {
  final authRepo = AuthRepo();
  final customDialog = CustomDialog();
  final customSnackbar = CustomSnackbar();
  final format = DateFormat("yyyy-MM-dd");

  final _formKey = GlobalKey<FormState>();

  final FocusNode _idFocus = FocusNode();
  final FocusNode _idNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _postcodeFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  // final FocusNode _genderFocus = FocusNode();
  // final FocusNode _nearbyDiFocus = FocusNode();
  final FocusNode _nationalityFocus = FocusNode();

  final _dobController = TextEditingController();

  final primaryColor = ColorConstant.primaryColor;
  final localStorage = LocalStorage();
  bool _isLoading = false;
  String _icNo = '';
  String _icName = '';
  String _email = '';
  // String _address = '';
  // String _postcode = '';
  String _dob = '';
  String _nationality = '';
  String _race = '';
  String _message = '';

  Gender _gender = Gender.male;
  String _genderValue = 'MALE';
  String _countryCode = '+60';
  String _potentialDob = '';
  final myImage = ImagesConstant();
  // String genderInt = '1';

  @override
  void initState() {
    super.initState();

    _dobController.addListener(_dobValue);
  }

  _dobValue() {
    setState(() {
      _dob = _dobController.text;
    });
  }

  _idField() {
    return TextFormField(
      focusNode: _idFocus,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        hintStyle: TextStyle(
          color: primaryColor,
        ),
        labelStyle: TextStyle(
          color: Color(0xff808080),
        ),
        labelText: AppLocalizations.of(context).translate('ic_required_lbl'),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(Icons.featured_video),
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
      ),
      onFieldSubmitted: (term) {
        fieldFocusChange(
          context,
          _idFocus,
          _idNameFocus,
        );
      },
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate('ic_required_msg');
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _icNo = value;

          if (value.replaceAll('-', '').replaceAll(' ', '').length == 12) {
            setState(() {
              _potentialDob = value.substring(0, 7);

              String _year = _potentialDob.substring(0, 2);
              int _currentYear = DateTime.now().year;
              int _birthYear = 0;
              int _birthMonth = int.tryParse(_potentialDob.substring(2, 4));
              int _birthDay = int.tryParse(_potentialDob.substring(4, 6));

              if (_currentYear - int.tryParse('19' + _year) < 70) {
                _birthYear = int.tryParse('19$_year');
                _message = '';
              } else if (_currentYear - int.tryParse('20' + _year) < 16) {
                _birthYear = int.tryParse('20$_year');

                _message =
                    AppLocalizations.of(context).translate('enroll_underage');
              }

              _dobController.text = DateFormat('yyyy/MM/dd').format(
                DateTime(_birthYear, _birthMonth, _birthDay),
              );
            });

            if (int.tryParse(value
                        .replaceAll('-', '')
                        .replaceAll(' ', '')
                        .substring(11)) %
                    2 ==
                0)
              _gender = Gender.female;
            else
              _gender = Gender.male;
          }
        });
      },
    );
  }

  _idNameField() {
    return TextFormField(
      focusNode: _idNameFocus,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        hintStyle: TextStyle(
          color: primaryColor,
        ),
        labelStyle: TextStyle(
          color: Color(0xff808080),
        ),
        labelText:
            AppLocalizations.of(context).translate('ic_name_required_lbl'),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(Icons.assignment_ind),
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
      ),
      onFieldSubmitted: (term) {
        fieldFocusChange(
          context,
          _idNameFocus,
          _dobFocus,
        );
      },
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate('ic_name_required_msg');
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _icName = value;
        });
      },
    );
  }

  /* _emailField() {
    return TextFormField(
      focusNode: _emailFocus,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        hintStyle: TextStyle(
          color: primaryColor,
        ),
        labelStyle: TextStyle(
          color: Color(0xff808080),
        ),
        labelText: AppLocalizations.of(context).translate('email_required_lbl'),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(Icons.mail),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.3),
          borderRadius: BorderRadius.circular(30),
        ),
        /* border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ), */
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[700], width: 1.6),
          // borderRadius: BorderRadius.circular(0),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onFieldSubmitted: (term) {
        fieldFocusChange(
          context,
          _emailFocus,
          _dobFocus,
        );
      },
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate('email_required_msg');
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _email = value;
        });
      },
    );
  } */

  /* _addressField() {
    return TextFormField(
      focusNode: _addressFocus,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        hintStyle: TextStyle(
          color: primaryColor,
        ),
        labelStyle: TextStyle(
          color: Color(0xff808080),
        ),
        labelText:
            AppLocalizations.of(context).translate('address_required_lbl'),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(Icons.home),
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
          _addressFocus,
          _postcodeFocus,
        );
      },
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate('address_required_msg');
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _address = value;
        });
      },
    );
  } */

  /* _postcodeField() {
    return TextFormField(
      focusNode: _postcodeFocus,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        hintStyle: TextStyle(
          color: primaryColor,
        ),
        labelStyle: TextStyle(
          color: Color(0xff808080),
        ),
        labelText:
            AppLocalizations.of(context).translate('postcode_required_lbl'),
        fillColor: Colors.white,
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
        fieldFocusChange(
          context,
          _postcodeFocus,
          _dobFocus,
        );
      },
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context)
              .translate('postcode_required_msg');
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _postcode = value;
        });
      },
    );
  } */

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

  _nationalityField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.h,
        ),
        labelText: AppLocalizations.of(context).translate('nationality_lbl'),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.3),
          borderRadius: BorderRadius.circular(30),
        ),
        /* border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ), */
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[700], width: 1.6),
          // borderRadius: BorderRadius.circular(0),
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(Icons.flag),
      ),
      disabledHint: Text('WARGANEGARA'),
      value: 'WARGANEGARA',
      /* _nationality.isNotEmpty
          ? _nationality
          : AppLocalizations.of(context).translate('citizen_lbl'), */
      onChanged: null,
      /* (value) {
        setState(() {
          _nationality = value;
        });
      }, */
      items: <String>[
        'WARGANEGARA',
        AppLocalizations.of(context).translate('foreigner_lbl')
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      /* validator: (value) {
        if (value == null) {
          return AppLocalizations.of(context)
              .translate('nationality_required_msg');
        }
        return null;
      }, */
    );
  }

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
      /* _nationality.isNotEmpty
          ? _nationality
          : AppLocalizations.of(context).translate('citizen_lbl'), */
      onChanged: (value) {
        setState(() {
          _race = value;
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
  }

  _genderSelection() {
    return Row(
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('gender_lbl'),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        Radio(
          activeColor: Color(0xffdd0e0e),
          value: Gender.male,
          groupValue: _gender,
          onChanged: (Gender value) {
            setState(() {
              _gender = value;
              _genderValue = 'MALE';
              // genderInt = '1';
            });
          },
        ),
        Text(
          AppLocalizations.of(context).translate('gender_male'),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        Radio(
          activeColor: Color(0xffdd0e0e),
          value: Gender.female,
          groupValue: _gender,
          onChanged: (Gender value) {
            setState(() {
              _gender = value;
              _genderValue = 'FEMALE';
              // genderInt = '0';
            });
          },
        ),
        Text(
          AppLocalizations.of(context).translate('gender_female'),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
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
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            AppLocalizations.of(context).translate('enroll_lbl'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ClipRect(
                child: Align(
                  alignment: Alignment.center,
                  heightFactor: 0.6,
                  child: FadeInImage(
                    alignment: Alignment.center,
                    placeholder: MemoryImage(kTransparentImage),
                    image: AssetImage(
                      myImage.tyreShop,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15.0),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _idField(),
                      SizedBox(
                        height: ScreenUtil().setHeight(60),
                      ),
                      _idNameField(),
                      SizedBox(
                        height: ScreenUtil().setHeight(60),
                      ),
                      /* _emailField(),
                      SizedBox(
                        height: ScreenUtil().setHeight(60),
                      ), */
                      /* _addressField(),
                      SizedBox(
                        height: ScreenUtil().setHeight(60),
                      ),
                      _postcodeField(),
                      SizedBox(
                        height: ScreenUtil().setHeight(60),
                      ), */
                      _dobField(),
                      SizedBox(
                        height: ScreenUtil().setHeight(60),
                      ),
                      _raceField(),
                      SizedBox(
                        height: ScreenUtil().setHeight(60),
                      ),
                      _nationalityField(),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      _genderSelection(),
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
                              _enrollButton(),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(60),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _enrollButton() {
    return Container(
      child: _isLoading
          ? SpinKitFoldingCube(
              color: Colors.greenAccent,
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
                    AppLocalizations.of(context).translate('submit_btn'),
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

      if (_message !=
          AppLocalizations.of(context).translate('enroll_underage')) {
        setState(() {
          _isLoading = true;
          _message = '';
        });

        var result = await authRepo.saveEnrollmentWithParticular(
          context: context,
          phoneCountryCode: _countryCode,
          diCode: widget.data.diCode,
          icNo: _icNo.replaceAll('-', ''),
          name: _icName,
          email: _email,
          groupId: widget.data.groupId,
          gender: _genderValue,
          dateOfBirthString: _dob,
          nationality: 'WARGANEGARA',
          race: _race,
        );

        if (result.isSuccess) {
          customDialog.show(
            context: context,
            barrierDismissable: false,
            title: Center(
              child: Icon(
                Icons.check_circle_outline,
                size: 120,
                color: Colors.green,
              ),
            ),
            content: AppLocalizations.of(context).translate('enroll_success'),
            type: DialogType.GENERAL,
            customActions: <Widget>[
              FlatButton(
                child: Text(AppLocalizations.of(context).translate('ok_btn')),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, HOME, (r) => false),
              ),
            ],
          );
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
}
