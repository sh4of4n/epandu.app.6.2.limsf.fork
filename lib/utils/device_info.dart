import 'package:device_info/device_info.dart';
import 'dart:io' show Platform;

class DeviceInfo {
  String model;
  String version;
  String id;
  String os;
  String manufacturer;

  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}');
      print('Version ${androidInfo.version.release}');
      print('Base OS ${androidInfo.version.baseOS}');
      print('Manufacturer ${androidInfo.manufacturer}');

      model = androidInfo.model;
      version = androidInfo.version.release;
      id = androidInfo.androidId;
      os = 'Android';
      manufacturer = androidInfo.manufacturer;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.model}');
      print('Version ${iosInfo.systemVersion}');
      print('OS ${iosInfo.systemName}');

      model = iosInfo.model;
      version = iosInfo.systemVersion;
      id = iosInfo.identifierForVendor;
      os = iosInfo.systemName;
      manufacturer = 'Apple';
    }
  }
}
