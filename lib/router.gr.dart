// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:camera/camera.dart' as _i30;
import 'package:flutter/material.dart' as _i2;

import 'coming_soon/coming_soon.dart' as _i29;
import 'common_library/utils/image_viewer.dart' as _i27;
import 'pages/chat/chat.dart' as _i26;
import 'pages/di_enroll/di_enrollment.dart' as _i9;
import 'pages/emergency/emergency.dart' as _i14;
import 'pages/enroll/enroll.dart' as _i8;
import 'pages/epandu/epandu.dart' as _i12;
import 'pages/etesting/etesting.dart' as _i13;
import 'pages/forgot_password/forgot_password.dart' as _i4;
import 'pages/home/home.dart' as _i7;
import 'pages/inbox/inbox.dart' as _i18;
import 'pages/invite/invite.dart' as _i19;
import 'pages/kpp/kpp.dart' as _i10;
import 'pages/login/login.dart' as _i3;
import 'pages/pay/pay.dart' as _i16;
import 'pages/payment/airtime_bill_detail.dart' as _i21;
import 'pages/payment/airtime_selection.dart' as _i22;
import 'pages/payment/airtime_transaction.dart' as _i20;
import 'pages/payment/bill_detail.dart' as _i24;
import 'pages/payment/bill_selection.dart' as _i25;
import 'pages/payment/bill_transaction.dart' as _i23;
import 'pages/pdf/view_pdf.dart' as _i28;
import 'pages/profile/profile.dart' as _i15;
import 'pages/promotions/promotions.dart' as _i17;
import 'pages/register/register.dart' as _i6;
import 'pages/settings/settings.dart' as _i5;
import 'pages/vclub/value_club.dart' as _i11;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    Authentication.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.Authentication();
        }),
    ClientAccount.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ClientAccountArgs>(
              orElse: () => const ClientAccountArgs());
          return _i3.ClientAccount(data: args.data);
        }),
    Login.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.Login();
        }),
    ForgotPassword.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.ForgotPassword();
        }),
    ChangePassword.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.ChangePassword();
        }),
    RegisterMobile.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i6.RegisterMobile();
        }),
    RegisterVerification.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<RegisterVerificationArgs>();
          return _i6.RegisterVerification(args.data);
        }),
    RegisterForm.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<RegisterFormArgs>();
          return _i6.RegisterForm(args.data);
        }),
    Home.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i7.Home();
        }),
    QueueNumber.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<QueueNumberArgs>();
          return _i7.QueueNumber(data: args.data);
        }),
    Settings.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<SettingsArgs>();
          return _i5.Settings(args.data);
        }),
    Enrollment.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i8.Enrollment();
        }),
    DiEnrollment.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<DiEnrollmentArgs>(
              orElse: () => const DiEnrollmentArgs());
          return _i9.DiEnrollment(packageCodeJson: args.packageCodeJson);
        }),
    EnrollConfirmation.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<EnrollConfirmationArgs>(
              orElse: () => const EnrollConfirmationArgs());
          return _i9.EnrollConfirmation(
              banner: args.banner,
              packageName: args.packageName,
              packageCode: args.packageCode,
              packageDesc: args.packageDesc,
              diCode: args.diCode,
              termsAndCondition: args.termsAndCondition,
              groupIdGrouping: args.groupIdGrouping,
              amount: args.amount);
        }),
    OrderList.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args =
              data.argsAs<OrderListArgs>(orElse: () => const OrderListArgs());
          return _i9.OrderList(
              icNo: args.icNo,
              packageCode: args.packageCode,
              diCode: args.diCode);
        }),
    BankList.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args =
              data.argsAs<BankListArgs>(orElse: () => const BankListArgs());
          return _i9.BankList(
              icNo: args.icNo,
              docDoc: args.docDoc,
              docRef: args.docRef,
              packageCode: args.packageCode,
              diCode: args.diCode,
              amountString: args.amountString);
        }),
    PaymentStatus.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<PaymentStatusArgs>(
              orElse: () => const PaymentStatusArgs());
          return _i9.PaymentStatus(icNo: args.icNo);
        }),
    KppCategory.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i10.KppCategory();
        }),
    KppResult.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<KppResultArgs>();
          return _i10.KppResult(args.data);
        }),
    KppExam.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<KppExamArgs>();
          return _i10.KppExam(groupId: args.groupId, paperNo: args.paperNo);
        }),
    KppModule.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<KppModuleArgs>();
          return _i10.KppModule(args.data);
        }),
    PinActivation.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<PinActivationArgs>();
          return _i10.PinActivation(args.data);
        }),
    ValueClub.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i11.ValueClub();
        }),
    Product.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args =
              data.argsAs<ProductArgs>(orElse: () => const ProductArgs());
          return _i11.Product(
              stkCode: args.stkCode,
              stkDesc1: args.stkDesc1,
              stkDesc2: args.stkDesc2,
              qty: args.qty,
              price: args.price,
              image: args.image,
              uom: args.uom,
              products: args.products);
        }),
    ProductList.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ProductListArgs>(
              orElse: () => const ProductListArgs());
          return _i11.ProductList(
              stkCat: args.stkCat, keywordSearch: args.keywordSearch);
        }),
    Cart.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<CartArgs>(orElse: () => const CartArgs());
          return _i11.Cart(itemName: args.itemName, dbcode: args.dbcode);
        }),
    CartItemEdit.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<CartItemEditArgs>(
              orElse: () => const CartItemEditArgs());
          return _i11.CartItemEdit(
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
              slsKey: args.slsKey);
        }),
    Checkout.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args =
              data.argsAs<CheckoutArgs>(orElse: () => const CheckoutArgs());
          return _i11.Checkout(
              slsDetailData: args.slsDetailData,
              itemName: args.itemName,
              dbcode: args.dbcode,
              date: args.date,
              docDoc: args.docDoc,
              docRef: args.docRef,
              qty: args.qty,
              totalAmount: args.totalAmount);
        }),
    EpanduCategory.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i12.EpanduCategory();
        }),
    EtestingCategory.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i13.EtestingCategory();
        }),
    EmergencyDirectory.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i14.EmergencyDirectory();
        }),
    DirectoryList.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<DirectoryListArgs>();
          return _i14.DirectoryList(args.directoryType);
        }),
    DirectoryDetail.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<DirectoryDetailArgs>();
          return _i14.DirectoryDetail(args.snapshot);
        }),
    SelectInstitute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<SelectInstituteArgs>();
          return _i8.SelectInstitute(args.data);
        }),
    SelectClass.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<SelectClassArgs>();
          return _i8.SelectClass(args.data);
        }),
    SelectDrivingInstitute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<SelectDrivingInstituteArgs>();
          return _i3.SelectDrivingInstitute(args.diList);
        }),
    TakeProfilePicture.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<TakeProfilePictureArgs>();
          return _i15.TakeProfilePicture(args.camera);
        }),
    Booking.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i12.Booking();
        }),
    AddBooking.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i12.AddBooking();
        }),
    Records.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i12.Records();
        }),
    Pay.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i16.Pay();
        }),
    PurchaseOrderList.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<PurchaseOrderListArgs>(
              orElse: () => const PurchaseOrderListArgs());
          return _i16.PurchaseOrderList(
              icNo: args.icNo,
              packageCode: args.packageCode,
              diCode: args.diCode);
        }),
    PaymentHistory.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i12.PaymentHistory();
        }),
    PaymentHistoryDetail.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<PaymentHistoryDetailArgs>();
          return _i12.PaymentHistoryDetail(args.recpNo);
        }),
    RequestPickup.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i12.RequestPickup();
        }),
    RegisteredCourse.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i12.RegisteredCourse();
        }),
    RegisteredCourseDetail.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<RegisteredCourseDetailArgs>();
          return _i12.RegisteredCourseDetail(args.groupId);
        }),
    AttendanceRecord.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<AttendanceRecordArgs>();
          return _i12.AttendanceRecord(
              attendanceData: args.attendanceData, isLoading: args.isLoading);
        }),
    AttendanceTab.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i12.AttendanceTab();
        }),
    Promotions.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args =
              data.argsAs<PromotionsArgs>(orElse: () => const PromotionsArgs());
          return _i17.Promotions(feed: args.feed);
        }),
    Profile.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args =
              data.argsAs<ProfileArgs>(orElse: () => const ProfileArgs());
          return _i15.Profile(
              userProfile: args.userProfile,
              enrollData: args.enrollData,
              isLoading: args.isLoading);
        }),
    ProfileTab.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ProfileTabArgs>();
          return _i15.ProfileTab(args.positionStream);
        }),
    UpdateProfile.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i15.UpdateProfile();
        }),
    RegisterUserToDi.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<RegisterUserToDiArgs>();
          return _i6.RegisterUserToDi(args.barcode);
        }),
    IdentityBarcode.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i15.IdentityBarcode();
        }),
    EnrolmentInfo.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i15.EnrolmentInfo();
        }),
    EnrolmentInfoDetail.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<EnrolmentInfoDetailArgs>();
          return _i15.EnrolmentInfoDetail(args.groupId);
        }),
    Inbox.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i18.Inbox();
        }),
    Invite.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i19.Invite();
        }),
    AirtimeTransaction.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<AirtimeTransactionArgs>();
          return _i20.AirtimeTransaction(args.data);
        }),
    AirtimeBillDetail.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<AirtimeBillDetailArgs>();
          return _i21.AirtimeBillDetail(args.data);
        }),
    AirtimeSelection.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i22.AirtimeSelection();
        }),
    BillTransaction.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<BillTransactionArgs>();
          return _i23.BillTransaction(args.data);
        }),
    BillDetail.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<BillDetailArgs>();
          return _i24.BillDetail(args.data);
        }),
    BillSelection.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i25.BillSelection();
        }),
    MerchantList.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<MerchantListArgs>();
          return _i11.MerchantList(args.merchantType);
        }),
    ChatHome.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i26.ChatHome();
        }),
    TermsAndCondition.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<TermsAndConditionArgs>(
              orElse: () => const TermsAndConditionArgs());
          return _i9.TermsAndCondition(
              termsAndCondition: args.termsAndCondition);
        }),
    FpxPaymentOption.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<FpxPaymentOptionArgs>(
              orElse: () => const FpxPaymentOptionArgs());
          return _i16.FpxPaymentOption(
              icNo: args.icNo,
              docDoc: args.docDoc,
              docRef: args.docRef,
              merchant: args.merchant,
              packageCode: args.packageCode,
              packageDesc: args.packageDesc,
              diCode: args.diCode,
              totalAmount: args.totalAmount,
              amountString: args.amountString);
        }),
    ImageViewer.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ImageViewerArgs>(
              orElse: () => const ImageViewerArgs());
          return _i27.ImageViewer(title: args.title, image: args.image);
        }),
    Webview.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<WebviewArgs>();
          return _i7.Webview(url: args.url, backType: args.backType);
        }),
    Scan.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ScanArgs>(orElse: () => const ScanArgs());
          return _i7.Scan(
              getActiveFeed: args.getActiveFeed,
              getDiProfile: args.getDiProfile,
              key: args.key);
        }),
    ReadMore.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args =
              data.argsAs<ReadMoreArgs>(orElse: () => const ReadMoreArgs());
          return _i9.ReadMore(packageDesc: args.packageDesc);
        }),
    ViewPdf.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ViewPdfArgs>();
          return _i28.ViewPdf(title: args.title, pdfLink: args.pdfLink);
        }),
    ComingSoon.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i29.ComingSoon();
        }),
    CheckInSlip.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i13.CheckInSlip();
        }),
    Multilevel.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args =
              data.argsAs<MultilevelArgs>(orElse: () => const MultilevelArgs());
          return _i17.Multilevel(feed: args.feed, appVersion: args.appVersion);
        }),
    MerchantProfile.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i15.MerchantProfile();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig('/#redirect',
            path: '/', redirectTo: '/authentication', fullMatch: true),
        _i1.RouteConfig(Authentication.name, path: '/authentication'),
        _i1.RouteConfig(ClientAccount.name, path: '/clientAccount'),
        _i1.RouteConfig(Login.name, path: '/login'),
        _i1.RouteConfig(ForgotPassword.name, path: '/forgotPassword'),
        _i1.RouteConfig(ChangePassword.name, path: '/changePassword'),
        _i1.RouteConfig(RegisterMobile.name, path: '/registerMobile'),
        _i1.RouteConfig(RegisterVerification.name,
            path: '/registerVerification'),
        _i1.RouteConfig(RegisterForm.name, path: '/registerForm'),
        _i1.RouteConfig(Home.name, path: '/home'),
        _i1.RouteConfig(QueueNumber.name, path: '/queueNumber'),
        _i1.RouteConfig(Settings.name, path: '/settings'),
        _i1.RouteConfig(Enrollment.name, path: '/enrollment'),
        _i1.RouteConfig(DiEnrollment.name, path: '/diEnrollment'),
        _i1.RouteConfig(EnrollConfirmation.name, path: '/enrollConfirmation'),
        _i1.RouteConfig(OrderList.name, path: '/orderList'),
        _i1.RouteConfig(BankList.name, path: '/bankList'),
        _i1.RouteConfig(PaymentStatus.name, path: '/paymentStatus'),
        _i1.RouteConfig(KppCategory.name, path: '/kppCategory'),
        _i1.RouteConfig(KppResult.name, path: '/kppResult'),
        _i1.RouteConfig(KppExam.name, path: '/kppExam'),
        _i1.RouteConfig(KppModule.name, path: '/kppModule'),
        _i1.RouteConfig(PinActivation.name, path: '/pinActivation'),
        _i1.RouteConfig(ValueClub.name, path: '/valueClub'),
        _i1.RouteConfig(Product.name, path: '/product'),
        _i1.RouteConfig(ProductList.name, path: '/productList'),
        _i1.RouteConfig(Cart.name, path: '/cart'),
        _i1.RouteConfig(CartItemEdit.name, path: '/cartItemEdit'),
        _i1.RouteConfig(Checkout.name, path: '/checkout'),
        _i1.RouteConfig(EpanduCategory.name, path: '/epanduCategory'),
        _i1.RouteConfig(EtestingCategory.name, path: '/epanduCategory'),
        _i1.RouteConfig(EmergencyDirectory.name, path: '/emergencyDirectory'),
        _i1.RouteConfig(DirectoryList.name, path: '/directoryList'),
        _i1.RouteConfig(DirectoryDetail.name, path: '/directoryDetail'),
        _i1.RouteConfig(SelectInstitute.name, path: '/selectInstitute'),
        _i1.RouteConfig(SelectClass.name, path: '/selectClass'),
        _i1.RouteConfig(SelectDrivingInstitute.name,
            path: '/selectDrivingInstitute'),
        _i1.RouteConfig(TakeProfilePicture.name, path: '/takeProfilePicture'),
        _i1.RouteConfig(Booking.name, path: '/booking'),
        _i1.RouteConfig(AddBooking.name, path: '/addBooking'),
        _i1.RouteConfig(Records.name, path: '/records'),
        _i1.RouteConfig(Pay.name, path: '/pay'),
        _i1.RouteConfig(PurchaseOrderList.name, path: '/purchaseOrderList'),
        _i1.RouteConfig(PaymentHistory.name, path: '/paymentHistory'),
        _i1.RouteConfig(PaymentHistoryDetail.name,
            path: '/paymentHistoryDetail'),
        _i1.RouteConfig(RequestPickup.name, path: '/requestPickup'),
        _i1.RouteConfig(RegisteredCourse.name, path: '/registeredCourse'),
        _i1.RouteConfig(RegisteredCourseDetail.name,
            path: '/registeredCourseDetail'),
        _i1.RouteConfig(AttendanceRecord.name, path: '/attendanceRecord'),
        _i1.RouteConfig(AttendanceTab.name, path: '/attendanceTab'),
        _i1.RouteConfig(Promotions.name, path: '/promotions'),
        _i1.RouteConfig(Profile.name, path: '/profile'),
        _i1.RouteConfig(ProfileTab.name, path: '/profileTab'),
        _i1.RouteConfig(UpdateProfile.name, path: '/updateProfile'),
        _i1.RouteConfig(RegisterUserToDi.name, path: 'registerUserToDi'),
        _i1.RouteConfig(IdentityBarcode.name, path: '/identityBarcode'),
        _i1.RouteConfig(EnrolmentInfo.name, path: '/enrolmentInfo'),
        _i1.RouteConfig(EnrolmentInfoDetail.name, path: '/enrolmentInfoDetail'),
        _i1.RouteConfig(Inbox.name, path: '/inbox'),
        _i1.RouteConfig(Invite.name, path: '/invite'),
        _i1.RouteConfig(AirtimeTransaction.name, path: '/airtimeTransaction'),
        _i1.RouteConfig(AirtimeBillDetail.name, path: '/airtimeBillDetail'),
        _i1.RouteConfig(AirtimeSelection.name, path: '/airtimeSelection'),
        _i1.RouteConfig(BillTransaction.name, path: '/billTransaction'),
        _i1.RouteConfig(BillDetail.name, path: '/billDetail'),
        _i1.RouteConfig(BillSelection.name, path: '/billSelection'),
        _i1.RouteConfig(MerchantList.name, path: '/merchantList'),
        _i1.RouteConfig(ChatHome.name, path: '/chatHome'),
        _i1.RouteConfig(TermsAndCondition.name, path: '/termsAndCondition'),
        _i1.RouteConfig(FpxPaymentOption.name, path: '/fpxPaymentOption'),
        _i1.RouteConfig(ImageViewer.name, path: '/imageViewer'),
        _i1.RouteConfig(Webview.name, path: '/webview'),
        _i1.RouteConfig(Scan.name, path: '/scan'),
        _i1.RouteConfig(ReadMore.name, path: '/readMore'),
        _i1.RouteConfig(ViewPdf.name, path: '/viewPdf'),
        _i1.RouteConfig(ComingSoon.name, path: '/comingSoon'),
        _i1.RouteConfig(CheckInSlip.name, path: '/checkInSlip'),
        _i1.RouteConfig(Multilevel.name, path: '/multilevel'),
        _i1.RouteConfig(MerchantProfile.name, path: '/merchantProfile')
      ];
}

