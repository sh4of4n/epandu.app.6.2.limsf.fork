// import 'dart:convert';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
// import 'package:epandu/router.gr.dart';
import 'package:epandu/common_library/services/model/auth_model.dart';
import 'package:epandu/common_library/services/location.dart';
import 'package:epandu/common_library/utils/custom_button.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/common_library/utils/device_info.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
// import 'package:epandu/common_library/services/model/auth_model.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../common_library/services/model/createroom_response.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../services/database/database_helper.dart';
import '../../services/repository/chatroom_repository.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../chat/socketclient_helper.dart';

@RoutePage(name: 'RegisterUserToDi')
class RegisterUserToDi extends StatefulWidget {
  final barcode;

  const RegisterUserToDi(this.barcode, {super.key});

  @override
  State<RegisterUserToDi> createState() => _RegisterUserToDiState();
}

class _RegisterUserToDiState extends State<RegisterUserToDi> {
  late io.Socket socket;
  final chatRoomRepo = ChatRoomRepo();
  final authRepo = AuthRepo();
  final localStorage = LocalStorage();
  final customDialog = CustomDialog();
  final image = ImagesConstant();
  final primaryColor = ColorConstant.primaryColor;
  final _formKey = GlobalKey<FormState>();
  final location = Location();
  final dbHelper = DatabaseHelper.instance;

  String name = '';
  String merchantId = '';
  String merchantName = '';
  String phoneCountryCode = '';
  String phone = '';
  String appVersion = '';
  // String _bodyTemp = '';
  String _message = '';
  bool _isLoading = false;
  bool duplicateMerchant = false;

  String latitude = '';
  String longitude = '';

  DeviceInfo deviceInfo = DeviceInfo();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final merchantIdController = TextEditingController();
  final merchantNameController = TextEditingController();

  String? _deviceManufacturer = '';
  // String _deviceVersion = '';
  String? _deviceId = '';
  // String _deviceOs = '';
  String? _deviceModel = '';

  final diList = Hive.box('di_list');

