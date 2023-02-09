// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i42;
import 'package:camera/camera.dart' as _i44;
import 'package:flutter/material.dart' as _i43;

import 'coming_soon/coming_soon.dart' as _i27;
import 'common_library/utils/image_viewer.dart' as _i25;
import 'pages/brief/brief_list.dart' as _i40;
import 'pages/brief/brief_video.dart' as _i41;
import 'pages/chat/chat.dart' as _i24;
import 'pages/di_enroll/di_enrollment.dart' as _i7;
import 'pages/elearning/elearning.dart' as _i29;
import 'pages/emergency/emergency.dart' as _i12;
import 'pages/enroll/enroll.dart' as _i6;
import 'pages/epandu/epandu.dart' as _i10;
import 'pages/etesting/etesting.dart' as _i11;
import 'pages/expenses/create_fuel.dart' as _i32;
import 'pages/expenses/create_service_car.dart' as _i33;
import 'pages/expenses/edit_exp_fuel.dart' as _i39;
import 'pages/expenses/exp_fuel_list.dart' as _i38;
import 'pages/expenses/fuel_map.dart' as _i37;
import 'pages/favourite/create_favourite.dart' as _i30;
import 'pages/favourite/edit_favourite_place.dart' as _i36;
import 'pages/favourite/favourite_map.dart' as _i31;
import 'pages/favourite/favourite_place_list.dart' as _i34;
import 'pages/favourite/photo_view.dart' as _i35;
import 'pages/forgot_password/forgot_password.dart' as _i2;
import 'pages/home/home.dart' as _i5;
import 'pages/home/menu_page.dart' as _i28;
import 'pages/inbox/inbox.dart' as _i16;
import 'pages/invite/invite.dart' as _i17;
import 'pages/kpp/kpp.dart' as _i8;
import 'pages/login/login.dart' as _i1;
import 'pages/pay/pay.dart' as _i14;
import 'pages/payment/airtime_bill_detail.dart' as _i19;
import 'pages/payment/airtime_selection.dart' as _i20;
import 'pages/payment/airtime_transaction.dart' as _i18;
import 'pages/payment/bill_detail.dart' as _i22;
import 'pages/payment/bill_selection.dart' as _i23;
import 'pages/payment/bill_transaction.dart' as _i21;
import 'pages/pdf/view_pdf.dart' as _i26;
import 'pages/profile/profile.dart' as _i13;
import 'pages/promotions/promotions.dart' as _i15;
import 'pages/register/register.dart' as _i4;
import 'pages/settings/settings.dart' as _i3;
import 'pages/vclub/value_club.dart' as _i9;

