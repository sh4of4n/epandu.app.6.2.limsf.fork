import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';

import 'change_password_form.dart';

@RoutePage(name: 'ChangePassword')
class ChangePassword extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;

  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.amber.shade50,
              Colors.amber.shade100,
              Colors.amber.shade200,
              Colors.amber.shade300,
              primaryColor
            ],
            stops: const [0.2, 0.4, 0.6, 0.7, 1],
            radius: 0.7,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(AppLocalizations.of(context)!
                .translate('change_password_title')),
          ),
          body: const SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16.0, top: 16.0),
                    child: Column(
                      children: <Widget>[
                        ChangePasswordForm(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