class Authentication extends _i1.PageRouteInfo {
  const Authentication() : super(name, path: '/authentication');

  static const String name = 'Authentication';
}

class ClientAccount extends _i1.PageRouteInfo<ClientAccountArgs> {
  ClientAccount({dynamic data})
      : super(name,
            path: '/clientAccount', args: ClientAccountArgs(data: data));

  static const String name = 'ClientAccount';
}

class ClientAccountArgs {
  const ClientAccountArgs({this.data});

  final dynamic data;
}

class Login extends _i1.PageRouteInfo {
  const Login() : super(name, path: '/login');

  static const String name = 'Login';
}

class ForgotPassword extends _i1.PageRouteInfo {
  const ForgotPassword() : super(name, path: '/forgotPassword');

  static const String name = 'ForgotPassword';
}

class ChangePassword extends _i1.PageRouteInfo {
  const ChangePassword() : super(name, path: '/changePassword');

  static const String name = 'ChangePassword';
}

class RegisterMobile extends _i1.PageRouteInfo {
  const RegisterMobile() : super(name, path: '/registerMobile');

  static const String name = 'RegisterMobile';
}

class RegisterVerification extends _i1.PageRouteInfo<RegisterVerificationArgs> {
  RegisterVerification({required dynamic data})
      : super(name,
            path: '/registerVerification',
            args: RegisterVerificationArgs(data: data));