class AppRouter extends _i42.RootStackRouter {
  AppRouter([_i43.GlobalKey<_i43.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i42.PageFactory> pagesMap = {
    Authentication.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.Authentication(),
      );
    },
    ClientAccount.name: (routeData) {
      final args = routeData.argsAs<ClientAccountArgs>(
          orElse: () => const ClientAccountArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.ClientAccount(data: args.data),
      );
    },
    Login.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.Login(),
      );
    },
    ForgotPassword.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.ForgotPassword(),
      );
    },
    ChangePassword.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.ChangePassword(),
      );
    },
    RegisterMobile.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.RegisterMobile(),
      );
    },
    RegisterVerification.name: (routeData) {
      final args = routeData.argsAs<RegisterVerificationArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.RegisterVerification(args.data),
      );
    },
    RegisterForm.name: (routeData) {
      final args = routeData.argsAs<RegisterFormArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.RegisterForm(args.data),
      );
    },
    Home.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.Home(),
      );
    },
    QueueNumber.name: (routeData) {
      final args = routeData.argsAs<QueueNumberArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.QueueNumber(data: args.data),
      );
    },
    Enrollment.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.Enrollment(),
      );
    },
    DiEnrollment.name: (routeData) {
      final args = routeData.argsAs<DiEnrollmentArgs>(
          orElse: () => const DiEnrollmentArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.DiEnrollment(packageCodeJson: args.packageCodeJson),
      );
    },
    EnrollConfirmation.name: (routeData) {
      final args = routeData.argsAs<EnrollConfirmationArgs>(
          orElse: () => const EnrollConfirmationArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.EnrollConfirmation(
          banner: args.banner,
          packageName: args.packageName,
          packageCode: args.packageCode,
          packageDesc: args.packageDesc,
          diCode: args.diCode,
          termsAndCondition: args.termsAndCondition,
          groupIdGrouping: args.groupIdGrouping,
          amount: args.amount,
        ),
      );
    },
    OrderList.name: (routeData) {
      final args =
          routeData.argsAs<OrderListArgs>(orElse: () => const OrderListArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.OrderList(
          icNo: args.icNo,
          packageCode: args.packageCode,
          diCode: args.diCode,
        ),
      );
    },
    BankList.name: (routeData) {
      final args =
          routeData.argsAs<BankListArgs>(orElse: () => const BankListArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.BankList(
          icNo: args.icNo,
          docDoc: args.docDoc,
          docRef: args.docRef,
          packageCode: args.packageCode,
          diCode: args.diCode,
          amountString: args.amountString,
        ),
      );
    },
    PaymentStatus.name: (routeData) {
      final args = routeData.argsAs<PaymentStatusArgs>(
          orElse: () => const PaymentStatusArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.PaymentStatus(icNo: args.icNo),
      );
    },
    KppCategory.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.KppCategory(),
      );
    },
    KppResult.name: (routeData) {
      final args = routeData.argsAs<KppResultArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.KppResult(args.data),
      );
    },
    KppExam.name: (routeData) {
      final args = routeData.argsAs<KppExamArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.KppExam(
          groupId: args.groupId,
          paperNo: args.paperNo,
        ),
      );
    },
    KppModule.name: (routeData) {
      final args = routeData.argsAs<KppModuleArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.KppModule(args.data),
      );
    },
    PinActivation.name: (routeData) {
      final args = routeData.argsAs<PinActivationArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.PinActivation(args.data),
      );
    },
    ValueClub.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.ValueClub(),
      );
    },
    Product.name: (routeData) {
      final args =
          routeData.argsAs<ProductArgs>(orElse: () => const ProductArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.Product(
          stkCode: args.stkCode,
          stkDesc1: args.stkDesc1,
          stkDesc2: args.stkDesc2,
          qty: args.qty,
          price: args.price,
          image: args.image,
          uom: args.uom,
          products: args.products,
        ),
      );
    },
    ProductList.name: (routeData) {
      final args = routeData.argsAs<ProductListArgs>(
          orElse: () => const ProductListArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.ProductList(
          stkCat: args.stkCat,
          keywordSearch: args.keywordSearch,
        ),
      );
    },
    Cart.name: (routeData) {
      final args = routeData.argsAs<CartArgs>(orElse: () => const CartArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.Cart(
          itemName: args.itemName,
          dbcode: args.dbcode,
        ),
      );
    },
    CartItemEdit.name: (routeData) {
      final args = routeData.argsAs<CartItemEditArgs>(
          orElse: () => const CartItemEditArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.CartItemEdit(
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
      );
    },
    Checkout.name: (routeData) {
      final args =
          routeData.argsAs<CheckoutArgs>(orElse: () => const CheckoutArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.Checkout(
          slsDetailData: args.slsDetailData,
          itemName: args.itemName,
          dbcode: args.dbcode,
          date: args.date,
          docDoc: args.docDoc,
          docRef: args.docRef,
          qty: args.qty,
          totalAmount: args.totalAmount,
        ),
      );
    },
    EpanduCategory.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.EpanduCategory(),
      );
    },
    EtestingCategory.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.EtestingCategory(),
      );
    },
    EmergencyDirectory.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.EmergencyDirectory(),
      );
    },
    DirectoryList.name: (routeData) {
      final args = routeData.argsAs<DirectoryListArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.DirectoryList(args.directoryType),
      );
    },
    DirectoryDetail.name: (routeData) {
      final args = routeData.argsAs<DirectoryDetailArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.DirectoryDetail(args.snapshot),
      );
    },
    SelectInstitute.name: (routeData) {
      final args = routeData.argsAs<SelectInstituteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.SelectInstitute(args.data),
      );
    },
    SelectClass.name: (routeData) {
      final args = routeData.argsAs<SelectClassArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.SelectClass(args.data),
      );
    },
    SelectDrivingInstitute.name: (routeData) {
      final args = routeData.argsAs<SelectDrivingInstituteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.SelectDrivingInstitute(args.diList),
      );
    },
    TakeProfilePicture.name: (routeData) {
      final args = routeData.argsAs<TakeProfilePictureArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.TakeProfilePicture(args.camera),
      );
    },
    Booking.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.Booking(),
      );
    },
    AddBooking.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.AddBooking(),
      );
    },
    Records.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.Records(),
      );
    },
    Pay.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.Pay(),
      );
    },
    PurchaseOrderList.name: (routeData) {
      final args = routeData.argsAs<PurchaseOrderListArgs>(
          orElse: () => const PurchaseOrderListArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.PurchaseOrderList(
          icNo: args.icNo,
          packageCode: args.packageCode,
          diCode: args.diCode,
        ),
      );
    },
    PaymentHistory.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.PaymentHistory(),
      );
    },
    PaymentHistoryDetail.name: (routeData) {
      final args = routeData.argsAs<PaymentHistoryDetailArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.PaymentHistoryDetail(args.recpNo),
      );
    },
    RequestPickup.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.RequestPickup(),
      );
    },
    RegisteredCourse.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.RegisteredCourse(),
      );
    },
    RegisteredCourseDetail.name: (routeData) {
      final args = routeData.argsAs<RegisteredCourseDetailArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.RegisteredCourseDetail(args.groupId),
      );
    },
    AttendanceRecord.name: (routeData) {
      final args = routeData.argsAs<AttendanceRecordArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.AttendanceRecord(
          attendanceData: args.attendanceData,
          isLoading: args.isLoading,
        ),
      );
    },
    AttendanceTab.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.AttendanceTab(),
      );
    },
    Promotions.name: (routeData) {
      final args = routeData.argsAs<PromotionsArgs>(
          orElse: () => const PromotionsArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.Promotions(feed: args.feed),
      );
    },
    Profile.name: (routeData) {
      final args =
          routeData.argsAs<ProfileArgs>(orElse: () => const ProfileArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.Profile(
          userProfile: args.userProfile,
          enrollData: args.enrollData,
          isLoading: args.isLoading,
        ),
      );
    },
    ProfileTab.name: (routeData) {
      final args = routeData.argsAs<ProfileTabArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.ProfileTab(args.positionStream),
      );
    },
    UpdateProfile.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.UpdateProfile(),
      );
    },
    RegisterUserToDi.name: (routeData) {
      final args = routeData.argsAs<RegisterUserToDiArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.RegisterUserToDi(args.barcode),
      );
    },
    IdentityBarcode.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.IdentityBarcode(),
      );
    },
    EnrolmentInfo.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.EnrolmentInfo(),
      );
    },
    EnrolmentInfoDetail.name: (routeData) {
      final args = routeData.argsAs<EnrolmentInfoDetailArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.EnrolmentInfoDetail(args.groupId),
      );
    },
    Inbox.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.Inbox(),
      );
    },
    Invite.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.Invite(),
      );
    },
    AirtimeTransaction.name: (routeData) {
      final args = routeData.argsAs<AirtimeTransactionArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i18.AirtimeTransaction(args.data),
      );
    },
    AirtimeBillDetail.name: (routeData) {
      final args = routeData.argsAs<AirtimeBillDetailArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i19.AirtimeBillDetail(args.data),
      );
    },
    AirtimeSelection.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i20.AirtimeSelection(),
      );
    },
    BillTransaction.name: (routeData) {
      final args = routeData.argsAs<BillTransactionArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i21.BillTransaction(args.data),
      );
    },
    BillDetail.name: (routeData) {
      final args = routeData.argsAs<BillDetailArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i22.BillDetail(args.data),
      );
    },
    BillSelection.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i23.BillSelection(),
      );
    },
    MerchantList.name: (routeData) {
      final args = routeData.argsAs<MerchantListArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.MerchantList(args.merchantType),
      );
    },
    ChatHome.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i24.ChatHome(),
      );
    },
    TermsAndCondition.name: (routeData) {
      final args = routeData.argsAs<TermsAndConditionArgs>(
          orElse: () => const TermsAndConditionArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.TermsAndCondition(termsAndCondition: args.termsAndCondition),
      );
    },
    FpxPaymentOption.name: (routeData) {
      final args = routeData.argsAs<FpxPaymentOptionArgs>(
          orElse: () => const FpxPaymentOptionArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.FpxPaymentOption(
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
      );
    },
    ImageViewer.name: (routeData) {
      final args = routeData.argsAs<ImageViewerArgs>(
          orElse: () => const ImageViewerArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i25.ImageViewer(
          title: args.title,
          image: args.image,
        ),
      );
    },
    Webview.name: (routeData) {
      final args = routeData.argsAs<WebviewArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.Webview(
          url: args.url,
          backType: args.backType,
        ),
      );
    },
    Scan.name: (routeData) {
      final args = routeData.argsAs<ScanArgs>(orElse: () => const ScanArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.Scan(
          getActiveFeed: args.getActiveFeed,
          getDiProfile: args.getDiProfile,
          key: args.key,
        ),
      );
    },
    ReadMore.name: (routeData) {
      final args =
          routeData.argsAs<ReadMoreArgs>(orElse: () => const ReadMoreArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.ReadMore(packageDesc: args.packageDesc),
      );
    },
    ViewPdf.name: (routeData) {
      final args = routeData.argsAs<ViewPdfArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i26.ViewPdf(
          title: args.title,
          pdfLink: args.pdfLink,
        ),
      );
    },
    ComingSoon.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i27.ComingSoon(),
      );
    },
    CheckInSlip.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.CheckInSlip(),
      );
    },
    Multilevel.name: (routeData) {
      final args = routeData.argsAs<MultilevelArgs>(
          orElse: () => const MultilevelArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.Multilevel(
          feed: args.feed,
          appVersion: args.appVersion,
        ),
      );
    },
    MerchantProfile.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.MerchantProfile(),
      );
    },
    MenuRoute.name: (routeData) {
      final args =
          routeData.argsAs<MenuRouteArgs>(orElse: () => const MenuRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i28.MenuPage(key: args.key),
      );
    },
    ElearningRoute.name: (routeData) {
      final args = routeData.argsAs<ElearningRouteArgs>(
          orElse: () => const ElearningRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i29.ElearningPage(key: args.key),
      );
    },
    CreateFavouriteRoute.name: (routeData) {
      final args = routeData.argsAs<CreateFavouriteRouteArgs>(
          orElse: () => const CreateFavouriteRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i30.CreateFavouritePage(key: args.key),
      );
    },
    FavourieMapRoute.name: (routeData) {
      final args = routeData.argsAs<FavourieMapRouteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i31.FavourieMapPage(
          key: args.key,
          lat: args.lat,
          lng: args.lng,
        ),
      );
    },
    CreateFuelRoute.name: (routeData) {
      final args = routeData.argsAs<CreateFuelRouteArgs>(
          orElse: () => const CreateFuelRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i32.CreateFuelPage(key: args.key),
      );
    },
    CreateServiceCarRoute.name: (routeData) {
      final args = routeData.argsAs<CreateServiceCarRouteArgs>(
          orElse: () => const CreateServiceCarRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i33.CreateServiceCarPage(key: args.key),
      );
    },
    FavouritePlaceListRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i34.FavouritePlaceListPage(),
      );
    },
    PhotoViewRoute.name: (routeData) {
      final args = routeData.argsAs<PhotoViewRouteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i35.PhotoViewPage(
          key: args.key,
          url: args.url,
          title: args.title,
          initialIndex: args.initialIndex,
          type: args.type,
        ),
      );
    },
    EditFavouritePlaceRoute.name: (routeData) {
      final args = routeData.argsAs<EditFavouritePlaceRouteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i36.EditFavouritePlacePage(
          key: args.key,
          placeId: args.placeId,
          place: args.place,
          images: args.images,
        ),
      );
    },
    FuelMapRoute.name: (routeData) {
      final args = routeData.argsAs<FuelMapRouteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i37.FuelMapPage(
          key: args.key,
          lat: args.lat,
          lng: args.lng,
        ),
      );
    },
    ExpFuelListRoute.name: (routeData) {
      final args = routeData.argsAs<ExpFuelListRouteArgs>(
          orElse: () => const ExpFuelListRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i38.ExpFuelListPage(key: args.key),
      );
    },
    EditExpFuelRoute.name: (routeData) {
      final args = routeData.argsAs<EditExpFuelRouteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i39.EditExpFuelPage(
          key: args.key,
          fuel: args.fuel,
        ),
      );
    },
    PickupHistory.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.PickupHistory(),
      );
    },
    BriefListRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i40.BriefListPage(),
      );
    },
    BriefVideoRoute.name: (routeData) {
      final args = routeData.argsAs<BriefVideoRouteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i41.BriefVideoPage(
          key: args.key,
          fileDetail: args.fileDetail,
        ),
      );
    },
  };

  @override
  List<_i42.RouteConfig> get routes => [
        _i42.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/authentication',
          fullMatch: true,
        ),
        _i42.RouteConfig(
          Authentication.name,
          path: '/authentication',
        ),
        _i42.RouteConfig(
          ClientAccount.name,
          path: '/clientAccount',
        ),
        _i42.RouteConfig(
          Login.name,
          path: '/login',
        ),
        _i42.RouteConfig(
          ForgotPassword.name,
          path: '/forgotPassword',
        ),
        _i42.RouteConfig(
          ChangePassword.name,
          path: '/changePassword',
        ),
        _i42.RouteConfig(
          RegisterMobile.name,
          path: '/registerMobile',
        ),
        _i42.RouteConfig(
          RegisterVerification.name,
          path: '/registerVerification',
        ),
        _i42.RouteConfig(
          RegisterForm.name,
          path: '/registerForm',
        ),
        _i42.RouteConfig(
          Home.name,
          path: '/home',
        ),
        _i42.RouteConfig(
          QueueNumber.name,
          path: '/queueNumber',
        ),
        _i42.RouteConfig(
          Enrollment.name,
          path: '/enrollment',
        ),
        _i42.RouteConfig(
          DiEnrollment.name,
          path: '/diEnrollment',
        ),
        _i42.RouteConfig(
          EnrollConfirmation.name,
          path: '/enrollConfirmation',
        ),
        _i42.RouteConfig(
          OrderList.name,
          path: '/orderList',
        ),
        _i42.RouteConfig(
          BankList.name,
          path: '/bankList',
        ),
        _i42.RouteConfig(
          PaymentStatus.name,
          path: '/paymentStatus',
        ),
        _i42.RouteConfig(
          KppCategory.name,
          path: '/kppCategory',
        ),
        _i42.RouteConfig(
          KppResult.name,
          path: '/kppResult',
        ),
        _i42.RouteConfig(
          KppExam.name,
          path: '/kppExam',
        ),
        _i42.RouteConfig(
          KppModule.name,
          path: '/kppModule',
        ),
        _i42.RouteConfig(
          PinActivation.name,
          path: '/pinActivation',
        ),
        _i42.RouteConfig(
          ValueClub.name,
          path: '/valueClub',
        ),
        _i42.RouteConfig(
          Product.name,
          path: '/product',
        ),
        _i42.RouteConfig(
          ProductList.name,
          path: '/productList',
        ),
        _i42.RouteConfig(
          Cart.name,
          path: '/cart',
        ),
        _i42.RouteConfig(
          CartItemEdit.name,
          path: '/cartItemEdit',
        ),
        _i42.RouteConfig(
          Checkout.name,
          path: '/checkout',
        ),
        _i42.RouteConfig(
          EpanduCategory.name,
          path: '/epanduCategory',
        ),
        _i42.RouteConfig(
          EtestingCategory.name,
          path: '/epanduCategory',
        ),
        _i42.RouteConfig(
          EmergencyDirectory.name,
          path: '/emergencyDirectory',
        ),
        _i42.RouteConfig(
          DirectoryList.name,
          path: '/directoryList',
        ),
        _i42.RouteConfig(
          DirectoryDetail.name,
          path: '/directoryDetail',
        ),
        _i42.RouteConfig(
          SelectInstitute.name,
          path: '/selectInstitute',
        ),
        _i42.RouteConfig(
          SelectClass.name,
          path: '/selectClass',
        ),
        _i42.RouteConfig(
          SelectDrivingInstitute.name,
          path: '/selectDrivingInstitute',
        ),
        _i42.RouteConfig(
          TakeProfilePicture.name,
          path: '/takeProfilePicture',
        ),
        _i42.RouteConfig(
          Booking.name,
          path: '/booking',
        ),
        _i42.RouteConfig(
          AddBooking.name,
          path: '/addBooking',
        ),
        _i42.RouteConfig(
          Records.name,
          path: '/records',
        ),
        _i42.RouteConfig(
          Pay.name,
          path: '/pay',
        ),
        _i42.RouteConfig(
          PurchaseOrderList.name,
          path: '/purchaseOrderList',
        ),
        _i42.RouteConfig(
          PaymentHistory.name,
          path: '/paymentHistory',
        ),
        _i42.RouteConfig(
          PaymentHistoryDetail.name,
          path: '/paymentHistoryDetail',
        ),
        _i42.RouteConfig(
          RequestPickup.name,
          path: '/requestPickup',
        ),
        _i42.RouteConfig(
          RegisteredCourse.name,
          path: '/registeredCourse',
        ),
        _i42.RouteConfig(
          RegisteredCourseDetail.name,
          path: '/registeredCourseDetail',
        ),
        _i42.RouteConfig(
          AttendanceRecord.name,
          path: '/attendanceRecord',
        ),
        _i42.RouteConfig(
          AttendanceTab.name,
          path: '/attendanceTab',
        ),
        _i42.RouteConfig(
          Promotions.name,
          path: '/promotions',
        ),
        _i42.RouteConfig(
          Profile.name,
          path: '/profile',
        ),
        _i42.RouteConfig(
          ProfileTab.name,
          path: '/profileTab',
        ),
        _i42.RouteConfig(
          UpdateProfile.name,
          path: '/updateProfile',
        ),
        _i42.RouteConfig(
          RegisterUserToDi.name,
          path: 'registerUserToDi',
        ),
        _i42.RouteConfig(
          IdentityBarcode.name,
          path: '/identityBarcode',
        ),
        _i42.RouteConfig(
          EnrolmentInfo.name,
          path: '/enrolmentInfo',
        ),
        _i42.RouteConfig(
          EnrolmentInfoDetail.name,
          path: '/enrolmentInfoDetail',
        ),
        _i42.RouteConfig(
          Inbox.name,
          path: '/inbox',
        ),
        _i42.RouteConfig(
          Invite.name,
          path: '/invite',
        ),
        _i42.RouteConfig(
          AirtimeTransaction.name,
          path: '/airtimeTransaction',
        ),
        _i42.RouteConfig(
          AirtimeBillDetail.name,
          path: '/airtimeBillDetail',
        ),
        _i42.RouteConfig(
          AirtimeSelection.name,
          path: '/airtimeSelection',
        ),
        _i42.RouteConfig(
          BillTransaction.name,
          path: '/billTransaction',
        ),
        _i42.RouteConfig(
          BillDetail.name,
          path: '/billDetail',
        ),
        _i42.RouteConfig(
          BillSelection.name,
          path: '/billSelection',
        ),
        _i42.RouteConfig(
          MerchantList.name,
          path: '/merchantList',
        ),
        _i42.RouteConfig(
          ChatHome.name,
          path: '/chatHome',
        ),
        _i42.RouteConfig(
          TermsAndCondition.name,
          path: '/termsAndCondition',
        ),
        _i42.RouteConfig(
          FpxPaymentOption.name,
          path: '/fpxPaymentOption',
        ),
        _i42.RouteConfig(
          ImageViewer.name,
          path: '/imageViewer',
        ),
        _i42.RouteConfig(
          Webview.name,
          path: '/webview',
        ),
        _i42.RouteConfig(
          Scan.name,
          path: '/scan',
        ),
        _i42.RouteConfig(
          ReadMore.name,
          path: '/readMore',
        ),
        _i42.RouteConfig(
          ViewPdf.name,
          path: '/viewPdf',
        ),
        _i42.RouteConfig(
          ComingSoon.name,
          path: '/comingSoon',
        ),
        _i42.RouteConfig(
          CheckInSlip.name,
          path: '/checkInSlip',
        ),
        _i42.RouteConfig(
          Multilevel.name,
          path: '/multilevel',
        ),
        _i42.RouteConfig(
          MerchantProfile.name,
          path: '/merchantProfile',
        ),
        _i42.RouteConfig(
          MenuRoute.name,
          path: '/menu-page',
        ),
        _i42.RouteConfig(
          ElearningRoute.name,
          path: '/elearning-page',
        ),
        _i42.RouteConfig(
          CreateFavouriteRoute.name,
          path: '/create-favourite-page',
        ),
        _i42.RouteConfig(
          FavourieMapRoute.name,
          path: '/favourie-map-page',
        ),
        _i42.RouteConfig(
          CreateFuelRoute.name,
          path: '/create-fuel-page',
        ),
        _i42.RouteConfig(
          CreateServiceCarRoute.name,
          path: '/create-service-car-page',
        ),
        _i42.RouteConfig(
          FavouritePlaceListRoute.name,
          path: '/favourite-place-list-page',
        ),
        _i42.RouteConfig(
          PhotoViewRoute.name,
          path: '/photo-view-page',
        ),
        _i42.RouteConfig(
          EditFavouritePlaceRoute.name,
          path: '/edit-favourite-place-page',
        ),
        _i42.RouteConfig(
          FuelMapRoute.name,
          path: '/fuel-map-page',
        ),
        _i42.RouteConfig(
          ExpFuelListRoute.name,
          path: '/exp-fuel-list-page',
        ),
        _i42.RouteConfig(
          EditExpFuelRoute.name,
          path: '/edit-exp-fuel-page',
        ),
        _i42.RouteConfig(
          PickupHistory.name,
          path: '/pickup-history',
        ),
        _i42.RouteConfig(
          BriefListRoute.name,
          path: '/brief-list-page',
        ),
        _i42.RouteConfig(
          BriefVideoRoute.name,
          path: '/brief-video-page',
        ),
      ];
}

