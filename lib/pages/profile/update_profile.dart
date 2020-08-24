import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/pages/enroll/enroll.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/services/repository/profile_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/custom_snackbar.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../app_localizations.dart';
import '../../router.gr.dart';

enum AppState { free, picked, cropped }

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> with PageBaseClass {
  final profileRepo = ProfileRepo();
  final authRepo = AuthRepo();
  final customSnackbar = CustomSnackbar();
  final _formKey = GlobalKey<FormState>();
  final customDialog = CustomDialog();
  final primaryColor = ColorConstant.primaryColor;
  final localStorage = LocalStorage();
  final picker = ImagePicker();

  List<CameraDescription> cameras;
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  final FocusNode _icFocus = FocusNode();
  final FocusNode _nickNameFocus = FocusNode();
  final _dobController = TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  String imagePath;
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
  String _potentialDob = '';
  String profilePicBase64 = '';
  String profilePicUrl = '';

  String _race = '';
  String _raceParam = '';
  Gender _gender = Gender.male;
  String _genderValue = 'MALE';

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  File _image;
  File _croppedImage;
  var imageState;

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
    _getAvailableCameras();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _icController.dispose();
    _nickNameController.dispose();
    super.dispose();
  }

  _getUserInfo() async {
    _getName = await localStorage.getName();
    _getEmail = await localStorage.getEmail();
    _getBirthDate = await localStorage.getBirthDate();
    _getUserIc = await localStorage.getStudentIc();
    _getNickName = await localStorage.getNickName();
    profilePicUrl = await localStorage.getProfilePic();

    _nameController.text = _getName;
    _emailController.text = _getEmail;
    _dobController.text =
        _getBirthDate.isNotEmpty ? _getBirthDate.substring(0, 10) : '';
    _icController.text = _getUserIc;
    _nickNameController.text = _getNickName;
  }

  _getAvailableCameras() async {
    cameras = await availableCameras();
  }

  _nickNameValue() {
    setState(() {
      _nickName = _nickNameController.text;
    });
  }

  _icValue() {
    setState(() {
      _ic = _icController.text;

      autoFillDob(_ic);
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
    }
  }

  // Profile picture
  _profileImage() {
    if (profilePicUrl.isNotEmpty && profilePicBase64.isEmpty) {
      return InkWell(
        onTap: _profilePicOption,
        child: Image.network(
          profilePicUrl,
          width: 600.w,
          height: 600.w,
          fit: BoxFit.cover,
        ),
      );
    } else if (profilePicBase64.isNotEmpty && profilePicUrl.isEmpty) {
      return InkWell(
        onTap: _profilePicOption,
        child: Image.memory(
          base64Decode(profilePicBase64),
          width: 600.w,
          height: 600.w,
          fit: BoxFit.cover,
          gaplessPlayback: true,
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
        OutlineButton(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 1.5,
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
            margin: EdgeInsets.symmetric(vertical: 50.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _profileImage(),
                  SizedBox(height: 40.h),
                  TextFormField(
                    controller: _icController,
                    focusNode: _icFocus,
                    // textInputAction: TextInputAction.next,
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
                      prefixIcon: Icon(Icons.featured_video),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          WidgetsBinding.instance.addPostFrameCallback(
                              (_) => _icController.clear());
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
                    // onFieldSubmitted: (term) {
                    //   fieldFocusChange(
                    //     context,
                    //     _icFocus,
                    //     _dobFocus,
                    //   );
                    // },
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
                  SizedBox(height: 60.h),
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
                          WidgetsBinding.instance.addPostFrameCallback(
                              (_) => _nameController.clear());
                          // _nameController.text = '';
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
                          WidgetsBinding.instance.addPostFrameCallback(
                              (_) => _nickNameController.clear());
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
                          WidgetsBinding.instance.addPostFrameCallback(
                              (_) => _emailController.clear());
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
                  _dobField(),
                  SizedBox(height: 60.h),
                  _raceField(),
                  SizedBox(height: 60.h),
                  _genderSelection(),
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
        if (Platform.isIOS) {
          if (_dobController.text.isEmpty) {
            setState(() {
              _dobController.text = DateFormat('yyyy-MM-dd').format(
                DateTime(2000, 1, 1),
              );
            });
          }

          await showModalBottomSheet(
            context: context,
            builder: (context) {
              return CupertinoDatePicker(
                initialDateTime: DateTime.parse(_dobController.text),
                onDateTimeChanged: (DateTime date) {
                  setState(() {
                    _dobController.text = DateFormat('yyyy-MM-dd').format(date);
                  });
                },
                minimumYear: 1920,
                maximumYear: DateTime.now().year,
                mode: CupertinoDatePickerMode.date,
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
        userProfileImageBase64String: profilePicBase64,
        removeUserProfileImage: false,
        race: _race,
      );

      if (result.isSuccess) {
        setState(() {
          _message = result.message;
          _messageStyle = TextStyle(color: Colors.green);
        });

        await authRepo.getUserRegisteredDI(context: context, type: 'UPDATE');

        ExtendedNavigator.of(context).pop(true);
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
