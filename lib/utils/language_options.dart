import 'package:epandu/app_localizations.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';

import '../application.dart';

class LanguageOptions extends StatelessWidget {
  final localStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          ListTile(
              title:
                  Text(AppLocalizations.of(context).translate('english_lbl')),
              onTap: () {
                localStorage.saveLocale('en');
                application.onLocaleChanged(Locale('en'));
                Navigator.pop(context);
              }),
          ListTile(
            title: Text(AppLocalizations.of(context).translate('malay_lbl')),
            onTap: () {
              localStorage.saveLocale('ms');
              application.onLocaleChanged(Locale('ms'));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