/// generated route for
/// [_i1.Authentication]
class Authentication extends _i42.PageRouteInfo<void> {
  const Authentication()
      : super(
          Authentication.name,
          path: '/authentication',
        );

  static const String name = 'Authentication';
}

/// generated route for
/// [_i1.ClientAccount]
class ClientAccount extends _i42.PageRouteInfo<ClientAccountArgs> {
  ClientAccount({dynamic data})
      : super(
          ClientAccount.name,
          path: '/clientAccount',
          args: ClientAccountArgs(data: data),
        );

  static const String name = 'ClientAccount';
}

class ClientAccountArgs {
  const ClientAccountArgs({this.data});

  final dynamic data;

  @override
  String toString() {
    return 'ClientAccountArgs{data: $data}';
  }
}

/// generated route for
/// [_i1.Login]
class Login extends _i42.PageRouteInfo<void> {
  const Login()
      : super(
          Login.name,
          path: '/login',
        );

  static const String name = 'Login';
}

/// generated route for
/// [_i2.ForgotPassword]
class ForgotPassword extends _i42.PageRouteInfo<void> {
  const ForgotPassword()
      : super(
          ForgotPassword.name,
          path: '/forgotPassword',
        );

  static const String name = 'ForgotPassword';
}

/// generated route for
/// [_i3.ChangePassword]
class ChangePassword extends _i42.PageRouteInfo<void> {
  const ChangePassword()
      : super(
          ChangePassword.name,
          path: '/changePassword',
        );

  static const String name = 'ChangePassword';
}

/// generated route for
/// [_i4.RegisterMobile]
class RegisterMobile extends _i42.PageRouteInfo<void> {
  const RegisterMobile()
      : super(
          RegisterMobile.name,
          path: '/registerMobile',
        );

  static const String name = 'RegisterMobile';
}

/// generated route for
/// [_i4.RegisterVerification]
class RegisterVerification
    extends _i42.PageRouteInfo<RegisterVerificationArgs> {
  RegisterVerification({required dynamic data})
      : super(
          RegisterVerification.name,
          path: '/registerVerification',
          args: RegisterVerificationArgs(data: data),
        );

  static const String name = 'RegisterVerification';
}

class RegisterVerificationArgs {
  const RegisterVerificationArgs({required this.data});

  final dynamic data;

  @override
  String toString() {
    return 'RegisterVerificationArgs{data: $data}';
  }
}