  static const String name = 'RegisterVerification';
}

class RegisterVerificationArgs {
  const RegisterVerificationArgs({required this.data});

  final dynamic data;
}

class RegisterForm extends _i1.PageRouteInfo<RegisterFormArgs> {
  RegisterForm({required dynamic data})
      : super(name, path: '/registerForm', args: RegisterFormArgs(data: data));

  static const String name = 'RegisterForm';
}

class RegisterFormArgs {
  const RegisterFormArgs({required this.data});

  final dynamic data;
}

class Home extends _i1.PageRouteInfo {
  const Home() : super(name, path: '/home');

  static const String name = 'Home';
}

class QueueNumber extends _i1.PageRouteInfo<QueueNumberArgs> {
  QueueNumber({required dynamic data})
      : super(name, path: '/queueNumber', args: QueueNumberArgs(data: data));

  static const String name = 'QueueNumber';
}

class QueueNumberArgs {
  const QueueNumberArgs({required this.data});

  final dynamic data;
}

class Settings extends _i1.PageRouteInfo<SettingsArgs> {
  Settings({required dynamic data})
      : super(name, path: '/settings', args: SettingsArgs(data: data));

  static const String name = 'Settings';
}

class SettingsArgs {
  const SettingsArgs({required this.data});

  final dynamic data;
}

