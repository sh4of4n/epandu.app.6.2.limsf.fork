import 'package:epandu/services/repo/auth_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class Login extends StatelessWidget {
  final authRepo = AuthRepo();

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'ePandu',
      logo: ImagesConstant().logo,
      onLogin: (data) => _authUser(context, data),
      onSignup: (data) => _registerUser(data),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacementNamed(HOME);
      },
      onRecoverPassword: (data) => _recoverPassword(data),
    );
  }

  _authUser(context, LoginData data) {
    var result = authRepo.login(context, data.name, data.password);
  }

  _registerUser(data) {
    // var result = authRepo.checkExistingUser(
    //   context,
    //   data.name,
    //   data.password
    // );
  }

  _recoverPassword(phone) {}
}
