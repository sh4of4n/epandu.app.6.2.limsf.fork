import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/services/repo/auth_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_snackbar.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../app_localizations.dart';

enum Gender { male, female }

class Enrollment extends StatefulWidget {
  @override
  _EnrollmentState createState() => _EnrollmentState();
}

class _EnrollmentState extends State<Enrollment> with PageBaseClass {
  final authRepo = AuthRepo();
  final customSnackbar = CustomSnackbar();

  final _formKey = GlobalKey<FormState>();

  final FocusNode _idFocus = FocusNode();
  final FocusNode _idNameFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  final FocusNode _genderFocus = FocusNode();
  final FocusNode _nearbyDiFocus = FocusNode();
  // final FocusNode _nationalityFocus = FocusNode();

  final primaryColor = ColorConstant.primaryColor;

  final localStorage = LocalStorage();

  bool _isLoading = false;

  String _icNo;
  String _icName;
  String _dob;
  String _nearbyDi;
  String _nationality;
  String _message = '';

  Gender _gender = Gender.male;
  String genderInt = '1';

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
          _idNameFocus,
        );
      },
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate('ic_required_msg');
        }
        return null;
      },
      onSaved: (value) {
        if (value != _icNo) {
          _icNo = value;
        }
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
      onSaved: (value) {
        if (value != _icNo) {
          _icName = value;
        }
      },
    );
  }

  _dobField() {
    return TextFormField(
      focusNode: _dobFocus,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        hintStyle: TextStyle(
          color: primaryColor,
        ),
        labelText: AppLocalizations.of(context).translate('dob_required_lbl'),
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
          _dobFocus,
          _genderFocus,
        );
      },
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).translate('dob_required_msg');
        }
        return null;
      },
      onSaved: (value) {
        if (value != _icNo) {
          _dob = value;
        }
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
              genderInt = '1';
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
              genderInt = '0';
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
    return TextFormField(
      focusNode: _nationalityFocus,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        hintStyle: TextStyle(
          color: primaryColor,
        ),
        labelText:
            AppLocalizations.of(context).translate('nationality_required_lbl'),
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
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context)
              .translate('nationality_required_msg');
        }
        return null;
      },
      onSaved: (value) {
        if (value != _icNo) {
          _gender = value;
        }
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
                  // SizedBox(
                  //   height: ScreenUtil.getInstance().setHeight(35),
                  // ),
                  // _phoneField(),
                  // SizedBox(
                  //   height: ScreenUtil.getInstance().setHeight(60),
                  // ),
                  // _nickNameField(),
                  // SizedBox(
                  //   height: ScreenUtil.getInstance().setHeight(60),
                  // ),
                  _idField(),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(60),
                  ),
                  _idNameField(),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(60),
                  ),
                  _dobField(),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(60),
                  ),
                  _genderSelection(),
                  // SizedBox(
                  //   height: ScreenUtil.getInstance().setHeight(60),
                  // ),
                  // _nearbyDiField(),
                  // SizedBox(
                  //   height: ScreenUtil.getInstance().setHeight(60),
                  // ),
                  // _nationalityField(),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(60),
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
                    height: ScreenUtil.getInstance().setHeight(60),
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
                onPressed: () {},
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
                      fontSize: ScreenUtil.getInstance().setSp(56),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  /* _submit() async {
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
        customSnackbar.show(
          context,
          message: result.message.toString(),
          type: MessageType.SUCCESS,
          duration: 3000,
        );
        Navigator.pop(context);
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
  } */
}
