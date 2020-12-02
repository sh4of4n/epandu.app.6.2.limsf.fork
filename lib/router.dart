import 'package:auto_route/auto_route_annotations.dart';
import 'package:epandu/coming_soon/coming_soon.dart';
import 'package:epandu/pages/chat/chat.dart';
import 'package:epandu/pages/enroll/enroll.dart';
import 'package:epandu/pages/epandu/add_booking.dart';
import 'package:epandu/pages/epandu/epandu.dart';
import 'package:epandu/pages/forgot_password/forgot_password.dart';
import 'package:epandu/pages/inbox/inbox.dart';
import 'package:epandu/pages/invite/invite.dart';
import 'package:epandu/pages/kpp/kpp.dart';
import 'package:epandu/pages/payment/airtime_bill_detail.dart';
import 'package:epandu/pages/payment/airtime_selection.dart';
import 'package:epandu/pages/payment/bill_detail.dart';
import 'package:epandu/pages/payment/bill_selection.dart';
import 'package:epandu/pages/payment/bill_transaction.dart';
import 'package:epandu/pages/profile/profile.dart';
import 'package:epandu/pages/promotions/promotions.dart';
import 'package:epandu/pages/register/register.dart';
import 'package:epandu/pages/vclub/value_club.dart';

import 'pages/di_enroll/di_enrollment.dart';
import 'pages/emergency/emergency.dart';
import 'pages/home/home.dart';
import 'pages/login/login.dart';
import 'pages/pay/pay.dart';
import 'pages/payment/airtime_transaction.dart';
import 'pages/settings/settings.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: Authentication, initial: true),
    MaterialRoute(page: ClientAccount),
    MaterialRoute(page: Login),
    MaterialRoute(page: ForgotPassword),
    MaterialRoute(page: ChangePassword),
    MaterialRoute(page: RegisterMobile),
    MaterialRoute(page: RegisterVerification),
    MaterialRoute(page: RegisterForm),
    MaterialRoute(page: Home),
    MaterialRoute(page: Settings),
    MaterialRoute(page: Enrollment),
    MaterialRoute(page: DiEnrollment),
    MaterialRoute(page: EnrollConfirmation),
    MaterialRoute(page: OrderList),
    MaterialRoute(page: BankList),
    MaterialRoute(page: PaymentStatus),
    MaterialRoute(page: KppCategory),
    MaterialRoute(page: KppResult),
    MaterialRoute(page: KppExam),
    MaterialRoute(page: KppModule),
    MaterialRoute(page: PinActivation),
    MaterialRoute(page: ValueClub),
    MaterialRoute(page: EpanduCategory),
    MaterialRoute(page: EmergencyDirectory),
    MaterialRoute(page: DirectoryList),
    MaterialRoute(page: DirectoryDetail),
    MaterialRoute(page: SelectInstitute),
    MaterialRoute(page: SelectClass),
    MaterialRoute(page: SelectDrivingInstitute),
    MaterialRoute(page: TakeProfilePicture),
    MaterialRoute(page: Booking),
    MaterialRoute(page: AddBooking),
    MaterialRoute(page: Records),
    MaterialRoute(page: Pay),
    MaterialRoute(page: PurchaseOrderList),
    MaterialRoute(page: PaymentHistory),
    MaterialRoute(page: PaymentHistoryDetail),
    MaterialRoute(page: RequestPickup),
    MaterialRoute(page: RegisteredCourse),
    MaterialRoute(page: RegisteredCourseDetail),
    MaterialRoute(page: AttendanceRecord),
    MaterialRoute(page: Promotions),
    MaterialRoute(page: Profile),
    MaterialRoute(page: ProfileTab),
    MaterialRoute(page: UpdateProfile),
    MaterialRoute(page: RegisterUserToDi),
    MaterialRoute(page: IdentityBarcode),
    MaterialRoute(page: Inbox),
    MaterialRoute(page: Invite),
    MaterialRoute(page: AirtimeTransaction),
    MaterialRoute(page: AirtimeBillDetail),
    MaterialRoute(page: AirtimeSelection),
    MaterialRoute(page: BillTransaction),
    MaterialRoute(page: BillDetail),
    MaterialRoute(page: BillSelection),
    MaterialRoute(page: MerchantList),
    MaterialRoute(page: ChatHome),
    MaterialRoute(page: TermsAndCondition),
    MaterialRoute(page: FpxPaymentOption),
    MaterialRoute(page: Webview),
    MaterialRoute(page: ComingSoon),
  ],
)
class $Router {}
