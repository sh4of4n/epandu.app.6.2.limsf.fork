import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';

class SelectDrivingInstitute extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Colors.amber.shade50,
            Colors.amber.shade100,
            Colors.amber.shade200,
            Colors.amber.shade300,
            primaryColor
          ],
          stops: [0.2, 0.4, 0.6, 0.7, 1],
          radius: 0.7,
        ),
      ),
      child: Scaffold(
        body: Container(),
      ),
    );
  }
}
