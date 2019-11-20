import 'package:flutter/material.dart';

mixin PageBaseClass {
  static const kGoogleApiKey = "AIzaSyAExqH_dAo1eu8wSm0LXsoySDEjkNRFoKU";

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
