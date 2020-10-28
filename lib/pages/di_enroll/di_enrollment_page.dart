import 'package:epandu/app_localizations.dart';
import 'package:flutter/material.dart';

class DiEnrollment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('enroll_lbl'),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
