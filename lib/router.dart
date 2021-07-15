import 'package:auto_route/auto_route.dart';
import 'package:epandu/coming_soon/coming_soon.dart';
import 'package:epandu/pages/chat/chat.dart';
import 'package:epandu/pages/enroll/enroll.dart';
import 'package:epandu/pages/epandu/add_booking.dart';
import 'package:epandu/pages/epandu/epandu.dart';
import 'package:epandu/pages/etesting/etesting_category.dart';
import 'package:epandu/pages/forgot_password/forgot_password.dart';
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
    AutoRoute(path: '/clientAccount', page: ClientAccount),
    AutoRoute(path: '/login', page: Login),
    AutoRoute(path: '/forgotPassword', page: ForgotPassword),
    AutoRoute(path: '/changePassword', page: ChangePassword),
    AutoRoute(path: '/registerMobile', page: RegisterMobile),
    AutoRoute(path: '/registerVerification', page: RegisterVerification),
    AutoRoute(path: '/registerForm', page: RegisterForm),
    AutoRoute(path: '/home', page: Home),
    AutoRoute(path: '/queueNumber', page: QueueNumber),
    AutoRoute(path: '/settings', page: Settings),
    AutoRoute(path: '/enrollment', page: Enrollment),
    AutoRoute(path: '/diEnrollment', page: DiEnrollment),
    AutoRoute(path: '/enrollConfirmation', page: EnrollConfirmation),
    AutoRoute(path: '/orderList', page: OrderList),
    AutoRoute(path: '/bankList', page: BankList),
    AutoRoute(path: '/paymentStatus', page: PaymentStatus),
    AutoRoute(path: '/kppCategory', page: KppCategory),
    AutoRoute(path: '/kppResult', page: KppResult),
    AutoRoute(path: '/kppExam', page: KppExam),
    AutoRoute(path: '/kppModule', page: KppModule),
    AutoRoute(path: '/pinActivation', page: PinActivation),
    AutoRoute(path: '/valueClub', page: ValueClub),
    AutoRoute(path: '/product', page: Product),
    AutoRoute(path: '/productList', page: ProductList),
    AutoRoute(path: '/cart', page: Cart),
    AutoRoute(path: '/cartItemEdit', page: CartItemEdit),
    AutoRoute(path: '/checkout', page: Checkout),
    AutoRoute(path: '/epanduCategory', page: EpanduCategory),
    AutoRoute(path: '/epanduCategory', page: EtestingCategory),
    AutoRoute(path: '/emergencyDirectory', page: EmergencyDirectory),
    AutoRoute(path: '/directoryList', page: DirectoryList),
    AutoRoute(path: '/directoryDetail', page: DirectoryDetail),
    AutoRoute(path: '/selectInstitute', page: SelectInstitute),
    AutoRoute(path: '/selectClass', page: SelectClass),
    AutoRoute(path: '/selectDrivingInstitute', page: SelectDrivingInstitute),
    AutoRoute(path: '/takeProfilePicture', page: TakeProfilePicture),
    AutoRoute(path: '/booking', page: Booking),
    AutoRoute(path: '/addBooking', page: AddBooking),
    AutoRoute(path: '/records', page: Records),
    AutoRoute(path: '/pay', page: Pay),
    AutoRoute(path: '/purchaseOrderList', page: PurchaseOrderList),
    AutoRoute(path: '/paymentHistory', page: PaymentHistory),
    AutoRoute(path: '/paymentHistoryDetail', page: PaymentHistoryDetail),
    AutoRoute(path: '/requestPickup', page: RequestPickup),
    AutoRoute(path: '/registeredCourse', page: RegisteredCourse),
    AutoRoute(path: '/registeredCourseDetail', page: RegisteredCourseDetail),
    AutoRoute(path: '/attendanceRecord', page: AttendanceRecord),
    AutoRoute(path: '/attendanceTab', page: AttendanceTab),
    AutoRoute(path: '/promotions', page: Promotions),
    AutoRoute(path: '/profile', page: Profile),
    AutoRoute(path: '/profileTab', page: ProfileTab),
    AutoRoute(path: '/updateProfile', page: UpdateProfile),
    AutoRoute(path: 'registerUserToDi', page: RegisterUserToDi),
    AutoRoute(path: '/identityBarcode', page: IdentityBarcode),
    AutoRoute(path: '/enrolmentInfo', page: EnrolmentInfo),
    AutoRoute(path: '/enrolmentInfoDetail', page: EnrolmentInfoDetail),
    AutoRoute(path: '/inbox', page: Inbox),
    AutoRoute(path: '/invite', page: Invite),
    AutoRoute(path: '/airtimeTransaction', page: AirtimeTransaction),
    AutoRoute(path: '/airtimeBillDetail', page: AirtimeBillDetail),
    AutoRoute(path: '/airtimeSelection', page: AirtimeSelection),
    AutoRoute(path: '/billTransaction', page: BillTransaction),
    AutoRoute(path: '/billDetail', page: BillDetail),
    AutoRoute(path: '/billSelection', page: BillSelection),
    AutoRoute(path: '/merchantList', page: MerchantList),
    AutoRoute(path: '/chatHome', page: ChatHome),
    AutoRoute(path: '/termsAndCondition', page: TermsAndCondition),
    AutoRoute(path: '/fpxPaymentOption', page: FpxPaymentOption),
    AutoRoute(path: '/imageViewer', page: ImageViewer),
    AutoRoute(path: '/webview', page: Webview),
    AutoRoute(path: '/scan', page: Scan),
    AutoRoute(path: '/readMore', page: ReadMore),
    AutoRoute(path: '/viewPdf', page: ViewPdf),
    AutoRoute(path: '/comingSoon', page: ComingSoon),
    AutoRoute(path: '/checkInSlip', page: CheckInSlip),
    AutoRoute(path: '/multilevel', page: Multilevel),
    AutoRoute(path: '/merchantProfile', page: MerchantProfile),
  ],
)
class $AppRouter {}
