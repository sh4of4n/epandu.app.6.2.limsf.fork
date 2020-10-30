import 'package:epandu/app_localizations.dart';
import 'package:flutter/material.dart';

class EnrollEnquiry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('enroll_lbl')),
      ),
      body: Container(),
    );
  }
}
