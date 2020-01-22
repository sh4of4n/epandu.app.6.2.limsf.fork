import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class BillTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('bill_lbl'))),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
