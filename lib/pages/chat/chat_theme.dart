import 'package:flutter/material.dart';

class MyTheme {
  MyTheme._();
  static Color kPrimaryColor = const Color(0xff7C7B9B);
  static Color kPrimaryColorVariant = const Color(0xff686795);
  static Color kAccentColor = const Color(0xffFCAAAB);
  static Color kAccentColorVariant = const Color(0xffF7A3A2);
  static Color kUnreadChatBG = const Color(0xffEE1D1D);

  static const TextStyle heading2 = TextStyle(
    color: Color(0xff686795),
    fontSize: 18,
    fontWeight: FontWeight.w200,
    letterSpacing: 1.5,
  );

  static const TextStyle chatSenderName = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );

  static final TextStyle bodyText1 = TextStyle(
      color: Colors.blueGrey[800],
      fontSize: 14,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w500);

  static const TextStyle bodyTextMessage =
      TextStyle(fontSize: 13, letterSpacing: 1.5, fontWeight: FontWeight.w600);

  static const TextStyle bodyTextTime = TextStyle(
    color: Color(0xff7E7B99),
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );
  static const TextStyle isMebodyTextTime = TextStyle(
    color: Color(0xff686795),
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );
}