class Enrollment extends _i1.PageRouteInfo {
  const Enrollment() : super(name, path: '/enrollment');

  static const String name = 'Enrollment';
}

class DiEnrollment extends _i1.PageRouteInfo<DiEnrollmentArgs> {
  DiEnrollment({String? packageCodeJson})
      : super(name,
            path: '/diEnrollment',
            args: DiEnrollmentArgs(packageCodeJson: packageCodeJson));

  static const String name = 'DiEnrollment';
}

class DiEnrollmentArgs {
  const DiEnrollmentArgs({this.packageCodeJson});

  final String? packageCodeJson;
}

class EnrollConfirmation extends _i1.PageRouteInfo<EnrollConfirmationArgs> {
  EnrollConfirmation(
      {String? banner,
      String? packageName,
      String? packageCode,
      String? packageDesc,
      String? diCode,
      String? termsAndCondition,
      String? groupIdGrouping,
      String? amount})
      : super(name,
            path: '/enrollConfirmation',
            args: EnrollConfirmationArgs(
                banner: banner,
                packageName: packageName,
                packageCode: packageCode,
                packageDesc: packageDesc,
                diCode: diCode,
                termsAndCondition: termsAndCondition,
                groupIdGrouping: groupIdGrouping,
                amount: amount));

  static const String name = 'EnrollConfirmation';
}

class EnrollConfirmationArgs {
  const EnrollConfirmationArgs(
      {this.banner,
      this.packageName,
      this.packageCode,
      this.packageDesc,
      this.diCode,
      this.termsAndCondition,
      this.groupIdGrouping,
      this.amount});

  final String? banner;

  final String? packageName;

  final String? packageCode;

  final String? packageDesc;

  final String? diCode;

  final String? termsAndCondition;

  final String? groupIdGrouping;

  final String? amount;
}

class OrderList extends _i1.PageRouteInfo<OrderListArgs> {
  OrderList({String? icNo, String? packageCode, String? diCode})
      : super(name,
            path: '/orderList',
            args: OrderListArgs(
                icNo: icNo, packageCode: packageCode, diCode: diCode));

  static const String name = 'OrderList';
}

class OrderListArgs {
  const OrderListArgs({this.icNo, this.packageCode, this.diCode});

  final String? icNo;

  final String? packageCode;

  final String? diCode;
}

