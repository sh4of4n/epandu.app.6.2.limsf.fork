// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:epandu/pages/login/authentication.dart';
import 'package:epandu/pages/login/client_acc_page.dart';
import 'package:epandu/pages/login/login_page.dart';
import 'package:epandu/pages/forgot_password/forgot_password_page.dart';
import 'package:epandu/pages/settings/change_password.dart';
import 'package:epandu/pages/register/register_mobile.dart';
import 'package:epandu/pages/register/register_verification.dart';
import 'package:epandu/pages/register/register_form.dart';
import 'package:epandu/pages/home/home_page.dart';
import 'package:epandu/pages/settings/settings_page.dart';
import 'package:epandu/pages/enroll/enrollment.dart';
import 'package:epandu/pages/kpp/kpp_category.dart';
import 'package:epandu/pages/kpp/kpp_result.dart';
import 'package:epandu/pages/kpp/kpp_exam.dart';
import 'package:epandu/pages/kpp/kpp_module.dart';
import 'package:epandu/pages/kpp/pin_activation.dart';
import 'package:epandu/pages/vclub/value_club_page.dart';
import 'package:epandu/pages/epandu/epandu_category.dart';
import 'package:epandu/pages/emergency/emergency_directory.dart';
import 'package:epandu/pages/emergency/directory_list.dart';
import 'package:epandu/pages/emergency/directory_detail.dart';
import 'package:epandu/pages/enroll/select_institute.dart';
import 'package:epandu/pages/enroll/select_class.dart';
import 'package:epandu/pages/login/select_driving_institute.dart';
import 'package:epandu/pages/profile/take_profile_picture.dart';
import 'package:camera/camera.dart';
import 'package:epandu/pages/epandu/booking.dart';
import 'package:epandu/pages/epandu/add_booking.dart';
import 'package:epandu/pages/epandu/records.dart';
import 'package:epandu/pages/epandu/payment_history.dart';
import 'package:epandu/pages/epandu/payment_history_detail.dart';
import 'package:epandu/pages/epandu/request_pickup.dart';
import 'package:epandu/pages/epandu/registered_course.dart';
import 'package:epandu/pages/epandu/registered_course_detail.dart';
import 'package:epandu/pages/epandu/attendance_record.dart';
import 'package:epandu/pages/promotions/promotions_page.dart';
import 'package:epandu/pages/profile/profile_page.dart';
import 'package:epandu/pages/profile/profile_tab.dart';
import 'package:epandu/pages/profile/update_profile.dart';
import 'package:epandu/pages/register/register_user_to_di.dart';
import 'package:epandu/pages/profile/identity_barcode.dart';
import 'package:epandu/pages/inbox/inbox_page.dart';
import 'package:epandu/pages/invite/invite.dart';
import 'package:epandu/pages/payment/airtime_transaction.dart';
import 'package:epandu/pages/payment/airtime_bill_detail.dart';
import 'package:epandu/pages/payment/airtime_selection.dart';
import 'package:epandu/pages/payment/bill_transaction.dart';
import 'package:epandu/pages/payment/bill_detail.dart';
import 'package:epandu/pages/payment/bill_selection.dart';
import 'package:epandu/pages/vclub/merchant_list.dart';
import 'package:epandu/pages/home/webview.dart';
import 'package:epandu/coming_soon/coming_soon.dart';

