import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/common_library/services/model/auth_model.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:epandu/common_library/services/repository/profile_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/common_library/utils/custom_snackbar.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';
import '../../router.gr.dart';

enum Gender { male, female }
enum AppState { free, picked, cropped }

class Enrollment extends StatefulWidget {
  @override
  _EnrollmentState createState() => _EnrollmentState();
}

class _EnrollmentState extends State<Enrollment> with PageBaseClass {
  final authRepo = AuthRepo();
  final epanduRepo = EpanduRepo();
  final profileRepo = ProfileRepo();
  final customDialog = CustomDialog();
  final customSnackbar = CustomSnackbar();
  final format = DateFormat("yyyy-MM-dd");

  final _formKey = GlobalKey<FormState>();

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  final FocusNode _idFocus = FocusNode();
  final FocusNode _idNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  // final FocusNode _addressFocus = FocusNode();
  // final FocusNode _postcodeFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  // final FocusNode _genderFocus = FocusNode();
  // final FocusNode _nearbyDiFocus = FocusNode();
  // final FocusNode _nationalityFocus = FocusNode();
  final FocusNode _nickNameFocus = FocusNode();
  final FocusNode _postcodeFocus = FocusNode();

  // final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _idNameController = TextEditingController();
  final _icNoController = TextEditingController();
  final _dobController = TextEditingController();
  final _nickNameController = TextEditingController();
  final _postcodeController = TextEditingController();

  final primaryColor = ColorConstant.primaryColor;
  final localStorage = LocalStorage();
  bool _isLoading = false;
  String _icNo = '';
  String _icName = '';
  String _email = '';
  String _postcode = '';
  // String _address = '';
  // String _postcode = '';
  String _dob = '';
  // String _nationality = '';
  String _race = '';
  String _raceParam = '';
  String _message = '';
  bool _obtainingStatus = true;

  String _nickName = '';
  Gender _gender = Gender.male;
  String _genderValue = 'MALE';
  // String _countryCode = '+60';
  String _potentialDob = '';
  final myImage = ImagesConstant();
  var _enrollHistoryData;
  // String genderInt = '1';

  final hintStyle = TextStyle(
    color: Colors.black,
  );

