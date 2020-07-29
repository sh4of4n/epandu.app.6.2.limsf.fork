import 'package:auto_route/auto_route.dart';
import 'package:epandu/router.gr.dart';
import 'package:flutter/material.dart';

class CheckEnrollment extends StatefulWidget {
  @override
  _CheckEnrollmentState createState() => _CheckEnrollmentState();
}

class _CheckEnrollmentState extends State<CheckEnrollment> {
  @override
  void initState() {
    super.initState();

    ExtendedNavigator.of(context).replace(Routes.selectInstitute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
