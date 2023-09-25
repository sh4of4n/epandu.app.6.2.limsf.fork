import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info/package_info.dart';
import 'package:qr_flutter/qr_flutter.dart';

@RoutePage(name: 'IdentityBarcode')
class IdentityBarcode extends StatefulWidget {
  const IdentityBarcode({super.key});

  @override
  _IdentityBarcodeState createState() => _IdentityBarcodeState();
}

class _IdentityBarcodeState extends State<IdentityBarcode> {
  final image = ImagesConstant();
  final localStorage = LocalStorage();
  final appConfig = AppConfig();

  String id = '';
  String appVersion = '';
  String? diCode = '';
  // String icNo = '';
  String? userId = '';
  String? phoneCountryCode = '';
  String? phone = '';
  String loginId = '';
  // String dob = '';
  // String gender = '';
  String? name = '';
  String nationality = 'WARGANEGARA';

  @override
  void initState() {
    super.initState();

    _getData();
  }

  _getData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appId = appConfig.appId;
    String? getDiCode = await localStorage.getMerchantDbCode();
    String? getIcNo = await localStorage.getStudentIc();
    String? getUserId = await localStorage.getUserId();
    String? getPhoneCountryCode = await localStorage.getCountryCode();
    String? getPhone = await localStorage.getUserPhone();
    // String getGender = await localStorage.getGender();
    String? getName = await localStorage.getName();

    setState(() {
      id = appId + packageInfo.version + getIcNo! + getUserId!;
      diCode = getDiCode;
      appVersion = packageInfo.version;
      // icNo = getIcNo;
      userId = getUserId;
      phoneCountryCode = getPhoneCountryCode;
      phone = getPhone;
      loginId = (phoneCountryCode! + phone!).replaceAll('+6', '');
      // gender = getGender;
      name = getName;
    });
  }

  _loadQr() {
    if (id.isNotEmpty) {
      return QrImageView(
        embeddedImage: AssetImage(image.ePanduIcon),
        embeddedImageStyle: const QrEmbeddedImageStyle(
          size: Size(40, 40),
        ),
        data:
            '{"QRCode":[{"appId": "${appConfig.appId}", "appVersion": "$appVersion", "loginId": "$loginId", "name": "$name", "userId": "$userId"}]}',
        version: QrVersions.auto,
        size: 250.0,
      );
    }
    return const Center(
      child: SpinKitFoldingCube(
        color: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdc013),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.translate('id_lbl')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              horizontal: 100.w,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 100.h,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: _loadQr(),
          ),
        ],
      ),
    );
  }
}
