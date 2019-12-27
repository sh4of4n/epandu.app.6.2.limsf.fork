import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/api/model/language_model.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application.dart';

class LanguageOptions extends StatelessWidget {
  final localStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          ListTile(
            title: Text(AppLocalizations.of(context).translate('english_lbl')),
            onTap: () {
              localStorage.saveLocale('en');
              application.onLocaleChanged(Locale('en'));
              Provider.of<LanguageModel>(context).selectedLanguage(
                  AppLocalizations.of(context).translate('english_lbl'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate('malay_lbl')),
            onTap: () {
              localStorage.saveLocale('ms');
              application.onLocaleChanged(Locale('ms'));
              Provider.of<LanguageModel>(context).selectedLanguage(
                  AppLocalizations.of(context).translate('malay_lbl'));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
