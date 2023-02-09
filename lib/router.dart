import 'package:auto_route/auto_route.dart';
import 'package:epandu/coming_soon/coming_soon.dart';
import 'package:epandu/pages/brief/brief_video.dart';
import 'package:epandu/pages/brief/brief_list.dart';
import 'package:epandu/pages/chat/chat.dart';
import 'package:epandu/pages/elearning/elearning.dart';
import 'package:epandu/pages/enroll/enroll.dart';
import 'package:epandu/pages/epandu/epandu.dart';
import 'package:epandu/pages/expenses/create_fuel.dart';
import 'package:epandu/pages/expenses/create_service_car.dart';
import 'package:epandu/pages/expenses/edit_exp_fuel.dart';
import 'package:epandu/pages/expenses/exp_fuel_list.dart';
import 'package:epandu/pages/expenses/fuel_map.dart';
import 'package:epandu/pages/favourite/edit_favourite_place.dart';
import 'package:epandu/pages/favourite/favourite_map.dart';
import 'package:epandu/pages/favourite/favourite_place_list.dart';
import 'package:epandu/pages/favourite/photo_view.dart';
import 'package:epandu/pages/forgot_password/forgot_password.dart';
import 'package:epandu/pages/favourite/create_favourite.dart';
import 'package:epandu/pages/home/menu_page.dart';
import 'package:epandu/pages/inbox/inbox.dart';
import 'package:epandu/pages/invite/invite.dart';
import 'package:epandu/pages/kpp/kpp.dart';
import 'package:epandu/pages/payment/airtime_bill_detail.dart';
import 'package:epandu/pages/payment/airtime_selection.dart';
import 'package:epandu/pages/payment/bill_detail.dart';
import 'package:epandu/pages/payment/bill_selection.dart';
import 'package:epandu/pages/payment/bill_transaction.dart';
import 'package:epandu/pages/pdf/view_pdf.dart';
import 'package:epandu/pages/profile/profile.dart';
import 'package:epandu/pages/promotions/promotions.dart';
import 'package:epandu/pages/register/register.dart';
import 'package:epandu/pages/vclub/value_club.dart';