class BankList extends _i1.PageRouteInfo<BankListArgs> {
  BankList(
      {String? icNo,
      String? docDoc,
      String? docRef,
      String? packageCode,
      String? diCode,
      String? amountString})
      : super(name,
            path: '/bankList',
            args: BankListArgs(
                icNo: icNo,
                docDoc: docDoc,
                docRef: docRef,
                packageCode: packageCode,
                diCode: diCode,
                amountString: amountString));

  static const String name = 'BankList';
}

class BankListArgs {
  const BankListArgs(
      {this.icNo,
      this.docDoc,
      this.docRef,
      this.packageCode,
      this.diCode,
      this.amountString});

  final String? icNo;

  final String? docDoc;

  final String? docRef;

  final String? packageCode;

  final String? diCode;

  final String? amountString;
}

class PaymentStatus extends _i1.PageRouteInfo<PaymentStatusArgs> {
  PaymentStatus({String? icNo})
      : super(name,
            path: '/paymentStatus', args: PaymentStatusArgs(icNo: icNo));

  static const String name = 'PaymentStatus';
}

class PaymentStatusArgs {
  const PaymentStatusArgs({this.icNo});

  final String? icNo;
}

class KppCategory extends _i1.PageRouteInfo {
  const KppCategory() : super(name, path: '/kppCategory');

  static const String name = 'KppCategory';
}

class KppResult extends _i1.PageRouteInfo<KppResultArgs> {
  KppResult({required dynamic data})
      : super(name, path: '/kppResult', args: KppResultArgs(data: data));

  static const String name = 'KppResult';
}

class KppResultArgs {
  const KppResultArgs({required this.data});

  final dynamic data;
}

class KppExam extends _i1.PageRouteInfo<KppExamArgs> {
  KppExam({required String? groupId, required String? paperNo})
      : super(name,
            path: '/kppExam',
            args: KppExamArgs(groupId: groupId, paperNo: paperNo));

  static const String name = 'KppExam';
}

class KppExamArgs {
  const KppExamArgs({required this.groupId, required this.paperNo});

  final String? groupId;

  final String? paperNo;
}

class KppModule extends _i1.PageRouteInfo<KppModuleArgs> {
  KppModule({required dynamic data})
      : super(name, path: '/kppModule', args: KppModuleArgs(data: data));

  static const String name = 'KppModule';
}

class KppModuleArgs {
  const KppModuleArgs({required this.data});

  final dynamic data;
}

class PinActivation extends _i1.PageRouteInfo<PinActivationArgs> {
  PinActivation({required String data})
      : super(name,
            path: '/pinActivation', args: PinActivationArgs(data: data));

  static const String name = 'PinActivation';
}

class PinActivationArgs {
  const PinActivationArgs({required this.data});

  final String data;
}

class ValueClub extends _i1.PageRouteInfo {
  const ValueClub() : super(name, path: '/valueClub');

  static const String name = 'ValueClub';
}

class Product extends _i1.PageRouteInfo<ProductArgs> {
  Product(
      {String? stkCode,
      String? stkDesc1,
      String? stkDesc2,
      String? qty,
      String? price,
      String? image,
      String? uom,
      dynamic products})
      : super(name,
            path: '/product',
            args: ProductArgs(
                stkCode: stkCode,
                stkDesc1: stkDesc1,
                stkDesc2: stkDesc2,
                qty: qty,
                price: price,
                image: image,
                uom: uom,
                products: products));

  static const String name = 'Product';
}

class ProductArgs {
  const ProductArgs(
      {this.stkCode,
      this.stkDesc1,
      this.stkDesc2,
      this.qty,
      this.price,
      this.image,
      this.uom,
      this.products});

  final String? stkCode;

  final String? stkDesc1;

  final String? stkDesc2;

  final String? qty;

  final String? price;

  final String? image;

  final String? uom;

  final dynamic products;
}

class ProductList extends _i1.PageRouteInfo<ProductListArgs> {
  ProductList({String? stkCat, String? keywordSearch})
      : super(name,
            path: '/productList',
            args:
                ProductListArgs(stkCat: stkCat, keywordSearch: keywordSearch));

  static const String name = 'ProductList';
}

class ProductListArgs {
  const ProductListArgs({this.stkCat, this.keywordSearch});

  final String? stkCat;

  final String? keywordSearch;
}

class Cart extends _i1.PageRouteInfo<CartArgs> {
  Cart({String? itemName, String? dbcode})
      : super(name,
            path: '/cart', args: CartArgs(itemName: itemName, dbcode: dbcode));

  static const String name = 'Cart';
}

class CartArgs {
  const CartArgs({this.itemName, this.dbcode});

  final String? itemName;

  final String? dbcode;
}

class CartItemEdit extends _i1.PageRouteInfo<CartItemEditArgs> {
  CartItemEdit(
      {String? stkCode,
      String? stkDesc1,
      String? stkDesc2,
      String? qty,
      String? price,
      String? discRate,
      String? isOfferedItem,
      String? scheduledDeliveryDate,
      String? uom,
      String? batchNo,
      String? slsKey})
      : super(name,
            path: '/cartItemEdit',
            args: CartItemEditArgs(
                stkCode: stkCode,
                stkDesc1: stkDesc1,
                stkDesc2: stkDesc2,
                qty: qty,
                price: price,
                discRate: discRate,
                isOfferedItem: isOfferedItem,
                scheduledDeliveryDate: scheduledDeliveryDate,
                uom: uom,
                batchNo: batchNo,
                slsKey: slsKey));

  static const String name = 'CartItemEdit';
}

class CartItemEditArgs {
  const CartItemEditArgs(
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

  final String? stkCode;

  final String? stkDesc1;

  final String? stkDesc2;

  final String? qty;

  final String? price;

  final String? discRate;

  final String? isOfferedItem;

  final String? scheduledDeliveryDate;

  final String? uom;

  final String? batchNo;

  final String? slsKey;
}

class Checkout extends _i1.PageRouteInfo<CheckoutArgs> {
  Checkout(
      {dynamic slsDetailData,
      String? itemName,
      String? dbcode,
      String? date,
      String? docDoc,
      String? docRef,
      String? qty,
      String? totalAmount})
      : super(name,
            path: '/checkout',
            args: CheckoutArgs(
                slsDetailData: slsDetailData,
                itemName: itemName,
                dbcode: dbcode,
                date: date,
                docDoc: docDoc,
                docRef: docRef,
                qty: qty,
                totalAmount: totalAmount));

