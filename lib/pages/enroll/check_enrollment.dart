import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';

class CheckEnrollment extends StatefulWidget {
  @override
  _CheckEnrollmentState createState() => _CheckEnrollmentState();
}

class _CheckEnrollmentState extends State<CheckEnrollment> {
  @override
  void initState() {
    super.initState();

    Navigator.pushReplacementNamed(context, SELECT_INSTITUTE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