/// generated route for
/// [_i4.RegisterForm]
class RegisterForm extends _i42.PageRouteInfo<RegisterFormArgs> {
  RegisterForm({required dynamic data})
      : super(
          RegisterForm.name,
          path: '/registerForm',
          args: RegisterFormArgs(data: data),
        );

  static const String name = 'RegisterForm';
}

class RegisterFormArgs {
  const RegisterFormArgs({required this.data});

  final dynamic data;

  @override
  String toString() {
    return 'RegisterFormArgs{data: $data}';
  }
}

/// generated route for
/// [_i5.Home]
class Home extends _i42.PageRouteInfo<void> {
  const Home()
      : super(
          Home.name,
          path: '/home',
        );

  static const String name = 'Home';
}

/// generated route for
/// [_i5.QueueNumber]
class QueueNumber extends _i42.PageRouteInfo<QueueNumberArgs> {
  QueueNumber({required dynamic data})
      : super(
          QueueNumber.name,
          path: '/queueNumber',
          args: QueueNumberArgs(data: data),
        );

  static const String name = 'QueueNumber';
}

class QueueNumberArgs {
  const QueueNumberArgs({required this.data});

  final dynamic data;

  @override
  String toString() {
    return 'QueueNumberArgs{data: $data}';
  }
}

/// generated route for
/// [_i6.Enrollment]
class Enrollment extends _i42.PageRouteInfo<void> {
  const Enrollment()
      : super(
          Enrollment.name,
          path: '/enrollment',
        );

  static const String name = 'Enrollment';
}

/// generated route for
/// [_i7.DiEnrollment]
class DiEnrollment extends _i42.PageRouteInfo<DiEnrollmentArgs> {
  DiEnrollment({String? packageCodeJson})
      : super(
          DiEnrollment.name,
          path: '/diEnrollment',
          args: DiEnrollmentArgs(packageCodeJson: packageCodeJson),
        );

  static const String name = 'DiEnrollment';
}

class DiEnrollmentArgs {
  const DiEnrollmentArgs({this.packageCodeJson});

  final String? packageCodeJson;

  @override
  String toString() {
    return 'DiEnrollmentArgs{packageCodeJson: $packageCodeJson}';
  }
}

/// generated route for
/// [_i7.EnrollConfirmation]
class EnrollConfirmation extends _i42.PageRouteInfo<EnrollConfirmationArgs> {
  EnrollConfirmation({
    String? banner,
    String? packageName,
    String? packageCode,
    String? packageDesc,
    String? diCode,
    String? termsAndCondition,
    String? groupIdGrouping,
    String? amount,
  }) : super(
          EnrollConfirmation.name,
          path: '/enrollConfirmation',
          args: EnrollConfirmationArgs(
            banner: banner,
            packageName: packageName,
            packageCode: packageCode,
            packageDesc: packageDesc,
            diCode: diCode,
            termsAndCondition: termsAndCondition,
            groupIdGrouping: groupIdGrouping,
            amount: amount,
          ),
        );

  static const String name = 'EnrollConfirmation';
}

class EnrollConfirmationArgs {
  const EnrollConfirmationArgs({
    this.banner,
    this.packageName,
    this.packageCode,
    this.packageDesc,
    this.diCode,
    this.termsAndCondition,
    this.groupIdGrouping,
    this.amount,
  });

  final String? banner;

  final String? packageName;

  final String? packageCode;

  final String? packageDesc;

  final String? diCode;

  final String? termsAndCondition;

  final String? groupIdGrouping;

  final String? amount;

  @override
  String toString() {
    return 'EnrollConfirmationArgs{banner: $banner, packageName: $packageName, packageCode: $packageCode, packageDesc: $packageDesc, diCode: $diCode, termsAndCondition: $termsAndCondition, groupIdGrouping: $groupIdGrouping, amount: $amount}';
  }
}

/// generated route for
/// [_i7.OrderList]
class OrderList extends _i42.PageRouteInfo<OrderListArgs> {
  OrderList({
    String? icNo,
    String? packageCode,
    String? diCode,
  }) : super(
          OrderList.name,
          path: '/orderList',
          args: OrderListArgs(
            icNo: icNo,
            packageCode: packageCode,
            diCode: diCode,
          ),
        );

  static const String name = 'OrderList';
}

class OrderListArgs {
  const OrderListArgs({
    this.icNo,
    this.packageCode,
    this.diCode,
  });

  final String? icNo;

  final String? packageCode;

  final String? diCode;

  @override
  String toString() {
    return 'OrderListArgs{icNo: $icNo, packageCode: $packageCode, diCode: $diCode}';
  }
}

/// generated route for
/// [_i7.BankList]
class BankList extends _i42.PageRouteInfo<BankListArgs> {
  BankList({
    String? icNo,
    String? docDoc,
    String? docRef,
    String? packageCode,
    String? diCode,
    String? amountString,
  }) : super(
          BankList.name,
          path: '/bankList',
          args: BankListArgs(
            icNo: icNo,
            docDoc: docDoc,
            docRef: docRef,
            packageCode: packageCode,
            diCode: diCode,
            amountString: amountString,
          ),
        );

  static const String name = 'BankList';
}

class BankListArgs {
  const BankListArgs({
    this.icNo,
    this.docDoc,
    this.docRef,
    this.packageCode,
    this.diCode,
    this.amountString,
  });

  final String? icNo;

  final String? docDoc;

  final String? docRef;

  final String? packageCode;

  final String? diCode;

  final String? amountString;

  @override
  String toString() {
    return 'BankListArgs{icNo: $icNo, docDoc: $docDoc, docRef: $docRef, packageCode: $packageCode, diCode: $diCode, amountString: $amountString}';
  }
}

/// generated route for
/// [_i7.PaymentStatus]
class PaymentStatus extends _i42.PageRouteInfo<PaymentStatusArgs> {
  PaymentStatus({String? icNo})
      : super(
          PaymentStatus.name,
          path: '/paymentStatus',
          args: PaymentStatusArgs(icNo: icNo),
        );

  static const String name = 'PaymentStatus';
}

class PaymentStatusArgs {
  const PaymentStatusArgs({this.icNo});

  final String? icNo;

  @override
  String toString() {
    return 'PaymentStatusArgs{icNo: $icNo}';
  }
}

/// generated route for
/// [_i8.KppCategory]
class KppCategory extends _i42.PageRouteInfo<void> {
  const KppCategory()
      : super(
          KppCategory.name,
          path: '/kppCategory',
        );

  static const String name = 'KppCategory';
}

/// generated route for
/// [_i8.KppResult]
class KppResult extends _i42.PageRouteInfo<KppResultArgs> {
  KppResult({required dynamic data})
      : super(
          KppResult.name,
          path: '/kppResult',
          args: KppResultArgs(data: data),
        );

  static const String name = 'KppResult';
}

class KppResultArgs {
  const KppResultArgs({required this.data});

  final dynamic data;

  @override
  String toString() {
    return 'KppResultArgs{data: $data}';
  }
}

/// generated route for
/// [_i8.KppExam]
class KppExam extends _i42.PageRouteInfo<KppExamArgs> {
  KppExam({
    required String? groupId,
    required String? paperNo,
  }) : super(
          KppExam.name,
          path: '/kppExam',
          args: KppExamArgs(
            groupId: groupId,
            paperNo: paperNo,
          ),
        );

  static const String name = 'KppExam';
}

class KppExamArgs {
  const KppExamArgs({
    required this.groupId,
    required this.paperNo,
  });

  final String? groupId;

  final String? paperNo;

  @override
  String toString() {
    return 'KppExamArgs{groupId: $groupId, paperNo: $paperNo}';
  }
}

/// generated route for
/// [_i8.KppModule]
class KppModule extends _i42.PageRouteInfo<KppModuleArgs> {
  KppModule({required dynamic data})
      : super(
          KppModule.name,
          path: '/kppModule',
          args: KppModuleArgs(data: data),
        );

  static const String name = 'KppModule';
}

class KppModuleArgs {
  const KppModuleArgs({required this.data});

  final dynamic data;

  @override
  String toString() {
    return 'KppModuleArgs{data: $data}';
  }
}

/// generated route for
/// [_i8.PinActivation]
class PinActivation extends _i42.PageRouteInfo<PinActivationArgs> {
  PinActivation({required String data})
      : super(
          PinActivation.name,
          path: '/pinActivation',
          args: PinActivationArgs(data: data),
        );

  static const String name = 'PinActivation';
}

class PinActivationArgs {
  const PinActivationArgs({required this.data});

  final String data;

  @override
  String toString() {
    return 'PinActivationArgs{data: $data}';
  }
}

/// generated route for
/// [_i9.ValueClub]
class ValueClub extends _i42.PageRouteInfo<void> {
  const ValueClub()
      : super(
          ValueClub.name,
          path: '/valueClub',
        );

  static const String name = 'ValueClub';
}

/// generated route for
/// [_i9.Product]
class Product extends _i42.PageRouteInfo<ProductArgs> {
  Product({
    String? stkCode,
    String? stkDesc1,
    String? stkDesc2,
    String? qty,
    String? price,
    String? image,
    String? uom,
    dynamic products,
  }) : super(
          Product.name,
          path: '/product',
          args: ProductArgs(
            stkCode: stkCode,
            stkDesc1: stkDesc1,
            stkDesc2: stkDesc2,
            qty: qty,
            price: price,
            image: image,
            uom: uom,
            products: products,
          ),
        );

  static const String name = 'Product';
}

class ProductArgs {
  const ProductArgs({
    this.stkCode,
    this.stkDesc1,
    this.stkDesc2,
    this.qty,
    this.price,
    this.image,
    this.uom,
    this.products,
  });

  final String? stkCode;

