// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'coming_soon/coming_soon.dart';
import 'common_library/utils/image_viewer.dart';
import 'pages/chat/chat.dart';
import 'pages/di_enroll/di_enrollment.dart';
import 'pages/emergency/emergency.dart';
import 'pages/enroll/enroll.dart';
import 'pages/epandu/epandu.dart';
import 'pages/etesting/etesting.dart';
import 'pages/forgot_password/forgot_password.dart';
import 'pages/home/home.dart';
import 'pages/inbox/inbox.dart';
import 'pages/invite/invite.dart';
import 'pages/kpp/kpp.dart';
import 'pages/login/login.dart';
import 'pages/pay/pay.dart';
import 'pages/payment/airtime_bill_detail.dart';
import 'pages/payment/airtime_selection.dart';
import 'pages/payment/airtime_transaction.dart';
import 'pages/payment/bill_detail.dart';
import 'pages/payment/bill_selection.dart';
import 'pages/payment/bill_transaction.dart';
import 'pages/pdf/view_pdf.dart';
import 'pages/profile/profile.dart';
import 'pages/promotions/promotions.dart';
import 'pages/register/register.dart';
import 'pages/settings/settings.dart';
import 'pages/vclub/value_club.dart';

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
  static const String queueNumber = '/queue-number';
  static const String settings = '/Settings';
  static const String enrollment = '/Enrollment';
  static const String diEnrollment = '/di-enrollment';
  static const String enrollConfirmation = '/enroll-confirmation';
  static const String orderList = '/order-list';
  static const String bankList = '/bank-list';
  static const String paymentStatus = '/payment-status';
  static const String kppCategory = '/kpp-category';
  static const String kppResult = '/kpp-result';
  static const String kppExam = '/kpp-exam';
  static const String kppModule = '/kpp-module';
  static const String pinActivation = '/pin-activation';
  static const String valueClub = '/value-club';
  static const String product = '/Product';
  static const String productList = '/product-list';
  static const String cart = '/Cart';
  static const String cartItemEdit = '/cart-item-edit';
  static const String checkout = '/Checkout';
  static const String epanduCategory = '/epandu-category';
  static const String etestingCategory = '/etesting-category';
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
  static const String pay = '/Pay';
  static const String purchaseOrderList = '/purchase-order-list';
  static const String paymentHistory = '/payment-history';
  static const String paymentHistoryDetail = '/payment-history-detail';
  static const String requestPickup = '/request-pickup';
  static const String registeredCourse = '/registered-course';
  static const String registeredCourseDetail = '/registered-course-detail';
  static const String attendanceTab = '/attendance-tab';
  static const String promotions = '/Promotions';
  static const String multilevel = '/Multilevel';
  static const String profile = '/Profile';
  static const String profileTab = '/profile-tab';
  static const String updateProfile = '/update-profile';
  static const String registerUserToDi = '/register-user-to-di';
  static const String identityBarcode = '/identity-barcode';
  static const String enrolmentInfo = '/enrolment-info';
  static const String enrolmentInfoDetail = '/enrolment-info-detail';
  static const String inbox = '/Inbox';
  static const String invite = '/Invite';
  static const String airtimeTransaction = '/airtime-transaction';
  static const String airtimeBillDetail = '/airtime-bill-detail';
  static const String airtimeSelection = '/airtime-selection';
  static const String billTransaction = '/bill-transaction';
  static const String billDetail = '/bill-detail';
  static const String billSelection = '/bill-selection';
  static const String merchantList = '/merchant-list';
  static const String chatHome = '/chat-home';
  static const String termsAndCondition = '/terms-and-condition';
  static const String fpxPaymentOption = '/fpx-payment-option';
  static const String imageViewer = '/image-viewer';
  static const String webview = '/Webview';
  static const String readMore = '/read-more';
  static const String comingSoon = '/coming-soon';
  static const String viewPdf = '/view-pdf';
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
    queueNumber,
    settings,
    enrollment,
    diEnrollment,
    enrollConfirmation,
    orderList,
    bankList,
    paymentStatus,
    kppCategory,
    kppResult,
    kppExam,
    kppModule,
    pinActivation,
    valueClub,
    product,
    productList,
    cart,
    cartItemEdit,
    checkout,
    epanduCategory,
    etestingCategory,
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
    pay,
    purchaseOrderList,
    paymentHistory,
    paymentHistoryDetail,
    requestPickup,
    registeredCourse,
    registeredCourseDetail,
    attendanceTab,
    promotions,
    multilevel,
    profile,
    profileTab,
    updateProfile,
    registerUserToDi,
    identityBarcode,
    enrolmentInfo,
    enrolmentInfoDetail,
    inbox,
    invite,
    airtimeTransaction,
    airtimeBillDetail,
    airtimeSelection,
    billTransaction,
    billDetail,
    billSelection,
    merchantList,
    chatHome,
    termsAndCondition,
    fpxPaymentOption,
    imageViewer,
    webview,
    readMore,
    comingSoon,
    viewPdf,
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
    RouteDef(Routes.queueNumber, page: QueueNumber),
    RouteDef(Routes.settings, page: Settings),
    RouteDef(Routes.enrollment, page: Enrollment),
    RouteDef(Routes.diEnrollment, page: DiEnrollment),
    RouteDef(Routes.enrollConfirmation, page: EnrollConfirmation),
    RouteDef(Routes.orderList, page: OrderList),
    RouteDef(Routes.bankList, page: BankList),
    RouteDef(Routes.paymentStatus, page: PaymentStatus),
    RouteDef(Routes.kppCategory, page: KppCategory),
    RouteDef(Routes.kppResult, page: KppResult),
    RouteDef(Routes.kppExam, page: KppExam),
    RouteDef(Routes.kppModule, page: KppModule),
    RouteDef(Routes.pinActivation, page: PinActivation),
    RouteDef(Routes.valueClub, page: ValueClub),
    RouteDef(Routes.product, page: Product),
    RouteDef(Routes.productList, page: ProductList),
    RouteDef(Routes.cart, page: Cart),
    RouteDef(Routes.cartItemEdit, page: CartItemEdit),
    RouteDef(Routes.checkout, page: Checkout),
    RouteDef(Routes.epanduCategory, page: EpanduCategory),
    RouteDef(Routes.etestingCategory, page: EtestingCategory),
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
    RouteDef(Routes.pay, page: Pay),
    RouteDef(Routes.purchaseOrderList, page: PurchaseOrderList),
    RouteDef(Routes.paymentHistory, page: PaymentHistory),
    RouteDef(Routes.paymentHistoryDetail, page: PaymentHistoryDetail),
    RouteDef(Routes.requestPickup, page: RequestPickup),
    RouteDef(Routes.registeredCourse, page: RegisteredCourse),
    RouteDef(Routes.registeredCourseDetail, page: RegisteredCourseDetail),
    RouteDef(Routes.attendanceTab, page: AttendanceTab),
    RouteDef(Routes.promotions, page: Promotions),
    RouteDef(Routes.multilevel, page: Multilevel),
    RouteDef(Routes.profile, page: Profile),
    RouteDef(Routes.profileTab, page: ProfileTab),
    RouteDef(Routes.updateProfile, page: UpdateProfile),
    RouteDef(Routes.registerUserToDi, page: RegisterUserToDi),
    RouteDef(Routes.identityBarcode, page: IdentityBarcode),
    RouteDef(Routes.enrolmentInfo, page: EnrolmentInfo),
    RouteDef(Routes.enrolmentInfoDetail, page: EnrolmentInfoDetail),
    RouteDef(Routes.inbox, page: Inbox),
    RouteDef(Routes.invite, page: Invite),
    RouteDef(Routes.airtimeTransaction, page: AirtimeTransaction),
    RouteDef(Routes.airtimeBillDetail, page: AirtimeBillDetail),
    RouteDef(Routes.airtimeSelection, page: AirtimeSelection),
    RouteDef(Routes.billTransaction, page: BillTransaction),
    RouteDef(Routes.billDetail, page: BillDetail),
    RouteDef(Routes.billSelection, page: BillSelection),
    RouteDef(Routes.merchantList, page: MerchantList),
    RouteDef(Routes.chatHome, page: ChatHome),
    RouteDef(Routes.termsAndCondition, page: TermsAndCondition),
    RouteDef(Routes.fpxPaymentOption, page: FpxPaymentOption),
    RouteDef(Routes.imageViewer, page: ImageViewer),
    RouteDef(Routes.webview, page: Webview),
    RouteDef(Routes.readMore, page: ReadMore),
    RouteDef(Routes.comingSoon, page: ComingSoon),
    RouteDef(Routes.viewPdf, page: ViewPdf),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    Authentication: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Authentication(),
        settings: data,
      );
    },
    ClientAccount: (data) {
      final args = data.getArgs<ClientAccountArguments>(
        orElse: () => ClientAccountArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ClientAccount(data: args.data),
        settings: data,
      );
    },
    Login: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Login(),
        settings: data,
      );
    },
    ForgotPassword: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ForgotPassword(),
        settings: data,
      );
    },
    ChangePassword: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChangePassword(),
        settings: data,
      );
    },
    RegisterMobile: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterMobile(),
        settings: data,
      );
    },
    RegisterVerification: (data) {
      final args = data.getArgs<RegisterVerificationArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterVerification(args.data),
        settings: data,
      );
    },
    RegisterForm: (data) {
      final args = data.getArgs<RegisterFormArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterForm(args.data),
        settings: data,
      );
    },
    Home: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Home(),
        settings: data,
      );
    },
    QueueNumber: (data) {
      final args = data.getArgs<QueueNumberArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => QueueNumber(data: args.data),
        settings: data,
      );
    },
    Settings: (data) {
      final args = data.getArgs<SettingsArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => Settings(args.data),
        settings: data,
      );
    },
    Enrollment: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Enrollment(),
        settings: data,
      );
    },
    DiEnrollment: (data) {
      final args = data.getArgs<DiEnrollmentArguments>(
        orElse: () => DiEnrollmentArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            DiEnrollment(packageCodeJson: args.packageCodeJson),
        settings: data,
      );
    },
    EnrollConfirmation: (data) {
      final args = data.getArgs<EnrollConfirmationArguments>(
        orElse: () => EnrollConfirmationArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => EnrollConfirmation(
          banner: args.banner,
          packageName: args.packageName,
          packageCode: args.packageCode,
          packageDesc: args.packageDesc,
          diCode: args.diCode,
          termsAndCondition: args.termsAndCondition,
          groupIdGrouping: args.groupIdGrouping,
          amount: args.amount,
        ),
        settings: data,
      );
    },
    OrderList: (data) {
      final args = data.getArgs<OrderListArguments>(
        orElse: () => OrderListArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => OrderList(
          icNo: args.icNo,
          packageCode: args.packageCode,
          diCode: args.diCode,
        ),
        settings: data,
      );
    },
    BankList: (data) {
      final args = data.getArgs<BankListArguments>(
        orElse: () => BankListArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => BankList(
          icNo: args.icNo,
          docDoc: args.docDoc,
          docRef: args.docRef,
          packageCode: args.packageCode,
          diCode: args.diCode,
          amountString: args.amountString,
        ),
        settings: data,
      );
    },
    PaymentStatus: (data) {
      final args = data.getArgs<PaymentStatusArguments>(
        orElse: () => PaymentStatusArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => PaymentStatus(icNo: args.icNo),
        settings: data,
      );
    },
    KppCategory: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => KppCategory(),
        settings: data,
      );
    },
    KppResult: (data) {
      final args = data.getArgs<KppResultArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => KppResult(args.data),
        settings: data,
      );
    },
    KppExam: (data) {
      final args = data.getArgs<KppExamArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => KppExam(
          groupId: args.groupId,
          paperNo: args.paperNo,
        ),
        settings: data,
      );
    },
    KppModule: (data) {
      final args = data.getArgs<KppModuleArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => KppModule(args.data),
        settings: data,
      );
    },
    PinActivation: (data) {
      final args = data.getArgs<PinActivationArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PinActivation(args.data),
        settings: data,
      );
    },
    ValueClub: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ValueClub(),
        settings: data,
      );
    },
    Product: (data) {
      final args = data.getArgs<ProductArguments>(
        orElse: () => ProductArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => Product(
          stkCode: args.stkCode,
          stkDesc1: args.stkDesc1,
          stkDesc2: args.stkDesc2,
          qty: args.qty,
          price: args.price,
          image: args.image,
          uom: args.uom,
          products: args.products,
        ),
        settings: data,
      );
    },
    ProductList: (data) {
      final args = data.getArgs<ProductListArguments>(
        orElse: () => ProductListArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProductList(
          stkCat: args.stkCat,
          keywordSearch: args.keywordSearch,
        ),
        settings: data,
      );
    },
    Cart: (data) {
      final args = data.getArgs<CartArguments>(
        orElse: () => CartArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => Cart(
          name: args.name,
          dbcode: args.dbcode,
        ),
        settings: data,
      );
    },
    CartItemEdit: (data) {
      final args = data.getArgs<CartItemEditArguments>(
        orElse: () => CartItemEditArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CartItemEdit(
          stkCode: args.stkCode,
          stkDesc1: args.stkDesc1,
          stkDesc2: args.stkDesc2,
          qty: args.qty,
          price: args.price,
          discRate: args.discRate,
          isOfferedItem: args.isOfferedItem,
          scheduledDeliveryDate: args.scheduledDeliveryDate,
          uom: args.uom,
          batchNo: args.batchNo,
          slsKey: args.slsKey,
        ),
        settings: data,
      );
    },
    Checkout: (data) {
      final args = data.getArgs<CheckoutArguments>(
        orElse: () => CheckoutArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => Checkout(
          slsDetailData: args.slsDetailData,
          name: args.name,
          dbcode: args.dbcode,
          date: args.date,
          docDoc: args.docDoc,
          docRef: args.docRef,
          qty: args.qty,
          totalAmount: args.totalAmount,
        ),
        settings: data,
      );
    },
    EpanduCategory: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EpanduCategory(),
        settings: data,
      );
    },
    EtestingCategory: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EtestingCategory(),
        settings: data,
      );
    },
    EmergencyDirectory: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EmergencyDirectory(),
        settings: data,
      );
    },
    DirectoryList: (data) {
      final args = data.getArgs<DirectoryListArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => DirectoryList(args.directoryType),
        settings: data,
      );
    },
    DirectoryDetail: (data) {
      final args = data.getArgs<DirectoryDetailArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => DirectoryDetail(args.snapshot),
        settings: data,
      );
    },
    SelectInstitute: (data) {
      final args = data.getArgs<SelectInstituteArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SelectInstitute(args.data),
        settings: data,
      );
    },
    SelectClass: (data) {
      final args = data.getArgs<SelectClassArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SelectClass(args.data),
        settings: data,
      );
    },
    SelectDrivingInstitute: (data) {
      final args = data.getArgs<SelectDrivingInstituteArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SelectDrivingInstitute(args.diList),
        settings: data,
      );
    },
    TakeProfilePicture: (data) {
      final args = data.getArgs<TakeProfilePictureArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => TakeProfilePicture(args.camera),
        settings: data,
      );
    },
    Booking: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Booking(),
        settings: data,
      );
    },
    AddBooking: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddBooking(),
        settings: data,
      );
    },
    Records: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Records(),
        settings: data,
      );
    },
    Pay: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Pay(),
        settings: data,
      );
    },
    PurchaseOrderList: (data) {
      final args = data.getArgs<PurchaseOrderListArguments>(
        orElse: () => PurchaseOrderListArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => PurchaseOrderList(
          icNo: args.icNo,
          packageCode: args.packageCode,
          diCode: args.diCode,
        ),
        settings: data,
      );
    },
    PaymentHistory: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PaymentHistory(),
        settings: data,
      );
    },
    PaymentHistoryDetail: (data) {
      final args = data.getArgs<PaymentHistoryDetailArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PaymentHistoryDetail(args.recpNo),
        settings: data,
      );
    },
    RequestPickup: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RequestPickup(),
        settings: data,
      );
    },
    RegisteredCourse: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisteredCourse(),
        settings: data,
      );
    },
    RegisteredCourseDetail: (data) {
      final args = data.getArgs<RegisteredCourseDetailArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisteredCourseDetail(args.groupId),
        settings: data,
      );
    },
    AttendanceTab: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AttendanceTab(),
        settings: data,
      );
    },
    Promotions: (data) {
      final args = data.getArgs<PromotionsArguments>(
        orElse: () => PromotionsArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => Promotions(feed: args.feed),
        settings: data,
      );
    },
    Multilevel: (data) {
      final args = data.getArgs<MultilevelArguments>(
        orElse: () => MultilevelArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => Multilevel(feed: args.feed),
        settings: data,
      );
    },
    Profile: (data) {
      final args = data.getArgs<ProfileArguments>(
        orElse: () => ProfileArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => Profile(
          userProfile: args.userProfile,
          enrollData: args.enrollData,
          isLoading: args.isLoading,
        ),
        settings: data,
      );
    },
    ProfileTab: (data) {
      final args = data.getArgs<ProfileTabArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileTab(args.positionStream),
        settings: data,
      );
    },
    UpdateProfile: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => UpdateProfile(),
        settings: data,
      );
    },
    RegisterUserToDi: (data) {
      final args = data.getArgs<RegisterUserToDiArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterUserToDi(args.barcode),
        settings: data,
      );
    },
    IdentityBarcode: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => IdentityBarcode(),
        settings: data,
      );
    },
    EnrolmentInfo: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EnrolmentInfo(),
        settings: data,
      );
    },
    EnrolmentInfoDetail: (data) {
      final args = data.getArgs<EnrolmentInfoDetailArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => EnrolmentInfoDetail(args.groupId),
        settings: data,
      );
    },
    Inbox: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Inbox(),
        settings: data,
      );
    },
    Invite: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Invite(),
        settings: data,
      );
    },
    AirtimeTransaction: (data) {
      final args = data.getArgs<AirtimeTransactionArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AirtimeTransaction(args.data),
        settings: data,
      );
    },
    AirtimeBillDetail: (data) {
      final args = data.getArgs<AirtimeBillDetailArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AirtimeBillDetail(args.data),
        settings: data,
      );
    },
    AirtimeSelection: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AirtimeSelection(),
        settings: data,
      );
    },
    BillTransaction: (data) {
      final args = data.getArgs<BillTransactionArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => BillTransaction(args.data),
        settings: data,
      );
    },
    BillDetail: (data) {
      final args = data.getArgs<BillDetailArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => BillDetail(args.data),
        settings: data,
      );
    },
    BillSelection: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => BillSelection(),
        settings: data,
      );
    },
    MerchantList: (data) {
      final args = data.getArgs<MerchantListArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => MerchantList(args.merchantType),
        settings: data,
      );
    },
    ChatHome: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChatHome(),
        settings: data,
      );
    },
    TermsAndCondition: (data) {
      final args = data.getArgs<TermsAndConditionArguments>(
        orElse: () => TermsAndConditionArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            TermsAndCondition(termsAndCondition: args.termsAndCondition),
        settings: data,
      );
    },
    FpxPaymentOption: (data) {
      final args = data.getArgs<FpxPaymentOptionArguments>(
        orElse: () => FpxPaymentOptionArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => FpxPaymentOption(
          icNo: args.icNo,
          docDoc: args.docDoc,
          docRef: args.docRef,
          merchant: args.merchant,
          packageCode: args.packageCode,
          packageDesc: args.packageDesc,
          diCode: args.diCode,
          totalAmount: args.totalAmount,
          amountString: args.amountString,
        ),
        settings: data,
      );
    },
    ImageViewer: (data) {
      final args = data.getArgs<ImageViewerArguments>(
        orElse: () => ImageViewerArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ImageViewer(
          title: args.title,
          image: args.image,
        ),
        settings: data,
      );
    },
    Webview: (data) {
      final args = data.getArgs<WebviewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => Webview(
          url: args.url,
          backType: args.backType,
        ),
        settings: data,
      );
    },
    ReadMore: (data) {
      final args = data.getArgs<ReadMoreArguments>(
        orElse: () => ReadMoreArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ReadMore(packageDesc: args.packageDesc),
        settings: data,
      );
    },
    ComingSoon: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ComingSoon(),
        settings: data,
      );
    },
    ViewPdf: (data) {
      final args = data.getArgs<ViewPdfArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ViewPdf(
          title: args.title,
          pdfLink: args.pdfLink,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ClientAccount arguments holder class
class ClientAccountArguments {
  final dynamic data;
  ClientAccountArguments({this.data});
}

/// RegisterVerification arguments holder class
class RegisterVerificationArguments {
  final dynamic data;
  RegisterVerificationArguments({@required this.data});
}

/// RegisterForm arguments holder class
class RegisterFormArguments {
  final dynamic data;
  RegisterFormArguments({@required this.data});
}

/// QueueNumber arguments holder class
class QueueNumberArguments {
  final dynamic data;
  QueueNumberArguments({@required this.data});
}

/// Settings arguments holder class
class SettingsArguments {
  final dynamic data;
  SettingsArguments({@required this.data});
}

/// DiEnrollment arguments holder class
class DiEnrollmentArguments {
  final String packageCodeJson;
  DiEnrollmentArguments({this.packageCodeJson});
}

/// EnrollConfirmation arguments holder class
class EnrollConfirmationArguments {
  final String banner;
  final String packageName;
  final String packageCode;
  final String packageDesc;
  final String diCode;
  final String termsAndCondition;
  final String groupIdGrouping;
  final String amount;
  EnrollConfirmationArguments(
      {this.banner,
      this.packageName,
      this.packageCode,
      this.packageDesc,
      this.diCode,
      this.termsAndCondition,
      this.groupIdGrouping,
      this.amount});
}

/// OrderList arguments holder class
class OrderListArguments {
  final String icNo;
  final String packageCode;
  final String diCode;
  OrderListArguments({this.icNo, this.packageCode, this.diCode});
}

/// BankList arguments holder class
class BankListArguments {
  final String icNo;
  final String docDoc;
  final String docRef;
  final String packageCode;
  final String diCode;
  final String amountString;
  BankListArguments(
      {this.icNo,
      this.docDoc,
      this.docRef,
      this.packageCode,
      this.diCode,
      this.amountString});
}

/// PaymentStatus arguments holder class
class PaymentStatusArguments {
  final String icNo;
  PaymentStatusArguments({this.icNo});
}

/// KppResult arguments holder class
class KppResultArguments {
  final dynamic data;
  KppResultArguments({@required this.data});
}

/// KppExam arguments holder class
class KppExamArguments {
  final String groupId;
  final String paperNo;
  KppExamArguments({@required this.groupId, @required this.paperNo});
}

/// KppModule arguments holder class
class KppModuleArguments {
  final dynamic data;
  KppModuleArguments({@required this.data});
}

/// PinActivation arguments holder class
class PinActivationArguments {
  final String data;
  PinActivationArguments({@required this.data});
}

/// Product arguments holder class
class ProductArguments {
  final String stkCode;
  final String stkDesc1;
  final String stkDesc2;
  final String qty;
  final String price;
  final String image;
  final String uom;
  final dynamic products;
  ProductArguments(
      {this.stkCode,
      this.stkDesc1,
      this.stkDesc2,
      this.qty,
      this.price,
      this.image,
      this.uom,
      this.products});
}

/// ProductList arguments holder class
class ProductListArguments {
  final String stkCat;
  final String keywordSearch;
  ProductListArguments({this.stkCat, this.keywordSearch});
}

/// Cart arguments holder class
class CartArguments {
  final String name;
  final String dbcode;
  CartArguments({this.name, this.dbcode});
}

/// CartItemEdit arguments holder class
class CartItemEditArguments {
  final String stkCode;
  final String stkDesc1;
  final String stkDesc2;
  final String qty;
  final String price;
  final String discRate;
  final String isOfferedItem;
  final String scheduledDeliveryDate;
  final String uom;
  final String batchNo;
  final String slsKey;
  CartItemEditArguments(
      {this.stkCode,
      this.stkDesc1,
      this.stkDesc2,
      this.qty,
      this.price,
      this.discRate,
      this.isOfferedItem,
      this.scheduledDeliveryDate,
      this.uom,
      this.batchNo,
      this.slsKey});
}

/// Checkout arguments holder class
class CheckoutArguments {
  final dynamic slsDetailData;
  final String name;
  final String dbcode;
  final String date;
  final String docDoc;
  final String docRef;
  final String qty;
  final String totalAmount;
  CheckoutArguments(
      {this.slsDetailData,
      this.name,
      this.dbcode,
      this.date,
      this.docDoc,
      this.docRef,
      this.qty,
      this.totalAmount});
}

/// DirectoryList arguments holder class
class DirectoryListArguments {
  final dynamic directoryType;
  DirectoryListArguments({@required this.directoryType});
}

/// DirectoryDetail arguments holder class
class DirectoryDetailArguments {
  final dynamic snapshot;
  DirectoryDetailArguments({@required this.snapshot});
}

/// SelectInstitute arguments holder class
class SelectInstituteArguments {
  final dynamic data;
  SelectInstituteArguments({@required this.data});
}

/// SelectClass arguments holder class
class SelectClassArguments {
  final dynamic data;
  SelectClassArguments({@required this.data});
}

/// SelectDrivingInstitute arguments holder class
class SelectDrivingInstituteArguments {
  final dynamic diList;
  SelectDrivingInstituteArguments({@required this.diList});
}

/// TakeProfilePicture arguments holder class
class TakeProfilePictureArguments {
  final List<CameraDescription> camera;
  TakeProfilePictureArguments({@required this.camera});
}

/// PurchaseOrderList arguments holder class
class PurchaseOrderListArguments {
  final String icNo;
  final String packageCode;
  final String diCode;
  PurchaseOrderListArguments({this.icNo, this.packageCode, this.diCode});
}

/// PaymentHistoryDetail arguments holder class
class PaymentHistoryDetailArguments {
  final dynamic recpNo;
  PaymentHistoryDetailArguments({@required this.recpNo});
}

/// RegisteredCourseDetail arguments holder class
class RegisteredCourseDetailArguments {
  final dynamic groupId;
  RegisteredCourseDetailArguments({@required this.groupId});
}

/// Promotions arguments holder class
class PromotionsArguments {
  final dynamic feed;
  PromotionsArguments({this.feed});
}

/// Multilevel arguments holder class
class MultilevelArguments {
  final dynamic feed;
  MultilevelArguments({this.feed});
}

/// Profile arguments holder class
class ProfileArguments {
  final dynamic userProfile;
  final dynamic enrollData;
  final dynamic isLoading;
  ProfileArguments({this.userProfile, this.enrollData, this.isLoading});
}

/// ProfileTab arguments holder class
class ProfileTabArguments {
  final dynamic positionStream;
  ProfileTabArguments({@required this.positionStream});
}

/// RegisterUserToDi arguments holder class
class RegisterUserToDiArguments {
  final dynamic barcode;
  RegisterUserToDiArguments({@required this.barcode});
}

/// EnrolmentInfoDetail arguments holder class
class EnrolmentInfoDetailArguments {
  final dynamic groupId;
  EnrolmentInfoDetailArguments({@required this.groupId});
}

/// AirtimeTransaction arguments holder class
class AirtimeTransactionArguments {
  final dynamic data;
  AirtimeTransactionArguments({@required this.data});
}

/// AirtimeBillDetail arguments holder class
class AirtimeBillDetailArguments {
  final dynamic data;
  AirtimeBillDetailArguments({@required this.data});
}

/// BillTransaction arguments holder class
class BillTransactionArguments {
  final dynamic data;
  BillTransactionArguments({@required this.data});
}

/// BillDetail arguments holder class
class BillDetailArguments {
  final dynamic data;
  BillDetailArguments({@required this.data});
}

/// MerchantList arguments holder class
class MerchantListArguments {
  final dynamic merchantType;
  MerchantListArguments({@required this.merchantType});
}

/// TermsAndCondition arguments holder class
class TermsAndConditionArguments {
  final String termsAndCondition;
  TermsAndConditionArguments({this.termsAndCondition});
}

/// FpxPaymentOption arguments holder class
class FpxPaymentOptionArguments {
  final String icNo;
  final String docDoc;
  final String docRef;
  final String merchant;
  final String packageCode;
  final String packageDesc;
  final String diCode;
  final String totalAmount;
  final String amountString;
  FpxPaymentOptionArguments(
      {this.icNo,
      this.docDoc,
      this.docRef,
      this.merchant,
      this.packageCode,
      this.packageDesc,
      this.diCode,
      this.totalAmount,
      this.amountString});
}

/// ImageViewer arguments holder class
class ImageViewerArguments {
  final String title;
  final NetworkImage image;
  ImageViewerArguments({this.title, this.image});
}

/// Webview arguments holder class
class WebviewArguments {
  final String url;
  final String backType;
  WebviewArguments({@required this.url, this.backType});
}

/// ReadMore arguments holder class
class ReadMoreArguments {
  final String packageDesc;
  ReadMoreArguments({this.packageDesc});
}

/// ViewPdf arguments holder class
class ViewPdfArguments {
  final String title;
  final String pdfLink;
  ViewPdfArguments({@required this.title, @required this.pdfLink});
}
