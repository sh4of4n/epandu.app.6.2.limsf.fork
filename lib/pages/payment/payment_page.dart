import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      body: Text('Payment page'),
    );
  }
}
