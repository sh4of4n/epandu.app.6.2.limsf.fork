import 'package:epandu/pages/forgot_password/forgot_password.dart';
import 'package:epandu/pages/invite/invite.dart';
import 'package:epandu/pages/kpp/kpp_category.dart';
import 'package:epandu/pages/kpp/kpp_module.dart';
import 'package:epandu/pages/kpp/kpp_exam.dart';
import 'package:epandu/pages/kpp/kpp_result.dart';
import 'package:epandu/pages/login/login.dart';
import 'package:epandu/pages/profile/profile.dart';
import 'package:epandu/pages/register/register.dart';
import 'package:epandu/pages/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:epandu/pages/home/home.dart';
import 'package:epandu/utils/route_path.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var data = settings.arguments;

    switch (settings.name) {
      case AUTH:
        return MaterialPageRoute(
          settings: RouteSettings(name: AUTH),
          builder: (_) => Authentication(),
        );
      case LOGIN:
        return MaterialPageRoute(
          settings: RouteSettings(name: LOGIN),
          builder: (_) => Login(),
        );
      case FORGOT_PASSWORD:
        return MaterialPageRoute(
          settings: RouteSettings(name: LOGIN),
          builder: (_) => ForgotPassword(),
        );
      case SIGN_UP:
        return MaterialPageRoute(
          settings: RouteSettings(name: SIGN_UP),
          builder: (_) => Register(),
        );
      case HOME:
        return MaterialPageRoute(
          settings: RouteSettings(name: HOME),
          builder: (_) => Home(),
        );
      case PROFILE:
        return MaterialPageRoute(
          settings: RouteSettings(name: PROFILE),
          builder: (_) => ProfileTab(),
        );
      case INVITE:
        return MaterialPageRoute(
          settings: RouteSettings(name: INVITE),
          builder: (_) => Invite(),
        );
      case KPP:
        return MaterialPageRoute(
          settings: RouteSettings(name: KPP),
          builder: (_) => KppCategory(),
        );
      case MODULE:
        return MaterialPageRoute(
          settings: RouteSettings(name: MODULE),
          builder: (_) => KppModule(data),
        );
      case KPP_EXAM:
        return MaterialPageRoute(
          settings: RouteSettings(name: KPP_EXAM),
          builder: (_) => KppExam(data),
        );
      case KPP_RESULT:
        return MaterialPageRoute(
          settings: RouteSettings(name: KPP_RESULT),
          builder: (_) => KppResult(data),
        );
      case SETTINGS:
        return MaterialPageRoute(
          settings: RouteSettings(name: SETTINGS),
          builder: (_) => Settings(),
        );
      case CHANGE_PASSWORD:
        return MaterialPageRoute(
          settings: RouteSettings(name: CHANGE_PASSWORD),
          builder: (_) => ChangePassword(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