  static const String name = 'Checkout';
}

class CheckoutArgs {
  const CheckoutArgs(
      {this.slsDetailData,
      this.itemName,
      this.dbcode,
      this.date,
      this.docDoc,
      this.docRef,
      this.qty,
      this.totalAmount});

  final dynamic slsDetailData;

  final String? itemName;

  final String? dbcode;

  final String? date;

  final String? docDoc;

  final String? docRef;

  final String? qty;

  final String? totalAmount;
}

class EpanduCategory extends _i1.PageRouteInfo {
  const EpanduCategory() : super(name, path: '/epanduCategory');

  static const String name = 'EpanduCategory';
}

class EtestingCategory extends _i1.PageRouteInfo {
  const EtestingCategory() : super(name, path: '/epanduCategory');

  static const String name = 'EtestingCategory';
}

class EmergencyDirectory extends _i1.PageRouteInfo {
  const EmergencyDirectory() : super(name, path: '/emergencyDirectory');

  static const String name = 'EmergencyDirectory';
}

class DirectoryList extends _i1.PageRouteInfo<DirectoryListArgs> {
  DirectoryList({required dynamic directoryType})
      : super(name,
            path: '/directoryList',
            args: DirectoryListArgs(directoryType: directoryType));

  static const String name = 'DirectoryList';
}

class DirectoryListArgs {
  const DirectoryListArgs({required this.directoryType});

  final dynamic directoryType;
}

class DirectoryDetail extends _i1.PageRouteInfo<DirectoryDetailArgs> {
  DirectoryDetail({required dynamic snapshot})
      : super(name,
            path: '/directoryDetail',
            args: DirectoryDetailArgs(snapshot: snapshot));

  static const String name = 'DirectoryDetail';
}

class DirectoryDetailArgs {
  const DirectoryDetailArgs({required this.snapshot});

  final dynamic snapshot;
}

class SelectInstitute extends _i1.PageRouteInfo<SelectInstituteArgs> {
  SelectInstitute({required dynamic data})
      : super(name,
            path: '/selectInstitute', args: SelectInstituteArgs(data: data));

  static const String name = 'SelectInstitute';
}

class SelectInstituteArgs {
  const SelectInstituteArgs({required this.data});

  final dynamic data;
}

class SelectClass extends _i1.PageRouteInfo<SelectClassArgs> {
  SelectClass({required dynamic data})
      : super(name, path: '/selectClass', args: SelectClassArgs(data: data));

  static const String name = 'SelectClass';
}

class SelectClassArgs {
  const SelectClassArgs({required this.data});

  final dynamic data;
}

class SelectDrivingInstitute
    extends _i1.PageRouteInfo<SelectDrivingInstituteArgs> {
  SelectDrivingInstitute({required dynamic diList})
      : super(name,
            path: '/selectDrivingInstitute',
            args: SelectDrivingInstituteArgs(diList: diList));

  static const String name = 'SelectDrivingInstitute';
}

class SelectDrivingInstituteArgs {
  const SelectDrivingInstituteArgs({required this.diList});

  final dynamic diList;
}

class TakeProfilePicture extends _i1.PageRouteInfo<TakeProfilePictureArgs> {
  TakeProfilePicture({required List<_i30.CameraDescription>? camera})
      : super(name,
            path: '/takeProfilePicture',
            args: TakeProfilePictureArgs(camera: camera));

  static const String name = 'TakeProfilePicture';
}

class TakeProfilePictureArgs {
  const TakeProfilePictureArgs({required this.camera});

  final List<_i30.CameraDescription>? camera;
}

class Booking extends _i1.PageRouteInfo {
  const Booking() : super(name, path: '/booking');

  static const String name = 'Booking';
}

class AddBooking extends _i1.PageRouteInfo {
  const AddBooking() : super(name, path: '/addBooking');

  static const String name = 'AddBooking';
}

class Records extends _i1.PageRouteInfo {
  const Records() : super(name, path: '/records');

  static const String name = 'Records';
}

class Pay extends _i1.PageRouteInfo {
  const Pay() : super(name, path: '/pay');

  static const String name = 'Pay';
}

class PurchaseOrderList extends _i1.PageRouteInfo<PurchaseOrderListArgs> {
  PurchaseOrderList({String? icNo, String? packageCode, String? diCode})
      : super(name,
            path: '/purchaseOrderList',
            args: PurchaseOrderListArgs(
                icNo: icNo, packageCode: packageCode, diCode: diCode));

  static const String name = 'PurchaseOrderList';
}

class PurchaseOrderListArgs {
  const PurchaseOrderListArgs({this.icNo, this.packageCode, this.diCode});

  final String? icNo;

  final String? packageCode;

  final String? diCode;
}

class PaymentHistory extends _i1.PageRouteInfo {
  const PaymentHistory() : super(name, path: '/paymentHistory');

  static const String name = 'PaymentHistory';
}

class PaymentHistoryDetail extends _i1.PageRouteInfo<PaymentHistoryDetailArgs> {
  PaymentHistoryDetail({required dynamic recpNo})
      : super(name,
            path: '/paymentHistoryDetail',
            args: PaymentHistoryDetailArgs(recpNo: recpNo));

  static const String name = 'PaymentHistoryDetail';
}

class PaymentHistoryDetailArgs {
  const PaymentHistoryDetailArgs({required this.recpNo});

  final dynamic recpNo;
}

class RequestPickup extends _i1.PageRouteInfo {
  const RequestPickup() : super(name, path: '/requestPickup');