import 'pages/di_enroll/di_enrollment.dart';
import 'pages/emergency/emergency.dart';
import 'pages/etesting/etesting.dart';
import 'pages/home/home.dart';
import 'pages/login/login.dart';
import 'pages/pay/pay.dart';
import 'pages/payment/airtime_transaction.dart';
import 'pages/settings/settings.dart';
import 'package:epandu/common_library/utils/image_viewer.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/authentication', page: Authentication, initial: true),
    AutoRoute(
        path: '/clientAccount', page: ClientAccount, name: 'ClientAccount'),
    AutoRoute(path: '/login', page: Login, name: 'Login'),
    AutoRoute(
        path: '/forgotPassword', page: ForgotPassword, name: 'ForgotPassword'),
    AutoRoute(
        path: '/changePassword', page: ChangePassword, name: 'ChangePassword'),
    AutoRoute(
        path: '/registerMobile', page: RegisterMobile, name: 'RegisterMobile'),
    AutoRoute(
        path: '/registerVerification',
        page: RegisterVerification,
        name: 'RegisterVerification'),
    AutoRoute(path: '/registerForm', page: RegisterForm, name: 'RegisterForm'),
    AutoRoute(path: '/home', page: Home, name: 'Home'),
    AutoRoute(path: '/queueNumber', page: QueueNumber, name: 'QueueNumber'),
    AutoRoute(path: '/enrollment', page: Enrollment, name: 'Enrollment'),
    AutoRoute(path: '/diEnrollment', page: DiEnrollment, name: 'DiEnrollment'),
    AutoRoute(
        path: '/enrollConfirmation',
        page: EnrollConfirmation,
        name: 'EnrollConfirmation'),
    AutoRoute(path: '/orderList', page: OrderList, name: 'OrderList'),
    AutoRoute(path: '/bankList', page: BankList, name: 'BankList'),
    AutoRoute(
        path: '/paymentStatus', page: PaymentStatus, name: 'PaymentStatus'),
    AutoRoute(path: '/kppCategory', page: KppCategory, name: 'KppCategory'),
    AutoRoute(path: '/kppResult', page: KppResult, name: 'KppResult'),
    AutoRoute(path: '/kppExam', page: KppExam, name: 'KppExam'),
    AutoRoute(path: '/kppModule', page: KppModule, name: 'KppModule'),
    AutoRoute(
        path: '/pinActivation', page: PinActivation, name: 'PinActivation'),
    AutoRoute(path: '/valueClub', page: ValueClub, name: 'ValueClub'),
    AutoRoute(path: '/product', page: Product, name: 'Product'),
    AutoRoute(path: '/productList', page: ProductList, name: 'ProductList'),
    AutoRoute(path: '/cart', page: Cart, name: 'Cart'),
    AutoRoute(path: '/cartItemEdit', page: CartItemEdit, name: 'CartItemEdit'),
    AutoRoute(path: '/checkout', page: Checkout, name: 'Checkout'),
    AutoRoute(
        path: '/epanduCategory', page: EpanduCategory, name: 'EpanduCategory'),
    AutoRoute(
        path: '/epanduCategory',
        page: EtestingCategory,
        name: 'EtestingCategory'),
    AutoRoute(
        path: '/emergencyDirectory',
        page: EmergencyDirectory,
        name: 'EmergencyDirectory'),
    AutoRoute(
        path: '/directoryList', page: DirectoryList, name: 'DirectoryList'),
    AutoRoute(
        path: '/directoryDetail',
        page: DirectoryDetail,
        name: 'DirectoryDetail'),
    AutoRoute(
        path: '/selectInstitute',
        page: SelectInstitute,
        name: 'SelectInstitute'),
    AutoRoute(path: '/selectClass', page: SelectClass, name: 'SelectClass'),
    AutoRoute(
        path: '/selectDrivingInstitute',
        page: SelectDrivingInstitute,
        name: 'SelectDrivingInstitute'),
    AutoRoute(
        path: '/takeProfilePicture',
        page: TakeProfilePicture,
        name: 'TakeProfilePicture'),
    AutoRoute(path: '/booking', page: Booking, name: 'Booking'),
    AutoRoute(path: '/addBooking', page: AddBooking, name: 'AddBooking'),
    AutoRoute(path: '/records', page: Records, name: 'Records'),
    AutoRoute(path: '/pay', page: Pay, name: 'Pay'),
    AutoRoute(
        path: '/purchaseOrderList',
        page: PurchaseOrderList,
        name: 'PurchaseOrderList'),
    AutoRoute(
        path: '/paymentHistory', page: PaymentHistory, name: 'PaymentHistory'),
    AutoRoute(
        path: '/paymentHistoryDetail',
        page: PaymentHistoryDetail,
        name: 'PaymentHistoryDetail'),
    AutoRoute(
        path: '/requestPickup', page: RequestPickup, name: 'RequestPickup'),
    AutoRoute(
        path: '/registeredCourse',
        page: RegisteredCourse,
        name: 'RegisteredCourse'),
    AutoRoute(
        path: '/registeredCourseDetail',
        page: RegisteredCourseDetail,
        name: 'RegisteredCourseDetail'),
    AutoRoute(
        path: '/attendanceRecord',
        page: AttendanceRecord,
        name: 'AttendanceRecord'),
    AutoRoute(
        path: '/attendanceTab', page: AttendanceTab, name: 'AttendanceTab'),
    AutoRoute(path: '/promotions', page: Promotions, name: 'Promotions'),
    AutoRoute(path: '/profile', page: Profile, name: 'Profile'),
    AutoRoute(path: '/profileTab', page: ProfileTab, name: 'ProfileTab'),
    AutoRoute(
        path: '/updateProfile', page: UpdateProfile, name: 'UpdateProfile'),
    AutoRoute(
        path: 'registerUserToDi',
        page: RegisterUserToDi,
        name: 'RegisterUserToDi'),
    AutoRoute(
        path: '/identityBarcode',
        page: IdentityBarcode,
        name: 'IdentityBarcode'),
    AutoRoute(
        path: '/enrolmentInfo', page: EnrolmentInfo, name: 'EnrolmentInfo'),
    AutoRoute(
        path: '/enrolmentInfoDetail',
        page: EnrolmentInfoDetail,
        name: 'EnrolmentInfoDetail'),
    AutoRoute(path: '/inbox', page: Inbox, name: 'Inbox'),
    AutoRoute(path: '/invite', page: Invite, name: 'Invite'),
    AutoRoute(
        path: '/airtimeTransaction',
        page: AirtimeTransaction,
        name: 'AirtimeTransaction'),
    AutoRoute(
        path: '/airtimeBillDetail',
        page: AirtimeBillDetail,
        name: 'AirtimeBillDetail'),
    AutoRoute(
        path: '/airtimeSelection',
        page: AirtimeSelection,
        name: 'AirtimeSelection'),
    AutoRoute(
        path: '/billTransaction',
        page: BillTransaction,
        name: 'BillTransaction'),
    AutoRoute(path: '/billDetail', page: BillDetail, name: 'BillDetail'),
    AutoRoute(
        path: '/billSelection', page: BillSelection, name: 'BillSelection'),
    AutoRoute(path: '/merchantList', page: MerchantList, name: 'MerchantList'),
    AutoRoute(path: '/chatHome', page: ChatHome, name: 'ChatHome'),
    AutoRoute(
        path: '/termsAndCondition',
        page: TermsAndCondition,
        name: 'TermsAndCondition'),
    AutoRoute(
        path: '/fpxPaymentOption',
        page: FpxPaymentOption,
        name: 'FpxPaymentOption'),
    AutoRoute(path: '/imageViewer', page: ImageViewer, name: 'ImageViewer'),
    AutoRoute(path: '/webview', page: Webview, name: 'Webview'),
    AutoRoute(path: '/scan', page: Scan, name: 'Scan'),
    AutoRoute(path: '/readMore', page: ReadMore, name: 'ReadMore'),
    AutoRoute(path: '/viewPdf', page: ViewPdf, name: 'ViewPdf'),
    AutoRoute(path: '/comingSoon', page: ComingSoon, name: 'ComingSoon'),
    AutoRoute(path: '/checkInSlip', page: CheckInSlip, name: 'CheckInSlip'),
    AutoRoute(path: '/multilevel', page: Multilevel, name: 'Multilevel'),
    AutoRoute(
        path: '/merchantProfile',
        page: MerchantProfile,
        name: 'MerchantProfile'),
    AutoRoute(page: MenuPage),
    AutoRoute(page: ElearningPage),
    AutoRoute(page: CreateFavouritePage),
    AutoRoute(page: FavourieMapPage),
    AutoRoute(page: CreateFuelPage),
    AutoRoute(page: CreateServiceCarPage),
    AutoRoute(page: FavouritePlaceListPage),
    AutoRoute(page: PhotoViewPage),
    AutoRoute(page: EditFavouritePlacePage),
    AutoRoute(page: FuelMapPage),
    AutoRoute(page: ExpFuelListPage),
    AutoRoute(page: EditExpFuelPage),
    AutoRoute(page: PickupHistory),
    AutoRoute(page: BriefListPage),
    AutoRoute(page: BriefVideoPage),
  ],
)
class $AppRouter {}
