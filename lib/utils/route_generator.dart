import 'package:epandu/pages/epandu/epandu.dart';
import 'package:epandu/pages/menu/menu.dart';
import 'package:epandu/pages/promotions/promotions.dart';
import 'package:flutter/material.dart';

import 'package:epandu/pages/emergency/emergency.dart';
import 'package:epandu/pages/enroll/enroll.dart';
import 'package:epandu/pages/forgot_password/forgot_password.dart';
import 'package:epandu/pages/invite/invite.dart';
import 'package:epandu/pages/kpp/kpp.dart';
import 'package:epandu/pages/login/login.dart';
import 'package:epandu/pages/payment/payment.dart';
import 'package:epandu/pages/profile/profile.dart';
import 'package:epandu/pages/register/register.dart';
import 'package:epandu/pages/settings/settings.dart';
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
      case HOME_TAB:
        return MaterialPageRoute(
          settings: RouteSettings(name: HOME_TAB),
          builder: (_) => HomeTab(),
        );
      case HOME:
        return MaterialPageRoute(
          settings: RouteSettings(name: HOME),
          builder: (_) => Home(),
        );
      case PROMOTIONS:
        return MaterialPageRoute(
          settings: RouteSettings(name: PROMOTIONS),
          builder: (_) => Promotions(),
        );
      case MENU:
        return MaterialPageRoute(
          settings: RouteSettings(name: MENU),
          builder: (_) => Menu(data),
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
      case PIN_ACTIVATION:
        return MaterialPageRoute(
          settings: RouteSettings(name: PIN_ACTIVATION),
          builder: (_) => PinActivation(data),
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
          builder: (_) => Settings(data),
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
      case AIRTIME_SELECTION:
        return MaterialPageRoute(
          settings: RouteSettings(name: AIRTIME_SELECTION),
          builder: (_) => AirtimeSelection(),
        );
      case AIRTIME_BILL_DETAIL:
        return MaterialPageRoute(
          settings: RouteSettings(name: AIRTIME_BILL_DETAIL),
          builder: (_) => AirtimeBillDetail(data),
        );
      case AIRTIME_TRANSACTION:
        return MaterialPageRoute(
          settings: RouteSettings(name: AIRTIME_TRANSACTION),
          builder: (_) => AirtimeTransaction(data),
        );
      case BILL_SELECTION:
        return MaterialPageRoute(
          settings: RouteSettings(name: BILL_SELECTION),
          builder: (_) => BillSelection(),
        );
      case BILL_DETAIL:
        return MaterialPageRoute(
          settings: RouteSettings(name: BILL_DETAIL),
          builder: (_) => BillDetail(data),
        );
      case BILL_TRANSACTION:
        return MaterialPageRoute(
          settings: RouteSettings(name: BILL_TRANSACTION),
          builder: (_) => BillTransaction(data),
        );
      case CHECK_ENROLLMENT:
        return MaterialPageRoute(
          settings: RouteSettings(name: CHECK_ENROLLMENT),
          builder: (_) => CheckEnrollment(),
        );
      case SELECT_INSTITUTE:
        return MaterialPageRoute(
          settings: RouteSettings(name: SELECT_INSTITUTE),
          builder: (_) => SelectInstitute(),
        );
      case SELECT_CLASS:
        return MaterialPageRoute(
          settings: RouteSettings(name: SELECT_CLASS),
          builder: (_) => SelectClass(data),
        );
      case ENROLLMENT:
        return MaterialPageRoute(
          settings: RouteSettings(name: ENROLLMENT),
          builder: (_) => Enrollment(data),
        );
      case EPANDU:
        return MaterialPageRoute(
          settings: RouteSettings(name: EPANDU),
          builder: (_) => EpanduCategory(),
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