  final String? stkDesc1;

  final String? stkDesc2;

  final String? qty;

  final String? price;

  final String? image;

  final String? uom;

  final dynamic products;

  @override
  String toString() {
    return 'ProductArgs{stkCode: $stkCode, stkDesc1: $stkDesc1, stkDesc2: $stkDesc2, qty: $qty, price: $price, image: $image, uom: $uom, products: $products}';
  }
}

/// generated route for
/// [_i9.ProductList]
class ProductList extends _i42.PageRouteInfo<ProductListArgs> {
  ProductList({
    String? stkCat,
    String? keywordSearch,
  }) : super(
          ProductList.name,
          path: '/productList',
          args: ProductListArgs(
            stkCat: stkCat,
            keywordSearch: keywordSearch,
          ),
        );

  static const String name = 'ProductList';
}

class ProductListArgs {
  const ProductListArgs({
    this.stkCat,
    this.keywordSearch,
  });

  final String? stkCat;

  final String? keywordSearch;

  @override
  String toString() {
    return 'ProductListArgs{stkCat: $stkCat, keywordSearch: $keywordSearch}';
  }
}

/// generated route for
/// [_i9.Cart]
class Cart extends _i42.PageRouteInfo<CartArgs> {
  Cart({
    String? itemName,
    String? dbcode,
  }) : super(
          Cart.name,
          path: '/cart',
          args: CartArgs(
            itemName: itemName,
            dbcode: dbcode,
          ),
        );

  static const String name = 'Cart';
}

class CartArgs {
  const CartArgs({
    this.itemName,
    this.dbcode,
  });

  final String? itemName;

  final String? dbcode;

  @override
  String toString() {
    return 'CartArgs{itemName: $itemName, dbcode: $dbcode}';
  }
}

/// generated route for
/// [_i9.CartItemEdit]
class CartItemEdit extends _i42.PageRouteInfo<CartItemEditArgs> {
  CartItemEdit({
    String? stkCode,
    String? stkDesc1,
    String? stkDesc2,
    String? qty,
    String? price,
    String? discRate,
    String? isOfferedItem,
    String? scheduledDeliveryDate,
    String? uom,
    String? batchNo,
    String? slsKey,
  }) : super(
          CartItemEdit.name,
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
            slsKey: slsKey,
          ),
        );

  static const String name = 'CartItemEdit';
}

class CartItemEditArgs {
  const CartItemEditArgs({
    this.stkCode,
    this.stkDesc1,
    this.stkDesc2,
    this.qty,
    this.price,
    this.discRate,
    this.isOfferedItem,
    this.scheduledDeliveryDate,
    this.uom,
    this.batchNo,
    this.slsKey,
  });

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

  @override
  String toString() {
    return 'CartItemEditArgs{stkCode: $stkCode, stkDesc1: $stkDesc1, stkDesc2: $stkDesc2, qty: $qty, price: $price, discRate: $discRate, isOfferedItem: $isOfferedItem, scheduledDeliveryDate: $scheduledDeliveryDate, uom: $uom, batchNo: $batchNo, slsKey: $slsKey}';
  }
}

/// generated route for
/// [_i9.Checkout]
class Checkout extends _i42.PageRouteInfo<CheckoutArgs> {
  Checkout({
    dynamic slsDetailData,
    String? itemName,
    String? dbcode,
    String? date,
    String? docDoc,
    String? docRef,
    String? qty,
    String? totalAmount,
  }) : super(
          Checkout.name,
          path: '/checkout',
          args: CheckoutArgs(
            slsDetailData: slsDetailData,
            itemName: itemName,
            dbcode: dbcode,
            date: date,
            docDoc: docDoc,
            docRef: docRef,
            qty: qty,
            totalAmount: totalAmount,
          ),
        );

  static const String name = 'Checkout';
}

class CheckoutArgs {
  const CheckoutArgs({
    this.slsDetailData,
    this.itemName,
    this.dbcode,
    this.date,
    this.docDoc,
    this.docRef,
    this.qty,
    this.totalAmount,
  });

  final dynamic slsDetailData;

  final String? itemName;

  final String? dbcode;

  final String? date;

  final String? docDoc;

  final String? docRef;

  final String? qty;

  final String? totalAmount;

  @override
  String toString() {
    return 'CheckoutArgs{slsDetailData: $slsDetailData, itemName: $itemName, dbcode: $dbcode, date: $date, docDoc: $docDoc, docRef: $docRef, qty: $qty, totalAmount: $totalAmount}';
  }
}

/// generated route for
/// [_i10.EpanduCategory]
class EpanduCategory extends _i42.PageRouteInfo<void> {
  const EpanduCategory()
      : super(
          EpanduCategory.name,
          path: '/epanduCategory',
        );

  static const String name = 'EpanduCategory';
}

/// generated route for
/// [_i11.EtestingCategory]
class EtestingCategory extends _i42.PageRouteInfo<void> {
  const EtestingCategory()
      : super(
          EtestingCategory.name,
          path: '/epanduCategory',
        );

  static const String name = 'EtestingCategory';
}

/// generated route for
/// [_i12.EmergencyDirectory]
class EmergencyDirectory extends _i42.PageRouteInfo<void> {
  const EmergencyDirectory()
      : super(
          EmergencyDirectory.name,
          path: '/emergencyDirectory',
        );

  static const String name = 'EmergencyDirectory';
}

/// generated route for
/// [_i12.DirectoryList]
class DirectoryList extends _i42.PageRouteInfo<DirectoryListArgs> {
  DirectoryList({required dynamic directoryType})
      : super(
          DirectoryList.name,
          path: '/directoryList',
          args: DirectoryListArgs(directoryType: directoryType),
        );

  static const String name = 'DirectoryList';
}

class DirectoryListArgs {
  const DirectoryListArgs({required this.directoryType});

  final dynamic directoryType;

  @override
  String toString() {
    return 'DirectoryListArgs{directoryType: $directoryType}';
  }
}

/// generated route for
/// [_i12.DirectoryDetail]
class DirectoryDetail extends _i42.PageRouteInfo<DirectoryDetailArgs> {
  DirectoryDetail({required dynamic snapshot})
      : super(
          DirectoryDetail.name,
          path: '/directoryDetail',
          args: DirectoryDetailArgs(snapshot: snapshot),
        );

  static const String name = 'DirectoryDetail';
}

class DirectoryDetailArgs {
  const DirectoryDetailArgs({required this.snapshot});

  final dynamic snapshot;

  @override
  String toString() {
    return 'DirectoryDetailArgs{snapshot: $snapshot}';
  }
}

/// generated route for
/// [_i6.SelectInstitute]
class SelectInstitute extends _i42.PageRouteInfo<SelectInstituteArgs> {
  SelectInstitute({required dynamic data})
      : super(
          SelectInstitute.name,
          path: '/selectInstitute',
          args: SelectInstituteArgs(data: data),
        );

  static const String name = 'SelectInstitute';
}

class SelectInstituteArgs {
  const SelectInstituteArgs({required this.data});

  final dynamic data;

  @override
  String toString() {
    return 'SelectInstituteArgs{data: $data}';
  }
}

/// generated route for
/// [_i6.SelectClass]
class SelectClass extends _i42.PageRouteInfo<SelectClassArgs> {
  SelectClass({required dynamic data})
      : super(
          SelectClass.name,
          path: '/selectClass',
          args: SelectClassArgs(data: data),
        );

  static const String name = 'SelectClass';
}

class SelectClassArgs {
  const SelectClassArgs({required this.data});

  final dynamic data;

  @override
  String toString() {
    return 'SelectClassArgs{data: $data}';
  }
}

/// generated route for
/// [_i1.SelectDrivingInstitute]
class SelectDrivingInstitute
    extends _i42.PageRouteInfo<SelectDrivingInstituteArgs> {
  SelectDrivingInstitute({required dynamic diList})
      : super(
          SelectDrivingInstitute.name,
          path: '/selectDrivingInstitute',
          args: SelectDrivingInstituteArgs(diList: diList),
        );

  static const String name = 'SelectDrivingInstitute';
}

class SelectDrivingInstituteArgs {
  const SelectDrivingInstituteArgs({required this.diList});

  final dynamic diList;

  @override
  String toString() {
    return 'SelectDrivingInstituteArgs{diList: $diList}';
  }
}

/// generated route for
/// [_i13.TakeProfilePicture]
class TakeProfilePicture extends _i42.PageRouteInfo<TakeProfilePictureArgs> {
  TakeProfilePicture({required List<_i44.CameraDescription>? camera})
      : super(
          TakeProfilePicture.name,
          path: '/takeProfilePicture',
          args: TakeProfilePictureArgs(camera: camera),
        );

  static const String name = 'TakeProfilePicture';
}

class TakeProfilePictureArgs {
  const TakeProfilePictureArgs({required this.camera});

  final List<_i44.CameraDescription>? camera;

  @override
  String toString() {
    return 'TakeProfilePictureArgs{camera: $camera}';
  }
}

/// generated route for
/// [_i10.Booking]
class Booking extends _i42.PageRouteInfo<void> {
  const Booking()
      : super(
          Booking.name,
          path: '/booking',
        );

  static const String name = 'Booking';
}

/// generated route for
/// [_i10.AddBooking]
class AddBooking extends _i42.PageRouteInfo<void> {
  const AddBooking()
      : super(
          AddBooking.name,
          path: '/addBooking',
        );

  static const String name = 'AddBooking';
}

/// generated route for
/// [_i10.Records]
class Records extends _i42.PageRouteInfo<void> {
  const Records()
      : super(
          Records.name,
          path: '/records',
        );

  static const String name = 'Records';
}

/// generated route for
/// [_i14.Pay]
class Pay extends _i42.PageRouteInfo<void> {
  const Pay()
      : super(
          Pay.name,
          path: '/pay',
        );