  static const String name = 'RequestPickup';
}

class RegisteredCourse extends _i1.PageRouteInfo {
  const RegisteredCourse() : super(name, path: '/registeredCourse');

  static const String name = 'RegisteredCourse';
}

class RegisteredCourseDetail
    extends _i1.PageRouteInfo<RegisteredCourseDetailArgs> {
  RegisteredCourseDetail({required dynamic groupId})
      : super(name,
            path: '/registeredCourseDetail',
            args: RegisteredCourseDetailArgs(groupId: groupId));

  static const String name = 'RegisteredCourseDetail';
}

class RegisteredCourseDetailArgs {
  const RegisteredCourseDetailArgs({required this.groupId});

  final dynamic groupId;
}

class AttendanceRecord extends _i1.PageRouteInfo<AttendanceRecordArgs> {
  AttendanceRecord({required dynamic attendanceData, required bool? isLoading})
      : super(name,
            path: '/attendanceRecord',
            args: AttendanceRecordArgs(
                attendanceData: attendanceData, isLoading: isLoading));

  static const String name = 'AttendanceRecord';
}

class AttendanceRecordArgs {
  const AttendanceRecordArgs(
      {required this.attendanceData, required this.isLoading});

  final dynamic attendanceData;

  final bool? isLoading;
}

class AttendanceTab extends _i1.PageRouteInfo {
  const AttendanceTab() : super(name, path: '/attendanceTab');

  static const String name = 'AttendanceTab';
}

class Promotions extends _i1.PageRouteInfo<PromotionsArgs> {
  Promotions({dynamic feed})
      : super(name, path: '/promotions', args: PromotionsArgs(feed: feed));

  static const String name = 'Promotions';
}

class PromotionsArgs {
  const PromotionsArgs({this.feed});

  final dynamic feed;
}

class Profile extends _i1.PageRouteInfo<ProfileArgs> {
  Profile({dynamic userProfile, dynamic enrollData, dynamic isLoading})
      : super(name,
            path: '/profile',
            args: ProfileArgs(
                userProfile: userProfile,
                enrollData: enrollData,
                isLoading: isLoading));

  static const String name = 'Profile';
}

class ProfileArgs {
  const ProfileArgs({this.userProfile, this.enrollData, this.isLoading});

  final dynamic userProfile;

  final dynamic enrollData;

  final dynamic isLoading;
}

class ProfileTab extends _i1.PageRouteInfo<ProfileTabArgs> {
  ProfileTab({required dynamic positionStream})
      : super(name,
            path: '/profileTab',
            args: ProfileTabArgs(positionStream: positionStream));

  static const String name = 'ProfileTab';
}

class ProfileTabArgs {
  const ProfileTabArgs({required this.positionStream});

  final dynamic positionStream;
}

class UpdateProfile extends _i1.PageRouteInfo {
  const UpdateProfile() : super(name, path: '/updateProfile');

  static const String name = 'UpdateProfile';
}

class RegisterUserToDi extends _i1.PageRouteInfo<RegisterUserToDiArgs> {
  RegisterUserToDi({required dynamic barcode})
      : super(name,
            path: 'registerUserToDi',
            args: RegisterUserToDiArgs(barcode: barcode));

  static const String name = 'RegisterUserToDi';
}

class RegisterUserToDiArgs {
  const RegisterUserToDiArgs({required this.barcode});

  final dynamic barcode;
}

class IdentityBarcode extends _i1.PageRouteInfo {
  const IdentityBarcode() : super(name, path: '/identityBarcode');

  static const String name = 'IdentityBarcode';
}

class EnrolmentInfo extends _i1.PageRouteInfo {
  const EnrolmentInfo() : super(name, path: '/enrolmentInfo');

  static const String name = 'EnrolmentInfo';
}

class EnrolmentInfoDetail extends _i1.PageRouteInfo<EnrolmentInfoDetailArgs> {
  EnrolmentInfoDetail({required dynamic groupId})
      : super(name,
            path: '/enrolmentInfoDetail',
            args: EnrolmentInfoDetailArgs(groupId: groupId));

  static const String name = 'EnrolmentInfoDetail';
}

class EnrolmentInfoDetailArgs {
  const EnrolmentInfoDetailArgs({required this.groupId});

  final dynamic groupId;
}

class Inbox extends _i1.PageRouteInfo {
  const Inbox() : super(name, path: '/inbox');

  static const String name = 'Inbox';
}

class Invite extends _i1.PageRouteInfo {
  const Invite() : super(name, path: '/invite');

  static const String name = 'Invite';
}

class AirtimeTransaction extends _i1.PageRouteInfo<AirtimeTransactionArgs> {
  AirtimeTransaction({required dynamic data})
      : super(name,
            path: '/airtimeTransaction',
            args: AirtimeTransactionArgs(data: data));

  static const String name = 'AirtimeTransaction';
}

class AirtimeTransactionArgs {
  const AirtimeTransactionArgs({required this.data});

  final dynamic data;
}

class AirtimeBillDetail extends _i1.PageRouteInfo<AirtimeBillDetailArgs> {
  AirtimeBillDetail({required dynamic data})
      : super(name,
            path: '/airtimeBillDetail',
            args: AirtimeBillDetailArgs(data: data));

  static const String name = 'AirtimeBillDetail';
}

class AirtimeBillDetailArgs {
  const AirtimeBillDetailArgs({required this.data});

  final dynamic data;
}

class AirtimeSelection extends _i1.PageRouteInfo {
  const AirtimeSelection() : super(name, path: '/airtimeSelection');

  static const String name = 'AirtimeSelection';
}

class BillTransaction extends _i1.PageRouteInfo<BillTransactionArgs> {
  BillTransaction({required dynamic data})
      : super(name,
            path: '/billTransaction', args: BillTransactionArgs(data: data));

  static const String name = 'BillTransaction';
}

class BillTransactionArgs {
  const BillTransactionArgs({required this.data});