class Routes {
  static const String authentication = '/';
  static const String clientAccount = '/client-account';
  static const String login = '/Login';
  static const String forgotPassword = '/forgot-password';
  static const String changePassword = '/change-password';
  static const String registerMobile = '/register-mobile';
  static const String registerVerification = '/register-verification';
  static const String registerForm = '/register-form';
  static const String home = '/Home';
  static const String settings = '/Settings';
  static const String enrollment = '/Enrollment';
  static const String kppCategory = '/kpp-category';
  static const String kppResult = '/kpp-result';
  static const String kppExam = '/kpp-exam';
  static const String kppModule = '/kpp-module';
  static const String pinActivation = '/pin-activation';
  static const String valueClub = '/value-club';
  static const String epanduCategory = '/epandu-category';
  static const String emergencyDirectory = '/emergency-directory';
  static const String directoryList = '/directory-list';
  static const String directoryDetail = '/directory-detail';
  static const String selectInstitute = '/select-institute';
  static const String selectClass = '/select-class';
  static const String selectDrivingInstitute = '/select-driving-institute';
  static const String takeProfilePicture = '/take-profile-picture';
  static const String booking = '/Booking';
  static const String addBooking = '/add-booking';
  static const String records = '/Records';
  static const String paymentHistory = '/payment-history';
  static const String paymentHistoryDetail = '/payment-history-detail';
  static const String requestPickup = '/request-pickup';
  static const String registeredCourse = '/registered-course';
  static const String registeredCourseDetail = '/registered-course-detail';
  static const String attendanceRecord = '/attendance-record';
  static const String promotions = '/Promotions';
  static const String profile = '/Profile';
  static const String profileTab = '/profile-tab';
  static const String updateProfile = '/update-profile';
  static const String registerUserToDi = '/register-user-to-di';
  static const String identityBarcode = '/identity-barcode';
  static const String inbox = '/Inbox';
  static const String invite = '/Invite';
  static const String airtimeTransaction = '/airtime-transaction';
  static const String airtimeBillDetail = '/airtime-bill-detail';
  static const String airtimeSelection = '/airtime-selection';
  static const String billTransaction = '/bill-transaction';
  static const String billDetail = '/bill-detail';
  static const String billSelection = '/bill-selection';
  static const String merchantList = '/merchant-list';
  static const String webview = '/Webview';
  static const String comingSoon = '/coming-soon';
  static const all = <String>{
    authentication,
    clientAccount,
    login,
    forgotPassword,
    changePassword,
    registerMobile,
    registerVerification,
    registerForm,
    home,
    settings,
    enrollment,
    kppCategory,
    kppResult,
    kppExam,
    kppModule,
    pinActivation,
    valueClub,
    epanduCategory,
    emergencyDirectory,
    directoryList,
    directoryDetail,
    selectInstitute,
    selectClass,
    selectDrivingInstitute,
    takeProfilePicture,
    booking,
    addBooking,
    records,
    paymentHistory,
    paymentHistoryDetail,
    requestPickup,
    registeredCourse,
    registeredCourseDetail,
    attendanceRecord,
    promotions,
    profile,
    profileTab,
    updateProfile,
    registerUserToDi,
    identityBarcode,
    inbox,
    invite,
    airtimeTransaction,
    airtimeBillDetail,
    airtimeSelection,
    billTransaction,
    billDetail,
    billSelection,
    merchantList,
    webview,
    comingSoon,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.authentication, page: Authentication),
    RouteDef(Routes.clientAccount, page: ClientAccount),
    RouteDef(Routes.login, page: Login),
    RouteDef(Routes.forgotPassword, page: ForgotPassword),
    RouteDef(Routes.changePassword, page: ChangePassword),
    RouteDef(Routes.registerMobile, page: RegisterMobile),
    RouteDef(Routes.registerVerification, page: RegisterVerification),
    RouteDef(Routes.registerForm, page: RegisterForm),
    RouteDef(Routes.home, page: Home),
    RouteDef(Routes.settings, page: Settings),
    RouteDef(Routes.enrollment, page: Enrollment),
    RouteDef(Routes.kppCategory, page: KppCategory),
    RouteDef(Routes.kppResult, page: KppResult),
    RouteDef(Routes.kppExam, page: KppExam),
    RouteDef(Routes.kppModule, page: KppModule),
    RouteDef(Routes.pinActivation, page: PinActivation),
    RouteDef(Routes.valueClub, page: ValueClub),
    RouteDef(Routes.epanduCategory, page: EpanduCategory),
    RouteDef(Routes.emergencyDirectory, page: EmergencyDirectory),
    RouteDef(Routes.directoryList, page: DirectoryList),
    RouteDef(Routes.directoryDetail, page: DirectoryDetail),
    RouteDef(Routes.selectInstitute, page: SelectInstitute),
    RouteDef(Routes.selectClass, page: SelectClass),
    RouteDef(Routes.selectDrivingInstitute, page: SelectDrivingInstitute),
    RouteDef(Routes.takeProfilePicture, page: TakeProfilePicture),
    RouteDef(Routes.booking, page: Booking),
    RouteDef(Routes.addBooking, page: AddBooking),
    RouteDef(Routes.records, page: Records),
    RouteDef(Routes.paymentHistory, page: PaymentHistory),
    RouteDef(Routes.paymentHistoryDetail, page: PaymentHistoryDetail),
    RouteDef(Routes.requestPickup, page: RequestPickup),
    RouteDef(Routes.registeredCourse, page: RegisteredCourse),
    RouteDef(Routes.registeredCourseDetail, page: RegisteredCourseDetail),
    RouteDef(Routes.attendanceRecord, page: AttendanceRecord),
    RouteDef(Routes.promotions, page: Promotions),
    RouteDef(Routes.profile, page: Profile),
    RouteDef(Routes.profileTab, page: ProfileTab),
    RouteDef(Routes.updateProfile, page: UpdateProfile),
    RouteDef(Routes.registerUserToDi, page: RegisterUserToDi),
    RouteDef(Routes.identityBarcode, page: IdentityBarcode),
    RouteDef(Routes.inbox, page: Inbox),
    RouteDef(Routes.invite, page: Invite),
    RouteDef(Routes.airtimeTransaction, page: AirtimeTransaction),
    RouteDef(Routes.airtimeBillDetail, page: AirtimeBillDetail),
    RouteDef(Routes.airtimeSelection, page: AirtimeSelection),
    RouteDef(Routes.billTransaction, page: BillTransaction),
    RouteDef(Routes.billDetail, page: BillDetail),
    RouteDef(Routes.billSelection, page: BillSelection),
    RouteDef(Routes.merchantList, page: MerchantList),
    RouteDef(Routes.webview, page: Webview),
    RouteDef(Routes.comingSoon, page: ComingSoon),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    Authentication: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Authentication(),
        settings: data,
      );
    },
    ClientAccount: (RouteData data) {
      var args = data.getArgs<ClientAccountArguments>(
          orElse: () => ClientAccountArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => ClientAccount(data: args.data),
        settings: data,
      );
    },
    Login: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Login(),
        settings: data,
      );
    },
    ForgotPassword: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ForgotPassword(),
        settings: data,
      );
    },
    ChangePassword: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChangePassword(),
        settings: data,
      );
    },
    RegisterMobile: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterMobile(),
        settings: data,
      );
    },
    RegisterVerification: (RouteData data) {
      var args = data.getArgs<RegisterVerificationArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterVerification(args.data),
        settings: data,
      );
    },
    RegisterForm: (RouteData data) {
      var args = data.getArgs<RegisterFormArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterForm(args.data),
        settings: data,
      );
    },
    Home: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Home(),
        settings: data,
      );
    },
    Settings: (RouteData data) {
      var args = data.getArgs<SettingsArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => Settings(args.data),
        settings: data,
      );
    },
    Enrollment: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Enrollment(),
        settings: data,
      );
    },
    KppCategory: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => KppCategory(),
        settings: data,
      );
    },
    KppResult: (RouteData data) {
      var args = data.getArgs<KppResultArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => KppResult(args.data),
        settings: data,
      );
    },
    KppExam: (RouteData data) {
      var args = data.getArgs<KppExamArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            KppExam(groupId: args.groupId, paperNo: args.paperNo),
        settings: data,
      );
    },
    KppModule: (RouteData data) {
      var args = data.getArgs<KppModuleArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => KppModule(args.data),
        settings: data,
      );
    },
    PinActivation: (RouteData data) {
      var args = data.getArgs<PinActivationArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PinActivation(args.data),
        settings: data,
      );
    },
    ValueClub: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ValueClub(),
        settings: data,
      );
    },
    EpanduCategory: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EpanduCategory(),
        settings: data,
      );
    },
    EmergencyDirectory: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EmergencyDirectory(),
        settings: data,
      );
    },
    DirectoryList: (RouteData data) {
      var args = data.getArgs<DirectoryListArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => DirectoryList(args.directoryType),
        settings: data,
      );
    },
    DirectoryDetail: (RouteData data) {
      var args = data.getArgs<DirectoryDetailArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => DirectoryDetail(args.snapshot),
        settings: data,
      );
    },
    SelectInstitute: (RouteData data) {
      var args = data.getArgs<SelectInstituteArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SelectInstitute(args.data),
        settings: data,
      );
    },
    SelectClass: (RouteData data) {
      var args = data.getArgs<SelectClassArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SelectClass(args.data),
        settings: data,
      );
    },
    SelectDrivingInstitute: (RouteData data) {
      var args = data.getArgs<SelectDrivingInstituteArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SelectDrivingInstitute(args.diList),
        settings: data,
      );
    },
    TakeProfilePicture: (RouteData data) {
      var args = data.getArgs<TakeProfilePictureArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => TakeProfilePicture(args.camera),
        settings: data,
      );
    },
    Booking: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Booking(),
        settings: data,
      );
    },
    AddBooking: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddBooking(),
        settings: data,
      );
    },
    Records: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Records(),
        settings: data,
      );
    },
    PaymentHistory: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PaymentHistory(),
        settings: data,
      );
    },
    PaymentHistoryDetail: (RouteData data) {
      var args = data.getArgs<PaymentHistoryDetailArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PaymentHistoryDetail(args.recpNo),
        settings: data,
      );
    },
    RequestPickup: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RequestPickup(),
        settings: data,
      );
    },
    RegisteredCourse: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisteredCourse(),
        settings: data,
      );
    },
    RegisteredCourseDetail: (RouteData data) {
      var args = data.getArgs<RegisteredCourseDetailArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisteredCourseDetail(args.groupId),
        settings: data,
      );
    },
    AttendanceRecord: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AttendanceRecord(),
        settings: data,
      );
    },
    Promotions: (RouteData data) {
      var args = data.getArgs<PromotionsArguments>(
          orElse: () => PromotionsArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => Promotions(feed: args.feed),
        settings: data,
      );
    },
    Profile: (RouteData data) {
      var args =
          data.getArgs<ProfileArguments>(orElse: () => ProfileArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            Profile(userProfile: args.userProfile, isLoading: args.isLoading),
        settings: data,
      );
    },
    ProfileTab: (RouteData data) {
      var args = data.getArgs<ProfileTabArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileTab(args.positionStream),
        settings: data,
      );
    },
    UpdateProfile: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => UpdateProfile(),
        settings: data,
      );
    },
    RegisterUserToDi: (RouteData data) {
      var args = data.getArgs<RegisterUserToDiArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterUserToDi(args.barcode),
        settings: data,
      );
    },
    IdentityBarcode: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => IdentityBarcode(),
        settings: data,
      );
    },
    Inbox: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Inbox(),
        settings: data,
      );
    },
    Invite: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Invite(),
        settings: data,
      );
    },
    AirtimeTransaction: (RouteData data) {
      var args = data.getArgs<AirtimeTransactionArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AirtimeTransaction(args.data),
        settings: data,
      );
    },
    AirtimeBillDetail: (RouteData data) {
      var args = data.getArgs<AirtimeBillDetailArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AirtimeBillDetail(args.data),
        settings: data,
      );
    },
    AirtimeSelection: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AirtimeSelection(),
        settings: data,
      );
    },
    BillTransaction: (RouteData data) {
      var args = data.getArgs<BillTransactionArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => BillTransaction(args.data),
        settings: data,
      );
    },
    BillDetail: (RouteData data) {
      var args = data.getArgs<BillDetailArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => BillDetail(args.data),
        settings: data,
      );
    },
    BillSelection: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => BillSelection(),
        settings: data,
      );
    },
    MerchantList: (RouteData data) {
      var args = data.getArgs<MerchantListArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => MerchantList(args.merchantType),
        settings: data,
      );
    },
    Webview: (RouteData data) {
      var args = data.getArgs<WebviewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => Webview(url: args.url),
        settings: data,
      );
    },
    ComingSoon: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ComingSoon(),
        settings: data,
      );
    },
  };
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//ClientAccount arguments holder class
class ClientAccountArguments {
  final dynamic data;
  ClientAccountArguments({this.data});
}

