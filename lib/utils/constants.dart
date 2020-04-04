import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:device_info/device_info.dart';
// import 'package:flutter/painting.dart';

class ColorConstant {
  static final primaryColor = Color(0xffffcd0e);
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
    display4: TextStyle(fontSize: 98, color: Color(0xff808080)),
    display3: TextStyle(fontSize: 61, color: Color(0xff808080)),
    display2: TextStyle(fontSize: 49, color: Color(0xff808080)),
    display1: TextStyle(fontSize: 35, color: Color(0xff808080)),
    headline: TextStyle(fontSize: 24, color: Color(0xff808080)),
    title: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xff808080)),
    subhead: TextStyle(fontSize: 16, color: Color(0xff808080)),
    body2: TextStyle(fontSize: 17, color: Color(0xff808080)),
    body1: TextStyle(fontSize: 15, color: Color(0xff808080)),
    caption: TextStyle(fontSize: 13, color: Color(0xff808080)),
    button: TextStyle(fontSize: 15, color: Color(0xff808080)),
    subtitle: TextStyle(fontSize: 14, color: Color(0xff808080)),
    overline: TextStyle(fontSize: 11, color: Color(0xff808080)),
  );

  /* TextStyle appBarTextStyle = TextStyle(
    fontSize: ScreenUtil().setSp(70),
    fontWeight: FontWeight.w600,
  ); */
}

class ImagesConstant {
  String logo = 'assets/images/ePandu-logo.png';
  String logo2 = 'assets/images/ePandu-logo-2.png';
  String feedSample = 'assets/images/feed-sample.jpg';
  String friend = 'assets/images/friend.png';
  String car = 'assets/images/car.png';
  String motor = 'assets/images/motor.png';
  String sos = 'assets/images/sos-icon.png';
  String menu = 'assets/images/menu-icon.png';
  String tyreShop = 'assets/images/tyre-shop-image.png';
  String jobIcon = 'assets/images/job.png';
  String enrollIcon = 'assets/images/enroll.png';
  String importantInfoIcon = 'assets/images/important-info.png';
  String kppIcon = 'assets/images/kpp01.png';
  String bookingIcon = 'assets/images/booking.png';
  String faqIcon = 'assets/images/faq.png';
  String classIcon = 'assets/images/classes.png';
  String paymentIcon = 'assets/images/payment.png';
  String attendanceIcon = 'assets/images/attendance.png';
  String visaImage = 'assets/images/visa.png';
  String banksImage = 'assets/images/banks.png';

  // emergency
  String ambulanceIcon = 'assets/images/ambulance.png';
  String policeIcon = 'assets/images/police.png';
  String bombaIcon = 'assets/images/bomba.png';
  String workshopIcon = 'assets/images/workshop.png';
  String emergencyImage = 'assets/images/emergency-image.jpg';
  // String avatar = 'images/avatar.jpg';
  // String loginBackground = 'assets/images/login_background.jpg';

  // value club
  String vClub = 'assets/images/v-club-icon.png';
  String vClubLogo = 'assets/images/v-club-logo.png';
  // String vClubBanner = 'assets/images/value-club-banner.png';
  String vClubBanner = 'assets/images/value-club-banner.jpeg';
  String airtime = 'assets/images/airtime.png';
  String billPayment = 'assets/images/bill-payment.png';
  String drivingSchools = 'assets/images/driving-schools.png';
  String higherEducation = 'assets/images/higher-education.png';
  String hochiak = 'assets/images/hochiak.png';
  String jobs = 'assets/images/jobs.png';
  String rideSharing = 'assets/images/ride-sharing.png';
  String tourism = 'assets/images/tourism.png';
  String workshops = 'assets/images/workshops.png';
  String promotionsIcon = 'assets/images/promotions.png';
  String selectInstituteBanner = 'assets/images/select-institute-banner.png';
  String locationIcon = 'assets/images/location-icon.png';
  String profileIcon = 'assets/images/profile-icon.png';
  String productsIcon = 'assets/images/products-icon.png';
  String reviewIcon = 'assets/images/review-icon.png';
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