  static const String name = 'Pay';
}

/// generated route for
/// [_i14.PurchaseOrderList]
class PurchaseOrderList extends _i42.PageRouteInfo<PurchaseOrderListArgs> {
  PurchaseOrderList({
    String? icNo,
    String? packageCode,
    String? diCode,
  }) : super(
          PurchaseOrderList.name,
          path: '/purchaseOrderList',
          args: PurchaseOrderListArgs(
            icNo: icNo,
            packageCode: packageCode,
            diCode: diCode,
          ),
        );

  static const String name = 'PurchaseOrderList';
}

class PurchaseOrderListArgs {
  const PurchaseOrderListArgs({
    this.icNo,
    this.packageCode,
    this.diCode,
  });

  final String? icNo;

  final String? packageCode;

  final String? diCode;

  @override
  String toString() {
    return 'PurchaseOrderListArgs{icNo: $icNo, packageCode: $packageCode, diCode: $diCode}';
  }
}

/// generated route for
/// [_i10.PaymentHistory]
class PaymentHistory extends _i42.PageRouteInfo<void> {
  const PaymentHistory()
      : super(
          PaymentHistory.name,
          path: '/paymentHistory',
        );

  static const String name = 'PaymentHistory';
}

/// generated route for
/// [_i10.PaymentHistoryDetail]
class PaymentHistoryDetail
    extends _i42.PageRouteInfo<PaymentHistoryDetailArgs> {
  PaymentHistoryDetail({required dynamic recpNo})
      : super(
          PaymentHistoryDetail.name,
          path: '/paymentHistoryDetail',
          args: PaymentHistoryDetailArgs(recpNo: recpNo),
        );

  static const String name = 'PaymentHistoryDetail';
}

class PaymentHistoryDetailArgs {
  const PaymentHistoryDetailArgs({required this.recpNo});

  final dynamic recpNo;

  @override
  String toString() {
    return 'PaymentHistoryDetailArgs{recpNo: $recpNo}';
  }
}

/// generated route for
/// [_i10.RequestPickup]
class RequestPickup extends _i42.PageRouteInfo<void> {
  const RequestPickup()
      : super(
          RequestPickup.name,
          path: '/requestPickup',
        );

  static const String name = 'RequestPickup';
}

/// generated route for
/// [_i10.RegisteredCourse]
class RegisteredCourse extends _i42.PageRouteInfo<void> {
  const RegisteredCourse()
      : super(
          RegisteredCourse.name,
          path: '/registeredCourse',
        );

  static const String name = 'RegisteredCourse';
}

/// generated route for
/// [_i10.RegisteredCourseDetail]
class RegisteredCourseDetail
    extends _i42.PageRouteInfo<RegisteredCourseDetailArgs> {
  RegisteredCourseDetail({required dynamic groupId})
      : super(
          RegisteredCourseDetail.name,
          path: '/registeredCourseDetail',
          args: RegisteredCourseDetailArgs(groupId: groupId),
        );

  static const String name = 'RegisteredCourseDetail';
}

class RegisteredCourseDetailArgs {
  const RegisteredCourseDetailArgs({required this.groupId});

  final dynamic groupId;

  @override
  String toString() {
    return 'RegisteredCourseDetailArgs{groupId: $groupId}';
  }
}

/// generated route for
/// [_i10.AttendanceRecord]
class AttendanceRecord extends _i42.PageRouteInfo<AttendanceRecordArgs> {
  AttendanceRecord({
    required dynamic attendanceData,
    required bool? isLoading,
  }) : super(
          AttendanceRecord.name,
          path: '/attendanceRecord',
          args: AttendanceRecordArgs(
            attendanceData: attendanceData,
            isLoading: isLoading,
          ),
        );

  static const String name = 'AttendanceRecord';
}

class AttendanceRecordArgs {
  const AttendanceRecordArgs({
    required this.attendanceData,
    required this.isLoading,
  });

  final dynamic attendanceData;

  final bool? isLoading;

  @override
  String toString() {
    return 'AttendanceRecordArgs{attendanceData: $attendanceData, isLoading: $isLoading}';
  }
}

/// generated route for
/// [_i10.AttendanceTab]
class AttendanceTab extends _i42.PageRouteInfo<void> {
  const AttendanceTab()
      : super(
          AttendanceTab.name,
          path: '/attendanceTab',
        );

  static const String name = 'AttendanceTab';
}

/// generated route for
/// [_i15.Promotions]
class Promotions extends _i42.PageRouteInfo<PromotionsArgs> {
  Promotions({dynamic feed})
      : super(
          Promotions.name,
          path: '/promotions',
          args: PromotionsArgs(feed: feed),
        );

  static const String name = 'Promotions';
}

class PromotionsArgs {
  const PromotionsArgs({this.feed});

  final dynamic feed;

  @override
  String toString() {
    return 'PromotionsArgs{feed: $feed}';
  }
}

/// generated route for
/// [_i13.Profile]
class Profile extends _i42.PageRouteInfo<ProfileArgs> {
  Profile({
    dynamic userProfile,
    dynamic enrollData,
    dynamic isLoading,
  }) : super(
          Profile.name,
          path: '/profile',
          args: ProfileArgs(
            userProfile: userProfile,
            enrollData: enrollData,
            isLoading: isLoading,
          ),
        );

  static const String name = 'Profile';
}

class ProfileArgs {
  const ProfileArgs({
    this.userProfile,
    this.enrollData,
    this.isLoading,
  });

  final dynamic userProfile;

  final dynamic enrollData;

  final dynamic isLoading;

  @override
  String toString() {
    return 'ProfileArgs{userProfile: $userProfile, enrollData: $enrollData, isLoading: $isLoading}';
  }
}

/// generated route for
/// [_i13.ProfileTab]
class ProfileTab extends _i42.PageRouteInfo<ProfileTabArgs> {
  ProfileTab({required dynamic positionStream})
      : super(
          ProfileTab.name,
          path: '/profileTab',
          args: ProfileTabArgs(positionStream: positionStream),
        );

  static const String name = 'ProfileTab';
}

class ProfileTabArgs {
  const ProfileTabArgs({required this.positionStream});

  final dynamic positionStream;

  @override
  String toString() {
    return 'ProfileTabArgs{positionStream: $positionStream}';
  }
}

/// generated route for
/// [_i13.UpdateProfile]
class UpdateProfile extends _i42.PageRouteInfo<void> {
  const UpdateProfile()
      : super(
          UpdateProfile.name,
          path: '/updateProfile',
        );

  static const String name = 'UpdateProfile';
}

/// generated route for
/// [_i4.RegisterUserToDi]
class RegisterUserToDi extends _i42.PageRouteInfo<RegisterUserToDiArgs> {
  RegisterUserToDi({required dynamic barcode})
      : super(
          RegisterUserToDi.name,
          path: 'registerUserToDi',
          args: RegisterUserToDiArgs(barcode: barcode),
        );

  static const String name = 'RegisterUserToDi';
}

class RegisterUserToDiArgs {
  const RegisterUserToDiArgs({required this.barcode});

  final dynamic barcode;

  @override
  String toString() {
    return 'RegisterUserToDiArgs{barcode: $barcode}';
  }
}

/// generated route for
/// [_i13.IdentityBarcode]
class IdentityBarcode extends _i42.PageRouteInfo<void> {
  const IdentityBarcode()
      : super(
          IdentityBarcode.name,
          path: '/identityBarcode',
        );

  static const String name = 'IdentityBarcode';
}

/// generated route for
/// [_i13.EnrolmentInfo]
class EnrolmentInfo extends _i42.PageRouteInfo<void> {
  const EnrolmentInfo()
      : super(
          EnrolmentInfo.name,
          path: '/enrolmentInfo',
        );

  static const String name = 'EnrolmentInfo';
}

/// generated route for
/// [_i13.EnrolmentInfoDetail]
class EnrolmentInfoDetail extends _i42.PageRouteInfo<EnrolmentInfoDetailArgs> {
  EnrolmentInfoDetail({required dynamic groupId})
      : super(
          EnrolmentInfoDetail.name,
          path: '/enrolmentInfoDetail',
          args: EnrolmentInfoDetailArgs(groupId: groupId),
        );

  static const String name = 'EnrolmentInfoDetail';
}

class EnrolmentInfoDetailArgs {
  const EnrolmentInfoDetailArgs({required this.groupId});

  final dynamic groupId;

  @override
  String toString() {
    return 'EnrolmentInfoDetailArgs{groupId: $groupId}';
  }
}

/// generated route for
/// [_i16.Inbox]
class Inbox extends _i42.PageRouteInfo<void> {
  const Inbox()
      : super(
          Inbox.name,
          path: '/inbox',
        );

  static const String name = 'Inbox';
}

/// generated route for
/// [_i17.Invite]
class Invite extends _i42.PageRouteInfo<void> {
  const Invite()
      : super(
          Invite.name,
          path: '/invite',
        );

  static const String name = 'Invite';
}

/// generated route for
/// [_i18.AirtimeTransaction]
class AirtimeTransaction extends _i42.PageRouteInfo<AirtimeTransactionArgs> {
  AirtimeTransaction({required dynamic data})
      : super(
          AirtimeTransaction.name,
          path: '/airtimeTransaction',
          args: AirtimeTransactionArgs(data: data),
        );

  static const String name = 'AirtimeTransaction';
}

class AirtimeTransactionArgs {
  const AirtimeTransactionArgs({required this.data});

  final dynamic data;

  @override
  String toString() {
    return 'AirtimeTransactionArgs{data: $data}';
  }
}

