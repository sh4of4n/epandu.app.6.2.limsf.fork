import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/pages/enroll/enroll.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/common_library/services/repository/profile_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/common_library/utils/custom_snackbar.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:epandu/common_library/utils/uppercase_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';
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

  List<CameraDescription>? cameras;
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  final FocusNode _icFocus = FocusNode();
  final FocusNode _nickNameFocus = FocusNode();
  final FocusNode _postcodeFocus = FocusNode();
  final _dobController = TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  String? imagePath;
  String? _getName = '';
  String? _getEmail = '';
  String? _getPostcode = '';
  String? _getUserIc = '';
  String? _getBirthDate = '';
  String? _getNickName = '';
  String? _getRace = '';
  String? _getCdl = '';
  String? _getLdl = '';

  String _dob = '';
  String _ic = '';
  String _name = '';
  String _nickName = '';
  String _email = '';
  String _postcode = '';
  String? _message = '';
  bool _isLoading = false;
  String? _potentialDob = '';
  String profilePicBase64 = '';
  String? profilePicUrl = '';

  String? _race = '';
  String _raceParam = '';
  Gender? _gender = Gender.male;
  String _genderValue = 'MALE';

  String cupertinoDob = '';

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  late File _image;
  late File _croppedImage;
  var imageState;
  var ldlList;
  var cdlList;

  String? ldlItem = '';
  String? cdlItem = '';

  TextStyle _messageStyle = TextStyle(color: Colors.red);
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _icController = TextEditingController();
  final _nickNameController = TextEditingController();
  final _postcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_nameValue);
    _emailController.addListener(_emailValue);
    _dobController.addListener(_dobValue);
    _icController.addListener(_icValue);
    _nickNameController.addListener(_nickNameValue);
    _postcodeController.addListener(_postcodeValue);

    _getUserInfo();
    _getAvailableCameras();
    _getLdlkEnqGroupList();
    _getCdlList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _icController.dispose();
    _nickNameController.dispose();
    _postcodeController.dispose();
    _nameFocus.dispose();
    _nickNameFocus.dispose();
    _emailFocus.dispose();
    _dobFocus.dispose();
    _icFocus.dispose();
    _postcodeFocus.dispose();
    super.dispose();
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

  _getUserInfo() async {
    _getName = await localStorage.getName();
    _getEmail = await localStorage.getEmail();
    _getPostcode = await localStorage.getPostCode();
    _getBirthDate = await localStorage.getBirthDate();
    _getUserIc = await localStorage.getStudentIc();
    _getNickName = await localStorage.getNickName();
    _getRace = await localStorage.getRace();
    profilePicUrl = await localStorage.getProfilePic();
    _getCdl = await localStorage.getCdl();
    _getLdl = await localStorage.getLdl();

    _nameController.text = _getName!;
    _emailController.text = _getEmail!;
    _postcodeController.text = _getPostcode!;
    _dobController.text =
        _getBirthDate!.isNotEmpty ? _getBirthDate!.substring(0, 10) : '';
    _icController.text = _getUserIc!;
    _nickNameController.text = _getNickName!;

    if (_getRace == 'MALAY' || _getRace == 'M') {
      _race = 'Malay';
      _raceParam = 'M';
    } else if (_getRace == 'CHINESE' || _getRace == 'C') {
      _race = 'Chinese';
      _raceParam = 'C';
    } else if (_getRace == 'INDIAN' || _getRace == 'I') {
      _race = 'Indian';
      _raceParam = 'I';
    } else {
      _race = 'Others';
      _raceParam = 'O';
    }

    cdlItem = _getCdl;
    ldlItem = _getLdl;
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

  _postcodeValue() {
    setState(() {
      _postcode = _postcodeController.text;
    });
  }

  autoFillDob(value) {
    if (value.replaceAll('-', '').replaceAll(' ', '').length == 12) {
      setState(() {
        _potentialDob = value.substring(0, 7);

        String _year = _potentialDob!.substring(0, 2);
        int _currentYear = DateTime.now().year;
        int? _birthYear = 0;
        int _birthMonth = int.tryParse(_potentialDob!.substring(2, 4))!;
        int _birthDay = int.tryParse(_potentialDob!.substring(4, 6))!;

        if (_currentYear - int.tryParse('19' + _year)! < 70) {
          _birthYear = int.tryParse('19$_year');
          _message = '';
        } else if (_currentYear - int.tryParse('20' + _year)! < 16) {
          _birthYear = int.tryParse('20$_year');

          _message = AppLocalizations.of(context)!.translate('enroll_underage');
        }

        _dobController.text = DateFormat('yyyy-MM-dd').format(
          DateTime(_birthYear!, _birthMonth, _birthDay),
        );
      });

      if (int.tryParse(value
                  .replaceAll('-', '')
                  .replaceAll(' ', '')
                  .substring(11))! %
              2 ==
          0)
        _gender = Gender.female;
      else
        _gender = Gender.male;
    }
  }

  // Profile picture
  _profileImage() {
    if (profilePicUrl!.isNotEmpty && profilePicBase64.isEmpty) {
      return InkWell(
        onTap: _profilePicOption,
        child: Image.network(
          profilePicUrl!,
          width: 600.w,
          height: 600.w,
          fit: BoxFit.cover,
        ),
      );
    } else if (profilePicBase64.isNotEmpty && profilePicUrl!.isEmpty) {
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
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: Colors.blue,
              width: 1.5,
            ),
          ),
          onPressed: _profilePicOption,
          child: Text(AppLocalizations.of(context)!.translate('edit')),
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
          child: Text(AppLocalizations.of(context)!.translate('take_photo')),
          onPressed: () async {
            context.router.pop();
            var newProfilePic = await context.router.push(
              TakeProfilePicture(camera: cameras),
            );

            // String newProfilePic = await localStorage.getProfilePic();
            if (newProfilePic != null)
              setState(() {
                profilePicUrl = '';
                _image = File(newProfilePic as String);
                _editImage();
                // profilePicBase64 =
                //     base64Encode(File(newProfilePic).readAsBytesSync());
              });
          },
        ),
        SimpleDialogOption(
            child: Text(AppLocalizations.of(context)!
                .translate('choose_existing_photo')),
            onPressed: () {
              context.router.pop();
              _getImageGallery();
            }),
      ],
      type: DialogType.SIMPLE_DIALOG,
    );
  }

  Future _getImageGallery() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile?.path != null) {
      setState(() {
        _image = File(pickedFile!.path);
        imageState = AppState.picked;
      });

      _editImage();
    }
  }

  Future<void> _editImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _image.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      maxWidth: 512,
      maxHeight: 512,
    );

    if (croppedFile != null) {
      setState(() {
        _croppedImage = File(croppedFile.path);
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
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xfffdc013),
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.translate('update_profile'),
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
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      hintStyle: TextStyle(
                        color: primaryColor,
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xff808080),
                      ),
                      labelText: AppLocalizations.of(context)!
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
                            BorderSide(color: Colors.blue[700]!, width: 1.6),
                        // borderRadius: BorderRadius.circular(0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onFieldSubmitted: (term) {
                      fieldFocusChange(
                        context,
                        _icFocus,
                        _nameFocus,
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
                  SizedBox(height: 60.h),
                  TextFormField(
                    controller: _nameController,
                    focusNode: _nameFocus,
                    inputFormatters: [UpperCaseTextFormatter()],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      hintStyle: TextStyle(
                        color: primaryColor,
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xff808080),
                      ),
                      labelText: AppLocalizations.of(context)!
                          .translate('ic_name_lbl'),
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
                            BorderSide(color: Colors.blue[700]!, width: 1.6),
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
                      labelText: AppLocalizations.of(context)!
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
                            BorderSide(color: Colors.blue[700]!, width: 1.6),
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
                    // textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      hintStyle: TextStyle(
                        color: primaryColor,
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xff808080),
                      ),
                      labelText:
                          AppLocalizations.of(context)!.translate('email_lbl'),
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
                            BorderSide(color: Colors.blue[700]!, width: 1.6),
                        // borderRadius: BorderRadius.circular(0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onFieldSubmitted: (term) {
                      fieldFocusChange(
                        context,
                        _emailFocus,
                        _postcodeFocus,
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
                      labelText: AppLocalizations.of(context)!
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
                        borderSide: BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue[700]!, width: 1.6),
                        // borderRadius: BorderRadius.circular(0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!
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
                      labelText: AppLocalizations.of(context)!.translate('ldl'),
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
                        borderSide:
                            BorderSide(color: Colors.blue[700]!, width: 1.6),
                        // borderRadius: BorderRadius.circular(0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.badge),
                    ),
                    disabledHint:
                        Text(AppLocalizations.of(context)!.translate('ldl')),
                    onChanged: (value) {
                      setState(() {
                        ldlItem = value;
                      });
                    },
                    value: ldlItem!.isEmpty ? null : ldlItem,
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
                        return AppLocalizations.of(context)!
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
                      labelText: AppLocalizations.of(context)!.translate('cdl'),
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
                        borderSide:
                            BorderSide(color: Colors.blue[700]!, width: 1.6),
                        // borderRadius: BorderRadius.circular(0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.badge),
                    ),
                    disabledHint:
                        Text(AppLocalizations.of(context)!.translate('cdl')),
                    onChanged: (value) {
                      setState(() {
                        cdlItem = value;
                      });
                    },
                    value: cdlItem!.isEmpty
                        ? null
                        : cdlItem!.replaceAll('%20', ' '),
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
                        return AppLocalizations.of(context)!
                            .translate('cdl_required_msg');
                      }
                      return null;
                    },
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
                          _message!.isNotEmpty
                              ? Text(
                                  _message!,
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
        labelText: AppLocalizations.of(context)!.translate('dob_required_lbl'),
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
          borderSide: BorderSide(color: Colors.blue[700]!, width: 1.6),
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
          return AppLocalizations.of(context)!.translate('dob_required_msg');
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

          await showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return CupertinoActionSheet(
                title: const Text('Pick a date'),
                cancelButton: CupertinoActionSheetAction(
                  child: const Text('Cancel'),
                  onPressed: () => context.router.pop(),
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

                      context.router.pop();
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

  _raceField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.h,
        ),
        labelText: AppLocalizations.of(context)!.translate('race_lbl'),
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
          borderSide: BorderSide(color: Colors.blue[700]!, width: 1.6),
          // borderRadius: BorderRadius.circular(0),
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(Icons.people),
      ),
      disabledHint: Text(AppLocalizations.of(context)!.translate('race_lbl')),
      value: _race!.isEmpty ? null : _race,
      onChanged: (value) {
        setState(() {
          _race = value;
          if (value ==
              AppLocalizations.of(context)!.translate('malay_race_lbl'))
            _raceParam = 'M';
          else if (value ==
              AppLocalizations.of(context)!.translate('chinese_lbl'))
            _raceParam = 'C';
          else if (value ==
              AppLocalizations.of(context)!.translate('indian_lbl'))
            _raceParam = 'I';
          else
            _raceParam = 'O';
        });
      },
      items: <String>[
        AppLocalizations.of(context)!.translate('malay_race_lbl'),
        AppLocalizations.of(context)!.translate('chinese_lbl'),
        AppLocalizations.of(context)!.translate('indian_lbl'),
        AppLocalizations.of(context)!.translate('others_lbl'),
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return AppLocalizations.of(context)!.translate('race_required_msg');
        }
        return null;
      },
    );
  }

  _genderSelection() {
    return Row(
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.translate('gender_lbl'),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        Radio(
          activeColor: Color(0xffdd0e0e),
          value: Gender.male,
          groupValue: _gender,
          onChanged: (Gender? value) {
            setState(() {
              _gender = value;
              _genderValue = 'MALE';
              // genderInt = '1';
            });
          },
        ),
        Text(
          AppLocalizations.of(context)!.translate('gender_male'),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        Radio(
          activeColor: Color(0xffdd0e0e),
          value: Gender.female,
          groupValue: _gender,
          onChanged: (Gender? value) {
            setState(() {
              _gender = value;
              _genderValue = 'FEMALE';
              // genderInt = '0';
            });
          },
        ),
        Text(
          AppLocalizations.of(context)!.translate('gender_female'),
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
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(420.w, 45.h),
                padding: EdgeInsets.symmetric(vertical: 11.0),
                shape: StadiumBorder(),
                primary: Color(0xffdd0e0e),
                textStyle: TextStyle(color: Colors.white),
              ),
              onPressed: _submit,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 10.0,
                ),
                child: Text(
                  AppLocalizations.of(context)!.translate('save_btn'),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(56),
                  ),
                ),
              ),
            ),
    );
  }

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).requestFocus(new FocusNode());

      setState(() {
        _isLoading = true;
        _message = '';
      });

      var result = await profileRepo.saveUserProfile(
        context: context,
        name: _name.isNotEmpty ? _name : _getName,
        email: _email.isNotEmpty ? _email : _getEmail,
        postcode: _postcode.isNotEmpty ? _postcode : _getPostcode,
        icNo: _ic.isNotEmpty ? _ic.replaceAll('-', '') : _getUserIc,
        dateOfBirthString: _dob.isNotEmpty ? _dob : _getBirthDate,
        gender: _genderValue,
        nickName: _nickName.isNotEmpty ? _nickName : _getNickName,
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
          _messageStyle = TextStyle(color: Colors.green);
        });

        await authRepo.getUserRegisteredDI(context: context, type: 'UPDATE');

        context.router.pop(true);
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
