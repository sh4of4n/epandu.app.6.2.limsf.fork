import 'package:epandu/pages/emergency/directory_detail.dart';
import 'package:epandu/pages/emergency/directory_list.dart';
import 'package:epandu/pages/emergency/emergency.dart';
import 'package:epandu/pages/emergency/emergency_directory.dart';
import 'package:epandu/pages/forgot_password/forgot_password.dart';
import 'package:epandu/pages/invite/invite.dart';
import 'package:epandu/pages/kpp/kpp_category.dart';
import 'package:epandu/pages/kpp/kpp_module.dart';
import 'package:epandu/pages/kpp/kpp_exam.dart';
import 'package:epandu/pages/kpp/kpp_result.dart';
import 'package:epandu/pages/login/login.dart';
import 'package:epandu/pages/payment/payment.dart';
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
      case CLIENT_ACC:
        return MaterialPageRoute(
          settings: RouteSettings(name: CLIENT_ACC),
          builder: (_) => ClientAccount(data),
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
          builder: (_) => Register(data),
        );
      case SIGN_UP_TYPE:
        return MaterialPageRoute(
          settings: RouteSettings(name: SIGN_UP_TYPE),
          builder: (_) => RegisterType(),
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
      case EMERGENCY:
        return MaterialPageRoute(
          settings: RouteSettings(name: EMERGENCY),
          builder: (_) => Emergency(),
        );
      case EMERGENCY_DIRECTORY:
        return MaterialPageRoute(
          settings: RouteSettings(name: EMERGENCY_DIRECTORY),
          builder: (_) => EmergencyDirectory(),
        );
      case DIRECTORY_LIST:
        return MaterialPageRoute(
          settings: RouteSettings(name: DIRECTORY_LIST),
          builder: (_) => DirectoryList(data),
        );
      case DIRECTORY_DETAIL:
        return MaterialPageRoute(
          settings: RouteSettings(name: DIRECTORY_LIST),
          builder: (_) => DirectoryDetail(data),
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
      case SELECT_DI:
        return MaterialPageRoute(
          settings: RouteSettings(name: SELECT_DI),
          builder: (_) => SelectDrivingInstitute(data),
        );
      case PAYMENT:
        return MaterialPageRoute(
          settings: RouteSettings(name: PAYMENT),
          builder: (_) => PaymentPage(),
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