/// generated route for
/// [_i19.AirtimeBillDetail]
class AirtimeBillDetail extends _i42.PageRouteInfo<AirtimeBillDetailArgs> {
  AirtimeBillDetail({required dynamic data})
      : super(
          AirtimeBillDetail.name,
          path: '/airtimeBillDetail',
          args: AirtimeBillDetailArgs(data: data),
        );

  static const String name = 'AirtimeBillDetail';
}

class AirtimeBillDetailArgs {
  const AirtimeBillDetailArgs({required this.data});

  final dynamic data;

  @override
  String toString() {
    return 'AirtimeBillDetailArgs{data: $data}';
  }
}

/// generated route for
/// [_i20.AirtimeSelection]
class AirtimeSelection extends _i42.PageRouteInfo<void> {
  const AirtimeSelection()
      : super(
          AirtimeSelection.name,
          path: '/airtimeSelection',
        );

  static const String name = 'AirtimeSelection';
}

/// generated route for
/// [_i21.BillTransaction]
class BillTransaction extends _i42.PageRouteInfo<BillTransactionArgs> {
  BillTransaction({required dynamic data})
      : super(
          BillTransaction.name,
          path: '/billTransaction',
          args: BillTransactionArgs(data: data),
        );

  static const String name = 'BillTransaction';
}

class BillTransactionArgs {
  const BillTransactionArgs({required this.data});

  final dynamic data;

  @override
  String toString() {
    return 'BillTransactionArgs{data: $data}';
  }
}

/// generated route for
/// [_i22.BillDetail]
class BillDetail extends _i42.PageRouteInfo<BillDetailArgs> {
  BillDetail({required dynamic data})
      : super(
          BillDetail.name,
          path: '/billDetail',
          args: BillDetailArgs(data: data),
        );

  static const String name = 'BillDetail';
}

class BillDetailArgs {
  const BillDetailArgs({required this.data});

  final dynamic data;

  @override
  String toString() {
    return 'BillDetailArgs{data: $data}';
  }
}

/// generated route for
/// [_i23.BillSelection]
class BillSelection extends _i42.PageRouteInfo<void> {
  const BillSelection()
      : super(
          BillSelection.name,
          path: '/billSelection',
        );

  static const String name = 'BillSelection';
}

/// generated route for
/// [_i9.MerchantList]
class MerchantList extends _i42.PageRouteInfo<MerchantListArgs> {
  MerchantList({required dynamic merchantType})
      : super(
          MerchantList.name,
          path: '/merchantList',
          args: MerchantListArgs(merchantType: merchantType),
        );

  static const String name = 'MerchantList';
}

class MerchantListArgs {
  const MerchantListArgs({required this.merchantType});

  final dynamic merchantType;

  @override
  String toString() {
    return 'MerchantListArgs{merchantType: $merchantType}';
  }
}

/// generated route for
/// [_i24.ChatHome]
class ChatHome extends _i42.PageRouteInfo<void> {
  const ChatHome()
      : super(
          ChatHome.name,
          path: '/chatHome',
        );

  static const String name = 'ChatHome';
}

/// generated route for
/// [_i7.TermsAndCondition]
class TermsAndCondition extends _i42.PageRouteInfo<TermsAndConditionArgs> {
  TermsAndCondition({String? termsAndCondition})
      : super(
          TermsAndCondition.name,
          path: '/termsAndCondition',
          args: TermsAndConditionArgs(termsAndCondition: termsAndCondition),
        );

  static const String name = 'TermsAndCondition';
}

class TermsAndConditionArgs {
  const TermsAndConditionArgs({this.termsAndCondition});

  final String? termsAndCondition;

  @override
  String toString() {
    return 'TermsAndConditionArgs{termsAndCondition: $termsAndCondition}';
  }
}

/// generated route for
/// [_i14.FpxPaymentOption]
class FpxPaymentOption extends _i42.PageRouteInfo<FpxPaymentOptionArgs> {
  FpxPaymentOption({
    String? icNo,
    String? docDoc,
    String? docRef,
    String? merchant,
    String? packageCode,
    String? packageDesc,
    String? diCode,
    String? totalAmount,
    String? amountString,
  }) : super(
          FpxPaymentOption.name,
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
            amountString: amountString,
          ),
        );

  static const String name = 'FpxPaymentOption';
}

class FpxPaymentOptionArgs {
  const FpxPaymentOptionArgs({
    this.icNo,
    this.docDoc,
    this.docRef,
    this.merchant,
    this.packageCode,
    this.packageDesc,
    this.diCode,
    this.totalAmount,
    this.amountString,
  });

  final String? icNo;

  final String? docDoc;

  final String? docRef;

  final String? merchant;

  final String? packageCode;

  final String? packageDesc;

  final String? diCode;

  final String? totalAmount;

  final String? amountString;

  @override
  String toString() {
    return 'FpxPaymentOptionArgs{icNo: $icNo, docDoc: $docDoc, docRef: $docRef, merchant: $merchant, packageCode: $packageCode, packageDesc: $packageDesc, diCode: $diCode, totalAmount: $totalAmount, amountString: $amountString}';
  }
}

/// generated route for
/// [_i25.ImageViewer]
class ImageViewer extends _i42.PageRouteInfo<ImageViewerArgs> {
  ImageViewer({
    String? title,
    _i43.NetworkImage? image,
  }) : super(
          ImageViewer.name,
          path: '/imageViewer',
          args: ImageViewerArgs(
            title: title,
            image: image,
          ),
        );

  static const String name = 'ImageViewer';
}

class ImageViewerArgs {
  const ImageViewerArgs({
    this.title,
    this.image,
  });

  final String? title;

  final _i43.NetworkImage? image;

  @override
  String toString() {
    return 'ImageViewerArgs{title: $title, image: $image}';
  }
}

/// generated route for
/// [_i5.Webview]
class Webview extends _i42.PageRouteInfo<WebviewArgs> {
  Webview({
    required String? url,
    String? backType,
  }) : super(
          Webview.name,
          path: '/webview',
          args: WebviewArgs(
            url: url,
            backType: backType,
          ),
        );

  static const String name = 'Webview';
}

class WebviewArgs {
  const WebviewArgs({
    required this.url,
    this.backType,
  });

  final String? url;

  final String? backType;

  @override
  String toString() {
    return 'WebviewArgs{url: $url, backType: $backType}';
  }
}

/// generated route for
/// [_i5.Scan]
class Scan extends _i42.PageRouteInfo<ScanArgs> {
  Scan({
    dynamic getActiveFeed,
    dynamic getDiProfile,
    _i43.Key? key,
  }) : super(
          Scan.name,
          path: '/scan',
          args: ScanArgs(
            getActiveFeed: getActiveFeed,
            getDiProfile: getDiProfile,
            key: key,
          ),
        );

  static const String name = 'Scan';
}

class ScanArgs {
  const ScanArgs({
    this.getActiveFeed,
    this.getDiProfile,
    this.key,
  });

  final dynamic getActiveFeed;

  final dynamic getDiProfile;

  final _i43.Key? key;

  @override
  String toString() {
    return 'ScanArgs{getActiveFeed: $getActiveFeed, getDiProfile: $getDiProfile, key: $key}';
  }
}

/// generated route for
/// [_i7.ReadMore]
class ReadMore extends _i42.PageRouteInfo<ReadMoreArgs> {
  ReadMore({String? packageDesc})
      : super(
          ReadMore.name,
          path: '/readMore',
          args: ReadMoreArgs(packageDesc: packageDesc),
        );

  static const String name = 'ReadMore';
}

class ReadMoreArgs {
  const ReadMoreArgs({this.packageDesc});

  final String? packageDesc;

  @override
  String toString() {
    return 'ReadMoreArgs{packageDesc: $packageDesc}';
  }
}

/// generated route for
/// [_i26.ViewPdf]
class ViewPdf extends _i42.PageRouteInfo<ViewPdfArgs> {
  ViewPdf({
    required String? title,
    required String? pdfLink,
  }) : super(
          ViewPdf.name,
          path: '/viewPdf',
          args: ViewPdfArgs(
            title: title,
            pdfLink: pdfLink,
          ),
        );

  static const String name = 'ViewPdf';
}

class ViewPdfArgs {
  const ViewPdfArgs({
    required this.title,
    required this.pdfLink,
  });

  final String? title;

  final String? pdfLink;

  @override
  String toString() {
    return 'ViewPdfArgs{title: $title, pdfLink: $pdfLink}';
  }
}

/// generated route for
/// [_i27.ComingSoon]
class ComingSoon extends _i42.PageRouteInfo<void> {
  const ComingSoon()
      : super(
          ComingSoon.name,
          path: '/comingSoon',
        );

  static const String name = 'ComingSoon';
}

/// generated route for
/// [_i11.CheckInSlip]
class CheckInSlip extends _i42.PageRouteInfo<void> {
  const CheckInSlip()
      : super(
          CheckInSlip.name,
          path: '/checkInSlip',
        );

  static const String name = 'CheckInSlip';
}

/// generated route for
/// [_i15.Multilevel]
class Multilevel extends _i42.PageRouteInfo<MultilevelArgs> {
  Multilevel({
    dynamic feed,
    String? appVersion,
  }) : super(
          Multilevel.name,
          path: '/multilevel',
          args: MultilevelArgs(
            feed: feed,
            appVersion: appVersion,
          ),
        );

  static const String name = 'Multilevel';
}

class MultilevelArgs {
  const MultilevelArgs({
    this.feed,
    this.appVersion,
  });

  final dynamic feed;

  final String? appVersion;

  @override
  String toString() {
    return 'MultilevelArgs{feed: $feed, appVersion: $appVersion}';
  }
}

/// generated route for
/// [_i13.MerchantProfile]
class MerchantProfile extends _i42.PageRouteInfo<void> {
  const MerchantProfile()
      : super(
          MerchantProfile.name,
          path: '/merchantProfile',
        );

