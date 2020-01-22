import 'package:epandu/app_localizations.dart';
import 'package:flutter/material.dart';

class BillDetail extends StatelessWidget {
  final data;

  BillDetail(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(AppLocalizations.of(context).translate('bill_lbl'))),
        body: Column(
          children: <Widget>[],
        ));
  }
}