//RegisterVerification arguments holder class
class RegisterVerificationArguments {
  final dynamic data;
  RegisterVerificationArguments({@required this.data});
}

//RegisterForm arguments holder class
class RegisterFormArguments {
  final dynamic data;
  RegisterFormArguments({@required this.data});
}

//Settings arguments holder class
class SettingsArguments {
  final dynamic data;
  SettingsArguments({@required this.data});
}

//KppResult arguments holder class
class KppResultArguments {
  final dynamic data;
  KppResultArguments({@required this.data});
}

//KppExam arguments holder class
class KppExamArguments {
  final String groupId;
  final String paperNo;
  KppExamArguments({@required this.groupId, @required this.paperNo});
}

//KppModule arguments holder class
class KppModuleArguments {
  final dynamic data;
  KppModuleArguments({@required this.data});
}

//PinActivation arguments holder class
class PinActivationArguments {
  final String data;
  PinActivationArguments({@required this.data});
}

//DirectoryList arguments holder class
class DirectoryListArguments {
  final dynamic directoryType;
  DirectoryListArguments({@required this.directoryType});
}

//DirectoryDetail arguments holder class
class DirectoryDetailArguments {
  final dynamic snapshot;
  DirectoryDetailArguments({@required this.snapshot});
}

//SelectInstitute arguments holder class
class SelectInstituteArguments {
  final dynamic data;
  SelectInstituteArguments({@required this.data});
}

