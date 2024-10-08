import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:epandu/common_library/services/model/auth_model.dart';
import 'package:epandu/common_library/services/model/createroom_response.dart';
import 'package:epandu/common_library/services/model/m_roommember_model.dart';
import 'package:epandu/common_library/services/response.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/common_library/services/location.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/services/database/database_helper.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/common_library/utils/device_info.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:epandu/common_library/utils/uppercase_formatter.dart';
import 'package:epandu/common_library/utils/loading_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../router.gr.dart';
import '../../services/repository/chatroom_repository.dart';
import '../chat/socketclient_helper.dart';

enum AppState { free, picked, cropped }

@RoutePage(name: 'RegisterForm')
class RegisterForm extends StatefulWidget {
  final data;

  const RegisterForm(this.data, {super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> with PageBaseClass {
  late io.Socket socket;
  final authRepo = AuthRepo();
  final chatRoomRepo = ChatRoomRepo();
  final customDialog = CustomDialog();

  final _formKey = GlobalKey<FormState>();

  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _icFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _nickNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _postcodeFocus = FocusNode();
  final dbHelper = DatabaseHelper.instance;

  final primaryColor = ColorConstant.primaryColor;

  final localStorage = LocalStorage();
  Location location = Location();

  bool _isLoading = false;
  bool _loginLoading = false;
  final image = ImagesConstant();

  String? _phone = '';
  String _icNo = '';
  String _name = '';
  String _nickName = '';
  String _email = '';
  String _postcode = '';
  String _password = '';
  String _confirmPassword = '';
  String _message = '';
  final String _latitude = '';
  final String _longitude = '';

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  DeviceInfo deviceInfo = DeviceInfo();
  String? _deviceBrand = '';
  String? _deviceModel = '';
  String? _deviceVersion = '';
  String? _deviceId = '';
  String? _deviceOs = '';

  List<CameraDescription>? cameras;
  final picker = ImagePicker();
  String profilePic = '';
  late File _image;
  late File _croppedImage;
  var imageState;
  List<LdlEnqGroupList> ldlList = [];
  List<CdlList> cdlList = [];

  String? ldlItem = '';
  String? cdlItem = '';

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
    _getLdlkEnqGroupList();
    _getCdlList();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final getSocket = Provider.of<SocketClientHelper>(context, listen: false);
      socket = getSocket.socket;
    });
  }

  Future<void> _getLdlkEnqGroupList() async {
    Response<List<LdlEnqGroupList>> result =
        await authRepo.getLdlkEnqGroupList();

    if (result.isSuccess) {
      setState(() {
        ldlList = result.data ?? [];
      });
    }
  }

