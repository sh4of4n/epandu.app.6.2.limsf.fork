import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:device_info/device_info.dart';
// import 'package:flutter/painting.dart';

class ColorConstant {
  static final primaryColor = Colors.amber.shade600;
  static const green = Colors.green;
  static const red = Colors.red;
  static const amberAccent = Colors.amberAccent;
}

final ColorScheme colorScheme = ColorScheme.light(
  primary: Color(0xFF501049),
  secondary: Color(0xFFE30425),
  primaryVariant: Color(0xFF5D1049),
  secondaryVariant: Color(0xFFE30425),
  surface: Color(0xFFFFFFFF),
  background: Color(0xFFF4E2ED),
  error: Color(0xFFB00020),
  onPrimary: Color(0xFFFFFFFF),
  onSecondary: Color(0xFFFFFFFF),
  onSurface: Color(0xFF000000),
  onError: Color(0xFFFD9726),
  onBackground: Color(0xFF000000),
  brightness: Brightness.light,
);

class FontTheme {
  TextTheme primaryFont = TextTheme(
    display4: GoogleFonts.dosis(fontSize: 98),
    display3: GoogleFonts.dosis(fontSize: 61),
    display2: GoogleFonts.dosis(fontSize: 49),
    display1: GoogleFonts.dosis(fontSize: 35),
    headline: GoogleFonts.dosis(fontSize: 24),
    title: GoogleFonts.dosis(
        fontSize: 20, textStyle: TextStyle(fontWeight: FontWeight.w600)),
    subhead: GoogleFonts.dosis(fontSize: 16),
    body2: GoogleFonts.dosis(fontSize: 17),
    body1: GoogleFonts.dosis(fontSize: 15),
    caption: GoogleFonts.dosis(fontSize: 13),
    button: GoogleFonts.dosis(fontSize: 15),
    subtitle: GoogleFonts.dosis(fontSize: 14),
    overline: GoogleFonts.dosis(fontSize: 11),
  );

  /* TextStyle appBarTextStyle = TextStyle(
    fontSize: ScreenUtil().setSp(70),
    fontWeight: FontWeight.w600,
  ); */
}

class ImagesConstant {
  String logo = 'images/ePandu-logo.png';
  String iconAbout = 'images/icon-about.png';
  String iconCampus = 'images/icon-campus.png';
  String iconEmergency = 'images/icon-emergency.png';
  String iconProfile = 'images/icon-profile.png';
  String iconProgramme = 'images/icon-programme.png';
  String feedSample = 'images/feed-sample.jpg';
  String feedSample2 = 'images/feed-sample.png';
  String friend = 'images/friend.png';
  String car = 'images/car.png';
  String motor = 'images/motor.png';
  // String avatar = 'images/avatar.jpg';
  // String loginBackground = 'assets/images/login_background.jpg';
}

/* class Common {
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
} */