  final textStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 62.sp,
  );

  TextStyle _messageStyle = TextStyle(color: Colors.red);

  // String countryCode = '';
  String phone = '';

  List<CameraDescription> cameras;
  final picker = ImagePicker();
  String profilePicUrl = '';
  String profilePicBase64 = '';
  File _image;
  File _croppedImage;
  var imageState;
  var ldlList;
  var cdlList;

  String ldlItem = '';
  String cdlItem = '';

  String cupertinoDob = '';

  @override
  void initState() {
    super.initState();

    // _phoneController.addListener(_phoneValue);
    _nickNameController.addListener(_nickNameValue);
    _emailController.addListener(_emailValue);
    _idNameController.addListener(_idNameValue);
    _icNoController.addListener(_icNoValue);
    _dobController.addListener(_dobValue);
    _postcodeController.addListener(_postcodeValue);

    _getEnrollHistory();
    _getParticulars();
    _getAvailableCameras();
    _getLdlkEnqGroupList();
    _getCdlList();
  }

  Future<void> _getLdlkEnqGroupList() async {
    var result = await authRepo.getLdlkEnqGroupList();

    if (result.isSuccess) {
      setState(() {
        ldlList = result.data;
      });
    }
  }

  Future<void> _getCdlList() async {
    var result = await authRepo.getCdlList();

    if (result.isSuccess) {
      setState(() {
        cdlList = result.data;
      });
    }
  }

  Future<dynamic> _getEnrollHistory() async {
    // return _memoizer.runOnce(() async {
    var result = await authRepo.getEnrollHistory();

    if (result.isSuccess) {
      setState(() {
        _enrollHistoryData = result.data;
        _obtainingStatus = false;
      });
    } else {
      setState(() {
        _obtainingStatus = false;
      });
    }
    // });
  }

  _getParticulars() async {
    var result = await profileRepo.getUserProfile(context: context);

    // String getCountryCode = await localStorage.getCountryCode();
    // String getPhone = await localStorage.getUserPhone();
    // String getEmail = await localStorage.getEmail();
    // String getIcName = await localStorage.getName();
    // String _getIcNo = await localStorage.getStudentIc();
    // String _getDob = await localStorage.getBirthDate();
    // String _getProfilePic = await localStorage.getProfilePic();

    if (mounted) {
      setState(() {
        // _phoneController.text = result.data[0].phone;
        _nickNameController.text = result.data[0].nickName;
        _emailController.text = result.data[0].eMail;
        _idNameController.text = result.data[0].name;
        _icNoController.text = result.data[0].icNo;
        _dobController.text = result.data[0].birthDate;
        if (result.data[0].race == 'MALAY' || result.data[0].race == 'M') {
          _race = 'Malay';
          _raceParam = 'M';
        } else if (result.data[0].race == 'CHINESE' ||
            result.data[0].race == 'C') {
          _race = 'Chinese';
          _raceParam = 'C';
        } else if (result.data[0].race == 'INDIAN' ||
            result.data[0].race == 'I') {
          _race = 'Indian';
          _raceParam = 'I';
        } else {
          _race = 'Others';
          _raceParam = 'O';
        }
        profilePicUrl = result.data[0].picturePath != null &&
                result.data[0].picturePath.isNotEmpty
            ? result.data[0].picturePath
                .replaceAll(removeBracket, '')
                .split('\r\n')[0]
            : '';

        if (_icNo != null && _icNo.isNotEmpty) {
          autoFillDob(_icNo);
        }
      });
    }
  }

  /* _phoneValue() {
    setState(() {
      phone = _phoneController.text;
    });
  } */

  _nickNameValue() {
    setState(() {
      _nickName = _nickNameController.text;
    });
  }

  _emailValue() {
    setState(() {
      _email = _emailController.text;
    });
  }

  _idNameValue() {
    setState(() {
      _icName = _idNameController.text;
    });
  }

  _icNoValue() {
    setState(() {
      _icNo = _icNoController.text;
    });
  }

  _dobValue() {
    setState(() {
      _dob = _dobController.text;
    });
  }

  _postcodeValue() {
    setState(() {
      _postcode = _postcodeController.text;
    });
  }

  /* _phoneField() {
    return TextFormField(
      enabled: false,
      controller: _phoneController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        hintStyle: TextStyle(
          color: primaryColor,
        ),
        labelStyle: TextStyle(
          color: Color(0xff808080),
        ),
        labelText: AppLocalizations.of(context).translate('contact_no'),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(Icons.phone_iphone),
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
    );
  } */

  _nickNameField() {
    return TextFormField(
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
        labelText: AppLocalizations.of(context).translate('nick_name_lbl'),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(Icons.assignment_ind),
        suffixIcon: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _nickNameController.clear());
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
          borderSide: BorderSide(color: Colors.blue[700], width: 1.6),
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
    );
  }

  _emailField() {
    return TextFormField(
      controller: _emailController,
      focusNode: _emailFocus,
      // textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        suffixIcon: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _emailController.clear());
          },
        ),
        hintStyle: TextStyle(
          color: primaryColor,
        ),
        labelStyle: TextStyle(
          color: Color(0xff808080),
        ),
        labelText: AppLocalizations.of(context).translate('email_lbl'),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(Icons.mail),
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
      /* onFieldSubmitted: (term) {
        fieldFocusChange(
          context,
          _emailFocus,
          _dobFocus,
        );
      }, */
    );
  }

  _idNameField() {
    return TextFormField(
      focusNode: _idNameFocus,
      controller: _idNameController,
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
          _nickNameFocus,
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

  _idField() {
    return TextFormField(
      focusNode: _idFocus,
      controller: _icNoController,
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

          autoFillDob(value);
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
        /* suffixIcon: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _dobController.clear());
          },
        ), */
      ),
      validator: (value) {
        if (_dobController.text.isEmpty) {
          return AppLocalizations.of(context).translate('dob_required_msg');
        }
        return null;
      },
      onShowPicker: (context, currentValue) async {
        if (Platform.isAndroid) {
          if (_dobController.text.isEmpty) {
            setState(() {
              _dobController.text = DateFormat('yyyy-MM-dd').format(
                DateTime(2000, 1, 1),
              );
            });
          }

          await showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return CupertinoActionSheet(
                title: const Text('Pick a date'),
                cancelButton: CupertinoActionSheetAction(
                  child: const Text('Cancel'),
                  onPressed: () => ExtendedNavigator.of(context).pop(),
                ),
                actions: <Widget>[
                  SizedBox(
                    height: 900.h,
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime.parse(_dobController.text),
                      onDateTimeChanged: (DateTime date) {
                        setState(() {
                          cupertinoDob = DateFormat('yyyy-MM-dd').format(date);
                        });
                      },
                      minimumYear: 1920,
                      maximumYear: DateTime.now().year,
                      mode: CupertinoDatePickerMode.date,
                    ),
                  ),
                  CupertinoActionSheetAction(
                    child: const Text('Confirm'),
                    onPressed: () {
                      setState(() {
                        if (cupertinoDob.isNotEmpty) {
                          _dobController.text = cupertinoDob;
                        }
                      });

                      ExtendedNavigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1920),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime.now());
        }
        return null;
      },
    );
  }

  /* _nationalityField() {
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
  } */

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

  _getRaceValue(race) {
    setState(() {
      _raceParam = race;
    });

    if (race == 'M')
      return AppLocalizations.of(context).translate('malay_race_lbl');
    else if (race == 'C')
      return AppLocalizations.of(context).translate('chinese_lbl');
    else if (race == 'I')
      return AppLocalizations.of(context).translate('indian_lbl');
    else if (race == 'O')
      return AppLocalizations.of(context).translate('others_lbl');
    else
      return '';
  }

  autoFillDob(value) {
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

          _message = AppLocalizations.of(context).translate('enroll_underage');
        }

        _dobController.text = DateFormat('yyyy-MM-dd').format(
          DateTime(_birthYear, _birthMonth, _birthDay),
        );
      });

      if (int.tryParse(
                  value.replaceAll('-', '').replaceAll(' ', '').substring(11)) %
              2 ==
          0)
        _gender = Gender.female;
      else
        _gender = Gender.male;
    }
  }

  // Profile picture
  _getAvailableCameras() async {
    cameras = await availableCameras();
  }

  _profileImage() {
    if (profilePicUrl.isNotEmpty && profilePicBase64.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(bottom: 60.h),
        child: InkWell(
          onTap: _profilePicOption,
          child: Image.network(
            profilePicUrl,
            width: 600.w,
            height: 600.w,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (profilePicBase64.isNotEmpty && profilePicUrl.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(bottom: 60.h),
        child: InkWell(
          onTap: _profilePicOption,
          child: Image.memory(
            base64Decode(profilePicBase64),
            width: 600.w,
            height: 600.w,
            fit: BoxFit.cover,
            gaplessPlayback: true,
          ),
        ),
      );
    }
    return Column(
      children: <Widget>[
        IconButton(
          onPressed: _profilePicOption,
          icon: Icon(
            Icons.account_circle,
            color: Colors.grey[850],
          ),
          iconSize: 70,
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: Colors.blue,
              width: 1.5,
            ),
          ),
          onPressed: _profilePicOption,
          child: Text(AppLocalizations.of(context).translate('edit')),
        ),
      ],
    );
  }

  _profilePicOption() {
    customDialog.show(
      context: context,
      content: '',
      customActions: <Widget>[
        SimpleDialogOption(
          child: Text(AppLocalizations.of(context).translate('take_photo')),
          onPressed: () async {
            ExtendedNavigator.of(context).pop();
            var newProfilePic = await ExtendedNavigator.of(context).push(
                Routes.takeProfilePicture,
                arguments: TakeProfilePictureArguments(camera: cameras));

            // String newProfilePic = await localStorage.getProfilePic();
            if (newProfilePic != null)
              setState(() {
                profilePicUrl = '';
                _image = File(newProfilePic);
                _editImage();
                // profilePicBase64 =
                //     base64Encode(File(newProfilePic).readAsBytesSync());
              });
          },
        ),
        SimpleDialogOption(
            child: Text(AppLocalizations.of(context)
                .translate('choose_existing_photo')),
            onPressed: () {
              ExtendedNavigator.of(context).pop();
              _getImageGallery();
            }),
      ],
      type: DialogType.SIMPLE_DIALOG,
    );
  }

  Future _getImageGallery() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile?.path != null) {
      setState(() {
        _image = File(pickedFile.path);
        imageState = AppState.picked;
      });

      _editImage();
    }
  }

  Future<void> _editImage() async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: _image.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      maxWidth: 512,
      maxHeight: 512,
    );

    if (croppedFile != null) {
      setState(() {
        _croppedImage = croppedFile;
        imageState = AppState.cropped;
        profilePicBase64 = base64Encode(_croppedImage.readAsBytesSync());
        profilePicUrl = '';

        // localStorage
        //     .saveProfilePic(base64Encode(_croppedImage.readAsBytesSync()));
      });

      // if (_croppedImage != null) {
      //   _uploadImage(fileDirectory, "CROP");
      // }
    }
  }
  // End profile picture //

  _checkEnrollmentStatus() {
    if (_obtainingStatus) {
      return Column(
        children: <Widget>[
          Expanded(
            child: SpinKitFoldingCube(
              color: Colors.blue,
            ),
          ),
        ],
      );
    }
    if (_enrollHistoryData == null && _obtainingStatus == false) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            /* ClipRect(
              child: Align(
                alignment: Alignment.center,
                // heightFactor: 0.6,
                child: FadeInImage(
                  alignment: Alignment.center,
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage(
                    myImage.advertBanner,
                  ),
                ),
              ),
            ), */
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: _profileImage(),
                    ),
                    SizedBox(height: 60.h),
                    _idField(),
                    SizedBox(
                      height: ScreenUtil().setHeight(60),
                    ),
                    _idNameField(),
                    SizedBox(
                      height: ScreenUtil().setHeight(60),
                    ),
                    // _phoneField(),
                    _nickNameField(),
                    SizedBox(
                      height: ScreenUtil().setHeight(60),
                    ),
                    _emailField(),
                    SizedBox(
                      height: ScreenUtil().setHeight(60),
                    ),
                    /* _addressField(),
                      SizedBox(
                        height: ScreenUtil().setHeight(60),
                      ),
                      _postcodeField(),
                      SizedBox(
                        height: ScreenUtil().setHeight(60),
                      ), */
                    SizedBox(height: 60.h),
                    TextFormField(
                      controller: _postcodeController,
                      focusNode: _postcodeFocus,
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
                            .translate('postcode_lbl'),
                        prefixIcon: Icon(Icons.home),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            WidgetsBinding.instance.addPostFrameCallback(
                                (_) => _postcodeController.clear());
                          },
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue[700], width: 1.6),
                          // borderRadius: BorderRadius.circular(0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalizations.of(context)
                              .translate('postcode_required_msg');
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0.h,
                        ),
                        labelText:
                            AppLocalizations.of(context).translate('ldl'),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue[700], width: 1.6),
                          // borderRadius: BorderRadius.circular(0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: Icon(Icons.badge),
                      ),
                      disabledHint:
                          Text(AppLocalizations.of(context).translate('ldl')),
                      onChanged: (value) {
                        setState(() {
                          ldlItem = value;
                        });
                      },
                      items: ldlList == null
                          ? null
                          : ldlList
                              .map<DropdownMenuItem<String>>((dynamic value) {
                              return DropdownMenuItem<String>(
                                value: value.groupId,
                                child: Text(value.groupId),
                              );
                            }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return AppLocalizations.of(context)
                              .translate('ldl_required_msg');
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(70),
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0.h,
                        ),
                        labelText:
                            AppLocalizations.of(context).translate('cdl'),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue[700], width: 1.6),
                          // borderRadius: BorderRadius.circular(0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: Icon(Icons.badge),
                      ),
                      disabledHint:
                          Text(AppLocalizations.of(context).translate('cdl')),
                      onChanged: (value) {
                        setState(() {
                          cdlItem = value;
                        });
                      },
                      items: cdlList == null
                          ? null
                          : cdlList
                              .map<DropdownMenuItem<String>>((dynamic value) {
                              return DropdownMenuItem<String>(
                                value: value.groupId,
                                child: Text(value.groupId),
                              );
                            }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return AppLocalizations.of(context)
                              .translate('cdl_required_msg');
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(70),
                    ),
                    _dobField(),
                    SizedBox(
                      height: ScreenUtil().setHeight(60),
                    ),
                    _raceField(),
                    SizedBox(
                      height: ScreenUtil().setHeight(60),
                    ),
                    /*  _nationalityField(),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ), */
                    _genderSelection(),
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
      );
    }
    return _showEnrollmentData();
  }

  _showEnrollmentData() {
    setState(() {
      _icNo = _enrollHistoryData[0].icNo;
      _icName = _enrollHistoryData[0].name;
      _dob = _enrollHistoryData[0].birthDt.substring(0, 10);
      _race = _enrollHistoryData[0].race;
      // _nationality = _enrollHistoryData[0].citizenship;
      if (_enrollHistoryData[0].sex == 'L') {
        _genderValue = 'MALE';
      } else {
        _genderValue = 'FEMALE';
      }
    });

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ClipRect(
            child: Align(
              alignment: Alignment.center,
              // heightFactor: 0.6,
              child: FadeInImage(
                alignment: Alignment.center,
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(
                  myImage.advertBanner,
                ),
              ),
            ),
          ),
          SizedBox(height: 50.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 80.w),
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context)
                  .translate('you_have_enrolled_before'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 80.sp,
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 80.w),
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context).translate('previous_credentials'),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 65.sp,
              ),
            ),
          ),
          Container(
            width: ScreenUtil().screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 80.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40.h),
                Text(
                  AppLocalizations.of(context).translate('ic_lbl'),
                  style: hintStyle,
                ),
                Text(
                  _enrollHistoryData[0].icNo != null
                      ? _enrollHistoryData[0].icNo
                      : '',
                  style: textStyle,
                ),
                SizedBox(height: 40.h),
                Text(
                  AppLocalizations.of(context).translate('ic_name_lbl'),
                  style: hintStyle,
                ),
                Text(
                  _enrollHistoryData[0].name != null
                      ? _enrollHistoryData[0].name
                      : '',
                  style: textStyle,
                ),
                SizedBox(height: 40.h),
                Text(
                  AppLocalizations.of(context).translate('dob_lbl'),
                  style: hintStyle,
                ),
                Text(
                  _enrollHistoryData[0].birthDt != null
                      ? _enrollHistoryData[0].birthDt.substring(0, 10)
                      : '',
                  style: textStyle,
                ),
                SizedBox(height: 40.h),
                Text(
                  AppLocalizations.of(context).translate('race_lbl'),
                  style: hintStyle,
                ),
                Text(
                  _getRaceValue(_enrollHistoryData[0].race),
                  style: textStyle,
                ),
                SizedBox(height: 40.h),
                Text(
                  AppLocalizations.of(context).translate('nationality_lbl'),
                  style: hintStyle,
                ),
                Text(
                  _enrollHistoryData[0].citizenship != null
                      ? _enrollHistoryData[0].citizenship
                      : '',
                  style: textStyle,
                ),
                SizedBox(height: 40.h),
                Text(
                  AppLocalizations.of(context).translate('gender_lbl'),
                  style: hintStyle,
                ),
                Text(
                  _enrollHistoryData[0].sex != null
                      ? _enrollHistoryData[0].sex == 'L'
                          ? AppLocalizations.of(context)
                              .translate('gender_male')
                          : AppLocalizations.of(context)
                              .translate('gender_female')
                      : '',
                  style: textStyle,
                ),
                SizedBox(height: 40.h),
                Center(
                  child: ButtonTheme(
                    padding: EdgeInsets.all(0.0),
                    shape: StadiumBorder(),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffdd0e0e),
                        textStyle: TextStyle(color: Colors.white),
                      ),
                      onPressed: _next,
                      child: Text(
                        AppLocalizations.of(context).translate('next_btn'),
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(60),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
        body: _checkEnrollmentStatus(),
      ),
    );
  }

  _enrollButton() {
    return Container(
      child: _isLoading
          ? SpinKitFoldingCube(
              color: Colors.blue,
            )
          : ButtonTheme(
              padding: EdgeInsets.all(0.0),
              shape: StadiumBorder(),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffdd0e0e),
                  textStyle: TextStyle(color: Colors.white),
                ),
                onPressed: _next,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    AppLocalizations.of(context).translate('next_btn'),
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(56),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  _next() async {
    if (_enrollHistoryData == null) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        FocusScope.of(context).requestFocus(new FocusNode());
        if (_message !=
            AppLocalizations.of(context).translate('enroll_underage')) {
          setState(() {
            _isLoading = true;
            _message = '';
          });

          var result = await profileRepo.saveUserProfile(
            context: context,
            name: _icName,
            email: _email,
            postcode: _postcode,
            icNo: _icNo,
            dateOfBirthString: _dob,
            gender: _genderValue,
            nickName: _nickName,
            userProfileImageBase64String: profilePicBase64,
            removeUserProfileImage: false,
            race: _raceParam,
            enqLdlGroup: ldlItem,
            cdlGroup: cdlItem,
            findDrvJobs: false,
          );

          if (result.isSuccess) {
            setState(() {
              _message = result.message;
              _messageStyle = TextStyle(color: Colors.green[800]);
            });

            ExtendedNavigator.of(context).push(
              Routes.selectInstitute,
              arguments: SelectInstituteArguments(
                data: EnrollmentData(
                  icNo: _icNo.replaceAll('-', ''),
                  name: _icName,
                  email: _email,
                  gender: _genderValue,
                  dateOfBirthString: _dob,
                  nationality: 'WARGANEGARA',
                  race: _raceParam,
                  profilePic: profilePicBase64,
                ),
              ),
            );
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
    } else {
      ExtendedNavigator.of(context).push(
        Routes.selectInstitute,
        arguments: SelectInstituteArguments(
          data: EnrollmentData(
            icNo: _icNo.replaceAll('-', ''),
            name: _icName,
            email: _email,
            gender: _genderValue,
            dateOfBirthString: _dob,
            nationality: 'WARGANEGARA',
            race: _raceParam,
            profilePic: profilePicBase64,
          ),
        ),
      );
    }
  }
}