  @override
  void initState() {
    super.initState();

    ScanResponse scanResponse =
        ScanResponse.fromJson(jsonDecode(widget.barcode));

    /* setState(() {
      name = scanResponse.qRCode[0].name;
      phone = scanResponse.qRCode[0].phone;
    }); */

    nameController.addListener(nameValue);
    phoneController.addListener(phoneValue);
    merchantIdController.addListener(merchantIdValue);
    merchantNameController.addListener(merchantNameValue);

    _getPackageInfo();
    _getDeviceInfo();
    _checkLocationPermission();

    if (scanResponse.qRCode?[0] != null) {
      setState(() {
        nameController.text = scanResponse.qRCode![0].name ?? '';
        phoneController.text = scanResponse.qRCode![0].loginId ?? '';
        merchantIdController.text =
            scanResponse.qRCode![0].merchantDbCode ?? '';
        merchantNameController.text = scanResponse.qRCode![0].merchantName!;
      });
    } else {
      _getData();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final getSocket = Provider.of<SocketClientHelper>(context, listen: false);
      socket = getSocket.socket;
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   socket = context.watch<SocketClientHelper>().socket;
  // }

  _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      appVersion = packageInfo.version;
    });
  }

  _getDeviceInfo() async {
    // get device info
    await deviceInfo.getDeviceInfo();

    // _deviceModel = deviceInfo.model;
    _deviceManufacturer = deviceInfo.manufacturer;
    // _deviceVersion = deviceInfo.version;
    _deviceId = deviceInfo.id;
    // _deviceOs = deviceInfo.os;
    _deviceModel = deviceInfo.model;

    // print('deviceId: ' + deviceId);
  }

  _checkLocationPermission() async {
    bool serviceLocationStatus = await Geolocator.isLocationServiceEnabled();
    LocationPermission geolocationStatus = await Geolocator.checkPermission();

    if (serviceLocationStatus &&
            geolocationStatus == LocationPermission.whileInUse ||
        geolocationStatus == LocationPermission.always) {
      await location.getCurrentLocation();

      setState(() {
        latitude = location.latitude.toString();
        longitude = location.longitude.toString();
      });
    }
  }

  nameValue() {
    setState(() {
      name = nameController.text;
    });
  }

  phoneValue() {
    setState(() {
      phone = phoneController.text;
    });
  }

  merchantIdValue() {
    setState(() {
      merchantId = merchantIdController.text;
    });
  }

  merchantNameValue() {
    setState(() {
      merchantName = merchantNameController.text;
    });
  }

  _getData() async {
    // String getPhoneCountryCode = await localStorage.getCountryCode();
    String? getPhone = await localStorage.getUserPhone();
    String? getName = await localStorage.getName();

    setState(() {
      // phoneCountryCode = getPhoneCountryCode;
      phoneController.text = getPhone!;
      // gender = getGender;
      nameController.text = getName!;
    });
  }

  registerUserToDi() async {
    for (var i = 0; i < diList.length; i++) {
      if (diList.getAt(i).merchantNo == merchantId) {
        duplicateMerchant = true;
        break;
      }
    }
    if (_formKey.currentState!.validate()) {
      if (duplicateMerchant) {
        localStorage.saveMerchantDbCode(merchantId);
        context.router.popUntil((route) => route.settings.name == 'Home');
      } else {
        _formKey.currentState!.save();
        FocusScope.of(context).requestFocus(FocusNode());

        setState(() {
          _isLoading = true;
          _message = '';
        });

        ScanResponse scanResponse =
            ScanResponse.fromJson(jsonDecode(widget.barcode));

        var result = await authRepo.registerUserToDI(
          context: context,
          // bodyTemperature: _bodyTemp,
          appVersion: appVersion,
          scannedAppId: scanResponse.qRCode![0].appId,
          scannedAppVer: scanResponse.qRCode![0].appVersion,
          scannedLoginId: scanResponse.qRCode![0].loginId,
          scannedUserId: scanResponse.qRCode![0].userId,
          scanCode: widget.barcode,
          phDeviceId: _deviceId,
          bdBrand: _deviceManufacturer,
          bdModel: Uri.encodeComponent(_deviceModel!),
          latitude: latitude,
          longitude: longitude,
        );

        if (result.isSuccess) {
          //save into hive
          if (!context.mounted) return;
          var diResult = await authRepo.getUserRegisteredDI2(
              context: context, merchantId: merchantId);
          if (diResult.isSuccess) {
            print(diResult.data.length);
          }

          var createChatSupportResult =
              await chatRoomRepo.createChatSupportByMember();
          if (createChatSupportResult.data != null &&
              createChatSupportResult.data.length > 0) {
            if (!context.mounted) return;
            await context.read<SocketClientHelper>().loginUserRoom();

            String userid = await localStorage.getUserId() ?? '';
            CreateRoomResponse getCreateRoomResponse =
                createChatSupportResult.data[0];

            List<RoomMembers> roomMembers = await dbHelper
                .getRoomMembersList(getCreateRoomResponse.roomId!);
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
          context.router.popUntil(ModalRoute.withName('Home'));

          /* customDialog.show(
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
            TextButton(
              child: Text(AppLocalizations.of(context).translate('ok_btn')),
              onPressed: () => Navigator.popUntil(
                context,
                ModalRoute.withName(HOME),
              ),
            )
          ],
          type: DialogType.GENERAL,
        ); */
        } else {
          if (!context.mounted) return;
          customDialog.show(
            context: context,
            content: result.message.toString(),
            onPressed: () => context.router.pop(),
            type: DialogType.error,
          );
        }

        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              primaryColor,
            ],
            stops: const [0.45, 0.85],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Image.asset(image.logo2, height: 90.h),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 130.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: -10.h),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                          labelText: AppLocalizations.of(context)!
                              .translate('date_time'),
                          prefixIcon: const Icon(Icons.phone_android),
                        ),
                        initialValue: DateFormat('yyyy-MM-dd:HH:mm')
                            .format(DateTime.now()),
                      ),
                      SizedBox(height: 50.h),
                      TextFormField(
                        controller: merchantIdController,
                        enabled: false,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: -10.h),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                          labelText: AppLocalizations.of(context)!
                              .translate('merchant_id'),
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      TextFormField(
                        controller: merchantNameController,
                        enabled: false,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: -10.h),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                          labelText: AppLocalizations.of(context)!
                              .translate('merchant_name'),
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      /* TextFormField(
                        controller: nameController,
                        enabled: false,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: -10.h),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('name_lbl'),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      TextFormField(
                        controller: phoneController,
                        enabled: false,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: -10.h),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('phone_lbl'),
                          prefixIcon: Icon(Icons.phone_android),
                        ),
                      ),
                      SizedBox(height: 50.h), */
                      /* TextFormField(
                        autofocus: true,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: -10.h),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('body_temp'),
                          labelStyle: TextStyle(
                            color: Colors.grey[850],
                            fontWeight: FontWeight.bold,
                          ),
                          prefixIcon: Icon(Icons.people),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context)
                                .translate('body_temp_required_msg');
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _bodyTemp = value;
                          });
                        },
                      ), */
                    ],
                  ),
                  _message.isNotEmpty
                      ? Text(
                          _message,
                          style: const TextStyle(color: Colors.red),
                        )
                      : const SizedBox.shrink(),
                  _isLoading
                      ? SpinKitFoldingCube(
                          color: primaryColor,
                        )
                      : CustomButton(
                          onPressed: registerUserToDi,
                          buttonColor: const Color(0xffdd0e0e),
                          title: AppLocalizations.of(context)!
                              .translate('submit_btn'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
