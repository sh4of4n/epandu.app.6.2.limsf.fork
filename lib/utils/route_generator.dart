import 'package:epandu/pages/initial_auth/authentication.dart';
import 'package:epandu/pages/invite/invite.dart';
import 'package:epandu/pages/kpp/kpp_category.dart';
import 'package:epandu/pages/kpp/kpp_module.dart';
import 'package:epandu/pages/kpp/kpp_exam.dart';
import 'package:epandu/pages/login/login.dart';
import 'package:epandu/pages/profile/profile.dart';
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
          settings: RouteSettings(name: PROFILE),
          builder: (_) => Invite(),
        );
      case KPP:
        return MaterialPageRoute(
          settings: RouteSettings(name: PROFILE),
          builder: (_) => KppCategory(),
        );
      case MODULE:
        return MaterialPageRoute(
          settings: RouteSettings(name: PROFILE),
          builder: (_) => KppModule(data),
        );
      case KPP_EXAM:
        return MaterialPageRoute(
          settings: RouteSettings(name: PROFILE),
          builder: (_) => KppExam(data),
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
