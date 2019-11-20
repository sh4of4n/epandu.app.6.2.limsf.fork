import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
// import 'package:flutter/painting.dart';

class ColorConstant {
  static final primaryColor = Colors.amber.shade600;
  static const green = Colors.green;
  static const red = Colors.red;
  static const amberAccent = Colors.amberAccent;
}

class ImagesConstant {
  String logo = 'images/ePandu-logo.png';
  // String avatar = 'images/avatar.jpg';
  // String loginBackground = 'assets/images/login_background.jpg';
}

class Common {
  Future<String> getDeviceIdentifier(BuildContext context) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  static void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
