import 'package:device_info/device_info.dart';
import 'dart:io' show Platform;

class DeviceInfo {
  String model;
  String version;
  String id;
  String os;

  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      model = androidInfo.model;
      version = androidInfo.version.release;
      id = androidInfo.androidId;
      os = 'Android';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.model}');
      print('Version ${iosInfo.systemVersion}');
      print('OS ${iosInfo.systemName}');

      model = iosInfo.model;
      version = iosInfo.systemVersion;
      id = iosInfo.identifierForVendor;
      os = iosInfo.systemName;
    }
  }
}