//SelectClass arguments holder class
class SelectClassArguments {
  final dynamic data;
  SelectClassArguments({@required this.data});
}

//SelectDrivingInstitute arguments holder class
class SelectDrivingInstituteArguments {
  final dynamic diList;
  SelectDrivingInstituteArguments({@required this.diList});
}

//TakeProfilePicture arguments holder class
class TakeProfilePictureArguments {
  final List<CameraDescription> camera;
  TakeProfilePictureArguments({@required this.camera});
}

//PaymentHistoryDetail arguments holder class
class PaymentHistoryDetailArguments {
  final dynamic recpNo;
  PaymentHistoryDetailArguments({@required this.recpNo});
}

//RegisteredCourseDetail arguments holder class
class RegisteredCourseDetailArguments {
  final dynamic groupId;
  RegisteredCourseDetailArguments({@required this.groupId});
}

//Promotions arguments holder class
class PromotionsArguments {
  final dynamic feed;
  PromotionsArguments({this.feed});
}

//Profile arguments holder class
class ProfileArguments {
  final dynamic userProfile;
  final dynamic isLoading;
  ProfileArguments({this.userProfile, this.isLoading});
}

//ProfileTab arguments holder class
class ProfileTabArguments {
  final dynamic positionStream;
  ProfileTabArguments({@required this.positionStream});
}

//RegisterUserToDi arguments holder class
class RegisterUserToDiArguments {
  final dynamic barcode;
  RegisterUserToDiArguments({@required this.barcode});
}

//AirtimeTransaction arguments holder class
class AirtimeTransactionArguments {
  final dynamic data;
  AirtimeTransactionArguments({@required this.data});
}

//AirtimeBillDetail arguments holder class
class AirtimeBillDetailArguments {
  final dynamic data;
  AirtimeBillDetailArguments({@required this.data});
}

//BillTransaction arguments holder class
class BillTransactionArguments {
  final dynamic data;
  BillTransactionArguments({@required this.data});
}

//BillDetail arguments holder class
class BillDetailArguments {
  final dynamic data;
  BillDetailArguments({@required this.data});
}

//MerchantList arguments holder class
class MerchantListArguments {
  final dynamic merchantType;
  MerchantListArguments({@required this.merchantType});
}

//Webview arguments holder class
class WebviewArguments {
  final String url;
  WebviewArguments({@required this.url});
}