  final dynamic data;
}

class BillDetail extends _i1.PageRouteInfo<BillDetailArgs> {
  BillDetail({required dynamic data})
      : super(name, path: '/billDetail', args: BillDetailArgs(data: data));

  static const String name = 'BillDetail';
}

class BillDetailArgs {
  const BillDetailArgs({required this.data});

  final dynamic data;
}

class BillSelection extends _i1.PageRouteInfo {
  const BillSelection() : super(name, path: '/billSelection');

  static const String name = 'BillSelection';
}

class MerchantList extends _i1.PageRouteInfo<MerchantListArgs> {
  MerchantList({required dynamic merchantType})
      : super(name,
            path: '/merchantList',
            args: MerchantListArgs(merchantType: merchantType));

  static const String name = 'MerchantList';
}

class MerchantListArgs {
  const MerchantListArgs({required this.merchantType});

  final dynamic merchantType;
}

class ChatHome extends _i1.PageRouteInfo {
  const ChatHome() : super(name, path: '/chatHome');

  static const String name = 'ChatHome';
}

class TermsAndCondition extends _i1.PageRouteInfo<TermsAndConditionArgs> {
  TermsAndCondition({String? termsAndCondition})
      : super(name,
            path: '/termsAndCondition',
            args: TermsAndConditionArgs(termsAndCondition: termsAndCondition));

  static const String name = 'TermsAndCondition';
}

class TermsAndConditionArgs {
  const TermsAndConditionArgs({this.termsAndCondition});

  final String? termsAndCondition;
}

class FpxPaymentOption extends _i1.PageRouteInfo<FpxPaymentOptionArgs> {
  FpxPaymentOption(
      {String? icNo,
      String? docDoc,
      String? docRef,
      String? merchant,
      String? packageCode,
      String? packageDesc,
      String? diCode,
      String? totalAmount,
      String? amountString})
      : super(name,
            path: '/fpxPaymentOption',
            args: FpxPaymentOptionArgs(
                icNo: icNo,
                docDoc: docDoc,
                docRef: docRef,
                merchant: merchant,
                packageCode: packageCode,
                packageDesc: packageDesc,
                diCode: diCode,
                totalAmount: totalAmount,
                amountString: amountString));

  static const String name = 'FpxPaymentOption';
}

class FpxPaymentOptionArgs {
  const FpxPaymentOptionArgs(
      {this.icNo,
      this.docDoc,
      this.docRef,
      this.merchant,
      this.packageCode,
      this.packageDesc,
      this.diCode,
      this.totalAmount,
      this.amountString});

  final String? icNo;

  final String? docDoc;

  final String? docRef;

  final String? merchant;

  final String? packageCode;

  final String? packageDesc;

  final String? diCode;

  final String? totalAmount;

  final String? amountString;
}

class ImageViewer extends _i1.PageRouteInfo<ImageViewerArgs> {
  ImageViewer({String? title, _i2.NetworkImage? image})
      : super(name,
            path: '/imageViewer',
            args: ImageViewerArgs(title: title, image: image));

  static const String name = 'ImageViewer';
}

class ImageViewerArgs {
  const ImageViewerArgs({this.title, this.image});

  final String? title;

  final _i2.NetworkImage? image;
}

class Webview extends _i1.PageRouteInfo<WebviewArgs> {
  Webview({required String? url, String? backType})
      : super(name,
            path: '/webview', args: WebviewArgs(url: url, backType: backType));

  static const String name = 'Webview';
}

class WebviewArgs {
  const WebviewArgs({required this.url, this.backType});

  final String? url;

  final String? backType;
}

class Scan extends _i1.PageRouteInfo<ScanArgs> {
  Scan({dynamic getActiveFeed, dynamic getDiProfile, _i2.Key? key})
      : super(name,
            path: '/scan',
            args: ScanArgs(
                getActiveFeed: getActiveFeed,
                getDiProfile: getDiProfile,
                key: key));

  static const String name = 'Scan';
}

class ScanArgs {
  const ScanArgs({this.getActiveFeed, this.getDiProfile, this.key});

  final dynamic getActiveFeed;

  final dynamic getDiProfile;

  final _i2.Key? key;
}

class ReadMore extends _i1.PageRouteInfo<ReadMoreArgs> {
  ReadMore({String? packageDesc})
      : super(name,
            path: '/readMore', args: ReadMoreArgs(packageDesc: packageDesc));

  static const String name = 'ReadMore';
}

class ReadMoreArgs {
  const ReadMoreArgs({this.packageDesc});

  final String? packageDesc;
}

class ViewPdf extends _i1.PageRouteInfo<ViewPdfArgs> {
  ViewPdf({required String? title, required String? pdfLink})
      : super(name,
            path: '/viewPdf',
            args: ViewPdfArgs(title: title, pdfLink: pdfLink));

  static const String name = 'ViewPdf';
}

class ViewPdfArgs {
  const ViewPdfArgs({required this.title, required this.pdfLink});

  final String? title;

  final String? pdfLink;
}

class ComingSoon extends _i1.PageRouteInfo {
  const ComingSoon() : super(name, path: '/comingSoon');

  static const String name = 'ComingSoon';
}

class CheckInSlip extends _i1.PageRouteInfo {
  const CheckInSlip() : super(name, path: '/checkInSlip');

  static const String name = 'CheckInSlip';
}

class Multilevel extends _i1.PageRouteInfo<MultilevelArgs> {
  Multilevel({dynamic feed, String? appVersion})
      : super(name,
            path: '/multilevel',
            args: MultilevelArgs(feed: feed, appVersion: appVersion));

  static const String name = 'Multilevel';
}

class MultilevelArgs {
  const MultilevelArgs({this.feed, this.appVersion});

  final dynamic feed;

  final String? appVersion;
}

class MerchantProfile extends _i1.PageRouteInfo {
  const MerchantProfile() : super(name, path: '/merchantProfile');

  static const String name = 'MerchantProfile';
}
