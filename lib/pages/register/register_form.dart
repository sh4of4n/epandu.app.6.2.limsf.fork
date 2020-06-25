import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:epandu/app_localizations.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/services/location.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/device_info.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:epandu/widgets/loading_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

enum AppState { free, picked, cropped }

class RegisterForm extends StatefulWidget {
  final data;

  RegisterForm(this.data);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> with PageBaseClass {
  final authRepo = AuthRepo();
  final customDialog = CustomDialog();

  final _formKey = GlobalKey<FormState>();

  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _nickNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final primaryColor = ColorConstant.primaryColor;

  final localStorage = LocalStorage();
  Location location = Location();

  bool _isLoading = false;
  bool _loginLoading = false;
  final image = ImagesConstant();

  String _phone = '';
  String _name = '';
  String _nickName = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _message = '';
  String _latitude = '';
  String _longitude = '';

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  DeviceInfo deviceInfo = DeviceInfo();
  String _deviceBrand = '';
  String _deviceModel = '';
  String _deviceVersion = '';
  String _deviceId = '';
  String _deviceOs = '';

  List<CameraDescription> cameras;
  final picker = ImagePicker();
  String profilePic = '';
  File _image;
  File _croppedImage;
  var imageState;

  TextStyle inputStyle = TextStyle(
    fontSize: 35.sp,
  );

  @override
  void initState() {
    super.initState();

    setState(() {
      _phone = widget.data.phoneCountryCode + widget.data.phone;
    });

    // _getCurrentLocation();
    _getDeviceInfo();
    _getAvailableCameras();
  }

  /* _getCurrentLocation() async {
    await location.getCurrentLocation();

    setState(() {
      _latitude =
          location.latitude != null ? location.latitude.toString() : '999';
      _longitude =
          location.longitude != null ? location.longitude.toString() : '999';
    });

    // print('$_latitude, $_longitude');
  } */

  _getDeviceInfo() async {
    // get device info
    await deviceInfo.getDeviceInfo();

    _deviceBrand = deviceInfo.manufacturer;
    _deviceModel = deviceInfo.model;
    _deviceVersion = deviceInfo.version;
    _deviceId = deviceInfo.id;
    _deviceOs = deviceInfo.os;

    // print('deviceId: ' + deviceId);
  }

  // Profile picture
  _getAvailableCameras() async {
    cameras = await availableCameras();
  }

  _profileImage() {
    if (profilePic.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.only(bottom: 70.h),
        child: InkWell(
          onTap: _profilePicOption,
          child: Image.memory(
            base64Decode(profilePic),
            width: 600.w,
            height: 600.w,
            fit: BoxFit.cover,
            gaplessPlayback: true,
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 70.h),
      child: Column(
        children: <Widget>[
          IconButton(
            onPressed: _profilePicOption,
            icon: Icon(
              Icons.account_circle,
              color: Colors.grey[850],
            ),
            iconSize: 80,
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
      ),
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
            Navigator.pop(context);
            var newProfilePic = await Navigator.pushNamed(
                context, TAKE_PROFILE_PICTURE,
                arguments: cameras);

            if (newProfilePic != null)
              setState(() {
                profilePic = '';
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
              Navigator.pop(context);
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
        profilePic = base64Encode(_croppedImage.readAsBytesSync());

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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 600) {
        return defaultLayout();
      }
      return tabLayout();
    });
  }

  defaultLayout() {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              primaryColor,
            ],
            stops: [0.60, 0.90],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Image.asset(image.logo2, height: 90.h),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 130.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil().setHeight(35),
                        ),
                        Center(
                          child: _profileImage(),
                        ),
                        TextFormField(
                          focusNode: _phoneFocus,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          enabled: false,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: -10.h),
                            hintStyle: TextStyle(
                              color: primaryColor,
                            ),
                            labelText: AppLocalizations.of(context)
                                .translate('login_id'),
                            labelStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                            prefixIcon: Icon(Icons.phone_android),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(context, _phoneFocus, _nameFocus);
                          },
                          initialValue: _phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .translate('phone_required_msg');
                            }
                            return null;
                          },
                          onChanged: (value) {
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
                            contentPadding:
                                EdgeInsets.symmetric(vertical: -10.h),
                            hintStyle: TextStyle(
                              color: primaryColor,
                            ),
                            labelText: AppLocalizations.of(context)
                                .translate('ic_name_lbl'),
                            labelStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                            prefixIcon: Icon(Icons.account_circle),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                                context, _nameFocus, _nickNameFocus);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .translate('ic_name_required_msg');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value != _name) {
                              _name = value;
                            }
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(70),
                        ),
                        TextFormField(
                          focusNode: _nickNameFocus,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: -10.h),
                            hintStyle: TextStyle(
                              color: primaryColor,
                            ),
                            labelText: AppLocalizations.of(context)
                                .translate('nick_name_lbl'),
                            labelStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                            prefixIcon: Icon(Icons.account_circle),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                                context, _nickNameFocus, _emailFocus);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .translate('nick_name_required_msg');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value != _nickName) {
                              _nickName = value;
                            }
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(70),
                        ),
                        TextFormField(
                          focusNode: _emailFocus,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: -10.h),
                            hintStyle: TextStyle(
                              color: primaryColor,
                            ),
                            labelText: AppLocalizations.of(context)
                                .translate('email_lbl'),
                            labelStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                            prefixIcon: Icon(Icons.mail),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                                context, _emailFocus, _passwordFocus);
                          },
                          /* validator: (value) {
                            if (value.isEmpty) {
                              return 'Email is required.';
                            }
                          }, */
                          onChanged: (value) {
                            if (value != _email) {
                              _email = value;
                            }
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(70),
                        ),
                        TextFormField(
                          focusNode: _passwordFocus,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: -10.h),
                            hintStyle: TextStyle(color: primaryColor),
                            labelText: AppLocalizations.of(context)
                                .translate('password_lbl'),
                            labelStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(
                                  () {
                                    _obscurePassword = !_obscurePassword;
                                  },
                                );
                              },
                            ),
                          ),
                          obscureText: _obscurePassword,
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                                context, _passwordFocus, _confirmPasswordFocus);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .translate('password_required_msg');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value != _password) {
                              _password = value;
                            }
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(70),
                        ),
                        TextFormField(
                          focusNode: _confirmPasswordFocus,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: -10.h),
                            hintStyle: TextStyle(color: primaryColor),
                            labelText: AppLocalizations.of(context)
                                .translate('confirm_password'),
                            labelStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(
                                  () {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  },
                                );
                              },
                            ),
                          ),
                          obscureText: _obscureConfirmPassword,
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .translate('confirm_password_required');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value != _confirmPassword) {
                              _confirmPassword = value;
                            }
                          },
                        ),
                        SizedBox(height: 40.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _message.isNotEmpty
                                ? Text(
                                    _message,
                                    style: TextStyle(color: Colors.red),
                                  )
                                : SizedBox.shrink(),
                            Container(
                              alignment: Alignment.center,
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
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0,
                                          ),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate('sign_up_btn'),
                                            style: TextStyle(
                                              fontSize: 56.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(40),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              LoadingModal(
                isVisible: _loginLoading,
                color: primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  tabLayout() {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              primaryColor,
            ],
            stops: [0.60, 0.90],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Image.asset(image.logo2, height: 90.h),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 130.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil().setHeight(35),
                        ),
                        Center(
                          child: _profileImage(),
                        ),
                        TextFormField(
                          style: inputStyle,
                          focusNode: _phoneFocus,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          enabled: false,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: -10.h),
                            hintStyle: TextStyle(
                              color: primaryColor,
                            ),
                            labelText: AppLocalizations.of(context)
                                .translate('login_id'),
                            prefixIcon: Icon(Icons.phone_android),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(context, _phoneFocus, _nameFocus);
                          },
                          initialValue: _phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .translate('phone_required_msg');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value != _phone) {
                              _phone = value;
                            }
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(70),
                        ),
                        TextFormField(
                          style: inputStyle,
                          focusNode: _nameFocus,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: -10.h),
                            hintStyle: TextStyle(
                              color: primaryColor,
                            ),
                            labelText: AppLocalizations.of(context)
                                .translate('ic_name_lbl'),
                            prefixIcon: Icon(Icons.account_circle),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                                context, _nameFocus, _nickNameFocus);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .translate('ic_name_required_msg');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value != _name) {
                              _name = value;
                            }
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(70),
                        ),
                        TextFormField(
                          style: inputStyle,
                          focusNode: _nickNameFocus,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: -10.h),
                            hintStyle: TextStyle(
                              color: primaryColor,
                            ),
                            labelText: AppLocalizations.of(context)
                                .translate('nick_name_lbl'),
                            prefixIcon: Icon(Icons.account_circle),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                                context, _nickNameFocus, _emailFocus);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .translate('nick_name_required_msg');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value != _nickName) {
                              _nickName = value;
                            }
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(70),
                        ),
                        TextFormField(
                          style: inputStyle,
                          focusNode: _emailFocus,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: -10.h),
                            hintStyle: TextStyle(
                              color: primaryColor,
                            ),
                            labelText: AppLocalizations.of(context)
                                .translate('email_lbl'),
                            prefixIcon: Icon(Icons.mail),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                                context, _emailFocus, _passwordFocus);
                          },
                          /* validator: (value) {
                            if (value.isEmpty) {
                              return 'Email is required.';
                            }
                          }, */
                          onChanged: (value) {
                            if (value != _email) {
                              _email = value;
                            }
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(70),
                        ),
                        TextFormField(
                          style: inputStyle,
                          focusNode: _passwordFocus,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: -10.h),
                            hintStyle: TextStyle(color: primaryColor),
                            labelText: AppLocalizations.of(context)
                                .translate('password_lbl'),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(
                                  () {
                                    _obscurePassword = !_obscurePassword;
                                  },
                                );
                              },
                            ),
                          ),
                          obscureText: _obscurePassword,
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                                context, _passwordFocus, _confirmPasswordFocus);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .translate('password_required_msg');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value != _password) {
                              _password = value;
                            }
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(70),
                        ),
                        TextFormField(
                          style: inputStyle,
                          focusNode: _confirmPasswordFocus,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: -10.h),
                            hintStyle: TextStyle(color: primaryColor),
                            labelText: AppLocalizations.of(context)
                                .translate('confirm_password'),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(
                                  () {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  },
                                );
                              },
                            ),
                          ),
                          obscureText: _obscureConfirmPassword,
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .translate('confirm_password_required');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value != _confirmPassword) {
                              _confirmPassword = value;
                            }
                          },
                        ),
                        SizedBox(height: 40.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _message.isNotEmpty
                                ? Text(
                                    _message,
                                    style: TextStyle(color: Colors.red),
                                  )
                                : SizedBox.shrink(),
                            Container(
                              alignment: Alignment.center,
                              child: _isLoading
                                  ? SpinKitFoldingCube(
                                      color: Colors.blue,
                                    )
                                  : ButtonTheme(
                                      shape: StadiumBorder(),
                                      child: RaisedButton(
                                        onPressed: _submit,
                                        color: Color(0xffdd0e0e),
                                        textColor: Colors.white,
                                        child: Container(
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate('sign_up_btn'),
                                            style: TextStyle(
                                              fontSize: 35.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(40),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              LoadingModal(
                isVisible: _loginLoading,
                color: primaryColor,
              ),
            ],
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

      if (_password == _confirmPassword) {
        var result = await authRepo.register(
          context: context,
          countryCode: widget.data.phoneCountryCode,
          phone: widget.data.phone,
          name: _name,
          nickName: _nickName,
          signUpPwd: _password,
          email: _email,
          userProfileImageBase64String: profilePic,
          latitude: _latitude,
          longitude: _longitude,
          deviceId: _deviceId,
          deviceBrand: _deviceBrand,
          deviceModel: _deviceModel,
          deviceVersion: '$_deviceOs $_deviceVersion',
        );

        if (result.isSuccess) {
          customDialog.show(
            context: context,
            title: Center(
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 120,
              ),
            ),
            content: result.message.toString(),
            barrierDismissable: false,
            customActions: <Widget>[
              _loginLoading == false
                  ? FlatButton(
                      child: Text(
                          AppLocalizations.of(context).translate('ok_btn')),
                      onPressed: _login,
                    )
                  : SpinKitFoldingCube(
                      color: primaryColor,
                    ),
            ],
            type: DialogType.GENERAL,
          );
        } else {
          customDialog.show(
            context: context,
            content: result.message.toString(),
            onPressed: () => Navigator.pop(context),
            type: DialogType.ERROR,
          );
        }

        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _message =
              AppLocalizations.of(context).translate('password_not_match_msg');
          _isLoading = false;
        });
      }
    }
  }

  _login() async {
    Navigator.pop(context);

    setState(() {
      _loginLoading = true;
    });

    var result = await authRepo.login(
      context: context,
      phone: _phone.substring(2),
      password: _password,
      latitude: _latitude,
      longitude: _longitude,
      deviceRemark: '$_deviceOs $_deviceVersion',
      phDeviceId: _deviceId,
    );

    if (result.isSuccess) {
      var getRegisteredDi =
          await authRepo.getUserRegisteredDI(context: context, type: 'LOGIN');

      if (getRegisteredDi.isSuccess) {
        localStorage.saveDiCode(getRegisteredDi.data[0].diCode);

        Navigator.pushNamedAndRemoveUntil(context, HOME, (r) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, LOGIN, (r) => false);
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(context, LOGIN, (r) => false);
    }

    setState(() {
      _loginLoading = false;
    });
  }
}