  Future<void> _getCdlList() async {
    Response<List<CdlList>?> result = await authRepo.getCdlList();

    if (result.isSuccess) {
      setState(() {
        cdlList = result.data ?? [];
      });
    }
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
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.blue,
                width: 1.5,
              ),
            ),
            onPressed: _profilePicOption,
            child: Text(AppLocalizations.of(context)!.translate('edit')),
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
          child: Text(AppLocalizations.of(context)!.translate('take_photo')),
          onPressed: () async {
            context.router.pop();
            var newProfilePic = await context.router.push(
              TakeProfilePicture(camera: cameras),
            );

            if (newProfilePic != null) {
              setState(() {
                profilePic = '';
                _image = File(newProfilePic as String);
                _editImage();
                // profilePicBase64 =
                //     base64Encode(File(newProfilePic).readAsBytesSync());
              });
            }
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
      type: DialogType.simpleDialog,
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
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      maxWidth: 512,
      maxHeight: 512,
    );

    if (croppedFile != null) {
      setState(() {
        _croppedImage = File(croppedFile.path);
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
            stops: const [0.60, 0.90],
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
                            labelText: AppLocalizations.of(context)!
                                .translate('login_id'),
                            labelStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                            prefixIcon: const Icon(Icons.phone_android),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(context, _phoneFocus, _nameFocus);
                          },
                          initialValue: _phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
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
                          focusNode: _icFocus,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0),
                            hintStyle: TextStyle(
                              color: primaryColor,
                            ),
                            labelStyle: const TextStyle(
                              color: Color(0xff808080),
                            ),
                            labelText: AppLocalizations.of(context)!
                                .translate('ic_lbl'),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(Icons.featured_video),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                              context,
                              _icFocus,
                              _nameFocus,
                            );
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .translate('ic_required_msg');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _icNo = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(70),
                        ),
                        TextFormField(
                          focusNode: _nameFocus,
                          inputFormatters: [UpperCaseTextFormatter()],
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: -10.h),
                            hintStyle: TextStyle(
                              color: primaryColor,
                            ),
                            labelText: AppLocalizations.of(context)!
                                .translate('ic_name_lbl'),
                            labelStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                            prefixIcon: const Icon(Icons.account_circle),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                                context, _nameFocus, _nickNameFocus);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
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
                            labelText: AppLocalizations.of(context)!
                                .translate('nick_name_lbl'),
                            labelStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                            prefixIcon: const Icon(Icons.account_circle),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                                context, _nickNameFocus, _emailFocus);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
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
                            labelText: AppLocalizations.of(context)!
                                .translate('email_lbl'),
                            labelStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                            prefixIcon: const Icon(Icons.mail),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                                context, _emailFocus, _postcodeFocus);
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
                          focusNode: _postcodeFocus,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0),
                            hintStyle: TextStyle(
                              color: primaryColor,
                            ),
                            labelStyle: const TextStyle(
                              color: Color(0xff808080),
                            ),
                            labelText: AppLocalizations.of(context)!
                                .translate('postcode_lbl'),
                            prefixIcon: const Icon(Icons.home),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                              context,
                              _postcodeFocus,
                              _passwordFocus,
                            );
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .translate('postcode_required_msg');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _postcode = value;
                            });
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
                                AppLocalizations.of(context)!.translate('ldl'),
                            prefixIcon: const Icon(Icons.badge),
                          ),
                          disabledHint: Text(
                              AppLocalizations.of(context)!.translate('ldl')),
                          onChanged: (value) {
                            setState(() {
                              ldlItem = value;
                            });
                          },
                          items: ldlList
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
                            labelText:
                                AppLocalizations.of(context)!.translate('cdl'),
                            prefixIcon: const Icon(Icons.badge),
                          ),
                          disabledHint: Text(
                              AppLocalizations.of(context)!.translate('cdl')),
                          onChanged: (value) {
                            setState(() {
                              cdlItem = value;
                            });
                          },
                          items: cdlList
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
                            labelText: AppLocalizations.of(context)!
                                .translate('password_lbl'),
                            labelStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                            prefixIcon: const Icon(Icons.lock),
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
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
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
                            labelText: AppLocalizations.of(context)!
                                .translate('confirm_password'),
                            labelStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                            prefixIcon: const Icon(Icons.lock),
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
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
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
                                    style: const TextStyle(color: Colors.red),
                                  )
                                : const SizedBox.shrink(),
                            Container(
                              alignment: Alignment.center,
                              child: _isLoading
                                  ? const SpinKitFoldingCube(
                                      color: Colors.blue,
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xffdd0e0e),
                                        textStyle: const TextStyle(
                                            color: Colors.white),
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.all(0.0),
                                      ),
                                      onPressed: _submit,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .translate('sign_up_btn'),
                                          style: TextStyle(
                                            fontSize: 56.sp,
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
              LoadingModel(
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
            stops: const [0.60, 0.90],
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
                            labelText: AppLocalizations.of(context)!
                                .translate('login_id'),
                            prefixIcon: const Icon(Icons.phone_android),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(context, _phoneFocus, _nameFocus);
                          },
                          initialValue: _phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
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
                        SizedBox(
                          height: ScreenUtil().setHeight(70),
                        ),
                        TextFormField(
                          focusNode: _icFocus,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: -10.0),
                            hintStyle: TextStyle(
                              color: primaryColor,
                            ),
                            labelStyle: const TextStyle(
                              color: Color(0xff808080),
                            ),
                            labelText: AppLocalizations.of(context)!
                                .translate('ic_lbl'),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(Icons.featured_video),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                              context,
                              _icFocus,
                              _nameFocus,
                            );
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .translate('ic_required_msg');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _icNo = value;
                            });
                          },
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
                            labelText: AppLocalizations.of(context)!
                                .translate('ic_name_lbl'),
                            prefixIcon: const Icon(Icons.account_circle),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                                context, _nameFocus, _nickNameFocus);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
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
                            labelText: AppLocalizations.of(context)!
                                .translate('nick_name_lbl'),
                            prefixIcon: const Icon(Icons.account_circle),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                                context, _nickNameFocus, _emailFocus);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
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
                            labelText: AppLocalizations.of(context)!
                                .translate('email_lbl'),
                            prefixIcon: const Icon(Icons.mail),
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
                          focusNode: _postcodeFocus,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0),
                            hintStyle: TextStyle(
                              color: primaryColor,
                            ),
                            labelStyle: const TextStyle(
                              color: Color(0xff808080),
                            ),
                            labelText: AppLocalizations.of(context)!
                                .translate('postcode_lbl'),
                            prefixIcon: const Icon(Icons.home),
                          ),
                          onFieldSubmitted: (term) {
                            fieldFocusChange(
                              context,
                              _postcodeFocus,
                              _passwordFocus,
                            );
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .translate('postcode_required_msg');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _postcode = value;
                            });
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
                                AppLocalizations.of(context)!.translate('ldl'),
                            prefixIcon: const Icon(Icons.badge),
                          ),
                          disabledHint: Text(
                              AppLocalizations.of(context)!.translate('ldl')),
                          onChanged: (value) {
                            setState(() {
                              ldlItem = value;
                            });
                          },
                          items: ldlList
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
                            labelText:
                                AppLocalizations.of(context)!.translate('cdl'),
                            prefixIcon: const Icon(Icons.badge),
                          ),
                          disabledHint: Text(
                              AppLocalizations.of(context)!.translate('cdl')),
                          onChanged: (value) {
                            setState(() {
                              cdlItem = value;
                            });
                          },
                          items: cdlList
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
                            labelText: AppLocalizations.of(context)!
                                .translate('password_lbl'),
                            prefixIcon: const Icon(Icons.lock),
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
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
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
                            labelText: AppLocalizations.of(context)!
                                .translate('confirm_password'),
                            prefixIcon: const Icon(Icons.lock),
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
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
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
                                    style: const TextStyle(color: Colors.red),
                                  )
                                : const SizedBox.shrink(),
                            Container(
                              alignment: Alignment.center,
                              child: _isLoading
                                  ? const SpinKitFoldingCube(
                                      color: Colors.blue,
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(420.w, 45.h),
                                        backgroundColor:
                                            const Color(0xffdd0e0e),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 11.0),
                                        shape: const StadiumBorder(),
                                        textStyle: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      onPressed: _submit,
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .translate('sign_up_btn'),
                                        style: TextStyle(
                                          fontSize: 35.sp,
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
              LoadingModel(
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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).requestFocus(FocusNode());

      setState(() {
        _isLoading = true;
        _message = '';
      });

      if (_password == _confirmPassword) {
        var result = await authRepo.register(
          context: context,
          countryCode: widget.data.phoneCountryCode,
          phone: widget.data.phone,
          icNo: _icNo.replaceAll('-', ''),
          name: _name,
          nickName: _nickName,
          signUpPwd: _password,
          email: _email,
          postcode: _postcode,
          userProfileImageBase64String: profilePic,
          latitude: _latitude,
          longitude: _longitude,
          deviceId: _deviceId,
          deviceBrand: _deviceBrand,
          deviceModel: Uri.encodeComponent(_deviceModel!),
          deviceVersion: '$_deviceOs $_deviceVersion',
          enqLdlGroup: ldlItem,
          cdlGroup: cdlItem,
          findDrvJobs: false,
        );

        if (result.isSuccess) {
          if (!context.mounted) return;
          customDialog.show(
            context: context,
            title: const Center(
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
                  ? TextButton(
                      onPressed: _login,
                      child: Text(
                          AppLocalizations.of(context)!.translate('ok_btn')),
                    )
                  : SpinKitFoldingCube(
                      color: primaryColor,
                    ),
            ],
            type: DialogType.general,
          );
        } else {
          if (!context.mounted) return;
          customDialog.show(
            context: context,
            content: result.message.toString(),
            onPressed: () => Navigator.pop(context),
            type: DialogType.error,
          );
        }

        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _message =
              AppLocalizations.of(context)!.translate('password_not_match_msg');
          _isLoading = false;
        });
      }
    }
  }

  _login() async {
    context.router.pop();

    setState(() {
      _loginLoading = true;
    });

    var result = await authRepo.login(
      context: context,
      phone: _phone!.substring(2),
      password: _password,
      latitude: _latitude,
      longitude: _longitude,
      deviceRemark: '$_deviceOs $_deviceVersion',
      phDeviceId: _deviceId,
    );

    if (result.isSuccess) {
      if (!context.mounted) return;
      var getRegisteredDi =
          await authRepo.getUserRegisteredDI(context: context, type: 'LOGIN');

      if (getRegisteredDi.isSuccess) {
        localStorage.saveMerchantDbCode(getRegisteredDi.data[0].merchantNo);
        if (!context.mounted) return;
        _createChatSupport(context);
      } else {
        if (!context.mounted) return;
        context.router.pushAndPopUntil(const Login(), predicate: (r) => false);
      }
    } else {
      if (!context.mounted) return;
      context.router.pushAndPopUntil(const Login(), predicate: (r) => false);
    }

    setState(() {
      _loginLoading = false;
    });
  }

  _createChatSupport(BuildContext context) async {
    var createChatSupportResult =
        await chatRoomRepo.createChatSupportByMember(merchantNo: 'EPANDU');

    if (createChatSupportResult.data != null &&
        createChatSupportResult.data.length > 0) {
      if (!context.mounted) return;
      await context.read<SocketClientHelper>().loginUserRoom();

      String userid = await localStorage.getUserId() ?? '';
      CreateRoomResponse getCreateRoomResponse =
          createChatSupportResult.data[0];

      List<RoomMembers> roomMembers =
          await dbHelper.getRoomMembersList(getCreateRoomResponse.roomId!);
      for (var roomMember in roomMembers) {
        if (userid != roomMember.userId) {
          var inviteUserToRoomJson = {
            "invitedRoomId": getCreateRoomResponse.roomId!,
            "invitedUserId": roomMember.userId
          };
          socket.emitWithAck('inviteUserToRoom', inviteUserToRoomJson,
              ack: (data) {
            //print('ack $data');
            if (data != null) {
              print('inviteUserToRoomJson from server $data');
            } else {
              print("Null from inviteUserToRoomJson");
            }
          });
        }
      }
    }

    if (!context.mounted) return;
    context.router.pushAndPopUntil(const Home(), predicate: (r) => false);
    // if (!context.mounted) return;
    // context.router.popUntil(ModalRoute.withName('Home'));
  }
}
