import 'package:epandu/app_localizations.dart';
import 'package:flutter/material.dart';

class Promotions extends StatelessWidget {
  final feed;

  Promotions({this.feed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('promotions_lbl'),
        ),
      ),
      body: Container(),
    );
  }
}