  static const String name = 'MerchantProfile';
}

/// generated route for
/// [_i28.MenuPage]
class MenuRoute extends _i42.PageRouteInfo<MenuRouteArgs> {
  MenuRoute({_i43.Key? key})
      : super(
          MenuRoute.name,
          path: '/menu-page',
          args: MenuRouteArgs(key: key),
        );

  static const String name = 'MenuRoute';
}

class MenuRouteArgs {
  const MenuRouteArgs({this.key});

  final _i43.Key? key;

  @override
  String toString() {
    return 'MenuRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i29.ElearningPage]
class ElearningRoute extends _i42.PageRouteInfo<ElearningRouteArgs> {
  ElearningRoute({_i43.Key? key})
      : super(
          ElearningRoute.name,
          path: '/elearning-page',
          args: ElearningRouteArgs(key: key),
        );

  static const String name = 'ElearningRoute';
}

class ElearningRouteArgs {
  const ElearningRouteArgs({this.key});

  final _i43.Key? key;

  @override
  String toString() {
    return 'ElearningRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i30.CreateFavouritePage]
class CreateFavouriteRoute
    extends _i42.PageRouteInfo<CreateFavouriteRouteArgs> {
  CreateFavouriteRoute({_i43.Key? key})
      : super(
          CreateFavouriteRoute.name,
          path: '/create-favourite-page',
          args: CreateFavouriteRouteArgs(key: key),
        );

  static const String name = 'CreateFavouriteRoute';
}

class CreateFavouriteRouteArgs {
  const CreateFavouriteRouteArgs({this.key});

  final _i43.Key? key;

  @override
  String toString() {
    return 'CreateFavouriteRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i31.FavourieMapPage]
class FavourieMapRoute extends _i42.PageRouteInfo<FavourieMapRouteArgs> {
  FavourieMapRoute({
    _i43.Key? key,
    required double lat,
    required double lng,
  }) : super(
          FavourieMapRoute.name,
          path: '/favourie-map-page',
          args: FavourieMapRouteArgs(
            key: key,
            lat: lat,
            lng: lng,
          ),
        );

  static const String name = 'FavourieMapRoute';
}

class FavourieMapRouteArgs {
  const FavourieMapRouteArgs({
    this.key,
    required this.lat,
    required this.lng,
  });

  final _i43.Key? key;

  final double lat;

  final double lng;

  @override
  String toString() {
    return 'FavourieMapRouteArgs{key: $key, lat: $lat, lng: $lng}';
  }
}

/// generated route for
/// [_i32.CreateFuelPage]
class CreateFuelRoute extends _i42.PageRouteInfo<CreateFuelRouteArgs> {
  CreateFuelRoute({_i43.Key? key})
      : super(
          CreateFuelRoute.name,
          path: '/create-fuel-page',
          args: CreateFuelRouteArgs(key: key),
        );

  static const String name = 'CreateFuelRoute';
}

class CreateFuelRouteArgs {
  const CreateFuelRouteArgs({this.key});

  final _i43.Key? key;

  @override
  String toString() {
    return 'CreateFuelRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i33.CreateServiceCarPage]
class CreateServiceCarRoute
    extends _i42.PageRouteInfo<CreateServiceCarRouteArgs> {
  CreateServiceCarRoute({_i43.Key? key})
      : super(
          CreateServiceCarRoute.name,
          path: '/create-service-car-page',
          args: CreateServiceCarRouteArgs(key: key),
        );

  static const String name = 'CreateServiceCarRoute';
}

class CreateServiceCarRouteArgs {
  const CreateServiceCarRouteArgs({this.key});

  final _i43.Key? key;

  @override
  String toString() {
    return 'CreateServiceCarRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i34.FavouritePlaceListPage]
class FavouritePlaceListRoute extends _i42.PageRouteInfo<void> {
  const FavouritePlaceListRoute()
      : super(
          FavouritePlaceListRoute.name,
          path: '/favourite-place-list-page',
        );

  static const String name = 'FavouritePlaceListRoute';
}

/// generated route for
/// [_i35.PhotoViewPage]
class PhotoViewRoute extends _i42.PageRouteInfo<PhotoViewRouteArgs> {
  PhotoViewRoute({
    _i43.Key? key,
    required List<dynamic> url,
    required String title,
    required int initialIndex,
    required String type,
  }) : super(
          PhotoViewRoute.name,
          path: '/photo-view-page',
          args: PhotoViewRouteArgs(
            key: key,
            url: url,
            title: title,
            initialIndex: initialIndex,
            type: type,
          ),
        );

  static const String name = 'PhotoViewRoute';
}

class PhotoViewRouteArgs {
  const PhotoViewRouteArgs({
    this.key,
    required this.url,
    required this.title,
    required this.initialIndex,
    required this.type,
  });

  final _i43.Key? key;

  final List<dynamic> url;

  final String title;

  final int initialIndex;

  final String type;

  @override
  String toString() {
    return 'PhotoViewRouteArgs{key: $key, url: $url, title: $title, initialIndex: $initialIndex, type: $type}';
  }
}

/// generated route for
/// [_i36.EditFavouritePlacePage]
class EditFavouritePlaceRoute
    extends _i42.PageRouteInfo<EditFavouritePlaceRouteArgs> {
  EditFavouritePlaceRoute({
    _i43.Key? key,
    required String placeId,
    required dynamic place,
    required dynamic images,
  }) : super(
          EditFavouritePlaceRoute.name,
          path: '/edit-favourite-place-page',
          args: EditFavouritePlaceRouteArgs(
            key: key,
            placeId: placeId,
            place: place,
            images: images,
          ),
        );

  static const String name = 'EditFavouritePlaceRoute';
}

class EditFavouritePlaceRouteArgs {
  const EditFavouritePlaceRouteArgs({
    this.key,
    required this.placeId,
    required this.place,
    required this.images,
  });

  final _i43.Key? key;

  final String placeId;

  final dynamic place;

  final dynamic images;

  @override
  String toString() {
    return 'EditFavouritePlaceRouteArgs{key: $key, placeId: $placeId, place: $place, images: $images}';
  }
}

/// generated route for
/// [_i37.FuelMapPage]
class FuelMapRoute extends _i42.PageRouteInfo<FuelMapRouteArgs> {
  FuelMapRoute({
    _i43.Key? key,
    required double lat,
    required double lng,
  }) : super(
          FuelMapRoute.name,
          path: '/fuel-map-page',
          args: FuelMapRouteArgs(
            key: key,
            lat: lat,
            lng: lng,
          ),
        );

  static const String name = 'FuelMapRoute';
}

class FuelMapRouteArgs {
  const FuelMapRouteArgs({
    this.key,
    required this.lat,
    required this.lng,
  });

  final _i43.Key? key;

  final double lat;

  final double lng;

  @override
  String toString() {
    return 'FuelMapRouteArgs{key: $key, lat: $lat, lng: $lng}';
  }
}

/// generated route for
/// [_i38.ExpFuelListPage]
class ExpFuelListRoute extends _i42.PageRouteInfo<ExpFuelListRouteArgs> {
  ExpFuelListRoute({_i43.Key? key})
      : super(
          ExpFuelListRoute.name,
          path: '/exp-fuel-list-page',
          args: ExpFuelListRouteArgs(key: key),
        );

  static const String name = 'ExpFuelListRoute';
}

class ExpFuelListRouteArgs {
  const ExpFuelListRouteArgs({this.key});

  final _i43.Key? key;

  @override
  String toString() {
    return 'ExpFuelListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i39.EditExpFuelPage]
class EditExpFuelRoute extends _i42.PageRouteInfo<EditExpFuelRouteArgs> {
  EditExpFuelRoute({
    _i43.Key? key,
    required dynamic fuel,
  }) : super(
          EditExpFuelRoute.name,
          path: '/edit-exp-fuel-page',
          args: EditExpFuelRouteArgs(
            key: key,
            fuel: fuel,
          ),
        );

  static const String name = 'EditExpFuelRoute';
}

class EditExpFuelRouteArgs {
  const EditExpFuelRouteArgs({
    this.key,
    required this.fuel,
  });

  final _i43.Key? key;

  final dynamic fuel;

  @override
  String toString() {
    return 'EditExpFuelRouteArgs{key: $key, fuel: $fuel}';
  }
}

/// generated route for
/// [_i10.PickupHistory]
class PickupHistory extends _i42.PageRouteInfo<void> {
  const PickupHistory()
      : super(
          PickupHistory.name,
          path: '/pickup-history',
        );

  static const String name = 'PickupHistory';
}

/// generated route for
/// [_i40.BriefListPage]
class BriefListRoute extends _i42.PageRouteInfo<void> {
  const BriefListRoute()
      : super(
          BriefListRoute.name,
          path: '/brief-list-page',
        );

  static const String name = 'BriefListRoute';
}

/// generated route for
/// [_i41.BriefVideoPage]
class BriefVideoRoute extends _i42.PageRouteInfo<BriefVideoRouteArgs> {
  BriefVideoRoute({
    _i43.Key? key,
    required Map<String, Object> fileDetail,
  }) : super(
          BriefVideoRoute.name,
          path: '/brief-video-page',
          args: BriefVideoRouteArgs(
            key: key,
            fileDetail: fileDetail,
          ),
        );

  static const String name = 'BriefVideoRoute';
}

class BriefVideoRouteArgs {
  const BriefVideoRouteArgs({
    this.key,
    required this.fileDetail,
  });

  final _i43.Key? key;

  final Map<String, Object> fileDetail;

  @override
  String toString() {
    return 'BriefVideoRouteArgs{key: $key, fileDetail: $fileDetail}';
  }
}
