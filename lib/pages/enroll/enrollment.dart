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
  final FocusNode _dobFocus = FocusNode();
  // final FocusNode _genderFocus = FocusNode();
  // final FocusNode _nearbyDiFocus = FocusNode();
  // final FocusNode _nationalityFocus = FocusNode();

  final _dobController = TextEditingController();

  final primaryColor = ColorConstant.primaryColor;
  final localStorage = LocalStorage();
  bool _isLoading = false;
  String _icNo;
  String _icName;
  String _dob;
  // String _nationality = '';
  String _message = '';

  Gender _gender = Gender.male;
  String _genderValue = 'MALE';
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
        labelText: AppLocalizations.of(context).translate('ic_required_lbl'),
        fillColor: Colors.grey.withOpacity(.25),
        filled: true,
        prefixIcon: Icon(Icons.featured_video),
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
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        hintStyle: TextStyle(
          color: primaryColor,
        ),
        labelText:
            AppLocalizations.of(context).translate('ic_name_required_lbl'),
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

  _dobField() {
    return DateTimeField(
      focusNode: _dobFocus,
      format: format,
      controller: _dobController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(50),
        ),
        labelText: AppLocalizations.of(context).translate('dob_required_lbl'),
        fillColor: Colors.grey.withOpacity(.25),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(30),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(Icons.calendar_today),
      ),
      validator: (value) {
        if (value == null) {
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

  _genderSelection() {
    return Row(
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('gender_lbl'),
        ),
        Radio(
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
        ),
        Radio(
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
        ),
      ],
    );
  }

  /* _nationalityField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(10),
        ),
        labelText: AppLocalizations.of(context).translate('nationality_lbl'),
        fillColor: Colors.grey.withOpacity(.25),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(30),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(Icons.flag),
      ),
      value: _nationality.isNotEmpty
          ? _nationality
          : AppLocalizations.of(context).translate('citizen_lbl'),
      onChanged: (value) {
        setState(() {
          _nationality = value;
        });
      },
      items: <String>[
        AppLocalizations.of(context).translate('citizen_lbl'),
        AppLocalizations.of(context).translate('foreigner_lbl')
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return AppLocalizations.of(context)
              .translate('nationality_required_msg');
        }
        return null;
      },
    );
  } */

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('enroll_lbl'),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
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
                  _dobField(),
                  /* SizedBox(
                    height: ScreenUtil().setHeight(60),
                  ),
                  _nationalityField(), */
                  SizedBox(
                    height: ScreenUtil().setHeight(60),
                  ),
                  _genderSelection(),
                  SizedBox(
                    height: ScreenUtil().setHeight(60),
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
                      _enrollButton(),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(60),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _enrollButton() {
    return Container(
      child: _isLoading
          ? SpinKitFoldingCube(
              color: primaryColor,
            )
          : ButtonTheme(
              padding: EdgeInsets.all(0.0),
              shape: StadiumBorder(),
              child: RaisedButton(
                onPressed: _submit,
                textColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent.shade700, Colors.blue],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 15.0,
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

      setState(() {
        _isLoading = true;
        _message = '';
      });

      var result = await authRepo.saveEnrollmentWithParticular(
        context: context,
        diCode: widget.data.diCode,
        icNo: _icNo.replaceAll('-', ''),
        name: _icName,
        groupId: widget.data.groupId,
        gender: _genderValue,
        dateOfBirthString: _dob,
        nationality: 'WARGANEGARA',
      );

      if (result.isSuccess) {
        customDialog.show(
          context: context,
          content: AppLocalizations.of(context).translate('enroll_success'),
          type: DialogType.SUCCESS,
        );
        Navigator.pushNamedAndRemoveUntil(context, HOME, (r) => false);
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
