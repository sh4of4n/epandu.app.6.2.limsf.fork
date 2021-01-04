import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/model/provider_model.dart';
import 'app_localizations.dart';
import 'application.dart';
import 'local_storage.dart';

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
              Provider.of<LanguageModel>(context, listen: false)
                  .selectedLanguage(
                      AppLocalizations.of(context).translate('english_lbl'));
              ExtendedNavigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate('malay_lbl')),
            onTap: () {
              localStorage.saveLocale('ms');
              application.onLocaleChanged(Locale('ms'));
              Provider.of<LanguageModel>(context, listen: false)
                  .selectedLanguage(
                      AppLocalizations.of(context).translate('malay_lbl'));
              ExtendedNavigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
