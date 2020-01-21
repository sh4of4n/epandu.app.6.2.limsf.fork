import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';

class BillSelection extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.amber.shade300, primaryColor],
          stops: [0.5, 1],
          radius: 0.9,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Bill'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(),
      ),
    );
  }
}
