import 'package:epandu/app_localizations.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qr_flutter/qr_flutter.dart';

class IdentityBarcode extends StatefulWidget {
  @override
  _IdentityBarcodeState createState() => _IdentityBarcodeState();
}

class _IdentityBarcodeState extends State<IdentityBarcode> {
  final image = ImagesConstant();
  final localStorage = LocalStorage();

  String id = '';
  String diCode = '';
  // String icNo = '';
  String userId = '';
  String phoneCountryCode = '';
  String phone = '';
  // String dob = '';
  // String gender = '';
  String name = '';
  String nationality = 'WARGANEGARA';

  @override
  void initState() {
    super.initState();

    _getData();
  }

  _getData() async {
    String appId = 'ePandu.App';
    String appVersion = await localStorage.getAppVersion();
    String getDiCode = await localStorage.getDiCode();
    String getIcNo = await localStorage.getStudentIc();
    String getUserId = await localStorage.getUserId();
    String getPhoneCountryCode = await localStorage.getCountryCode();
    String getPhone = await localStorage.getUserPhone();
    // String getGender = await localStorage.getGender();
    String getName = await localStorage.getUsername();

    setState(() {
      id = appId + appVersion + getIcNo + getUserId;
      diCode = getDiCode;
      // icNo = getIcNo;
      userId = getUserId;
      phoneCountryCode = getPhoneCountryCode;
      phone = getPhone;
      // gender = getGender;
      name = getName;
    });
  }

  _loadQr() {
    if (id.isNotEmpty)
      return QrImage(
        embeddedImage: AssetImage(image.ePanduIcon),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(40, 40),
        ),
        data:
            '{"diCode": "$diCode", "name": "$name", "nationality": "$nationality", "phoneCountryCode": "$phoneCountryCode", "phone": "$phone", "userId": "$userId"}',
        version: QrVersions.auto,
        size: 250.0,
      );
    return Center(
      child: SpinKitFoldingCube(
        color: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffdc013),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(AppLocalizations.of(context).translate('id_lbl')),
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
