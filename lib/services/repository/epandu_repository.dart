import 'package:epandu/services/api/model/epandu_model.dart';
import 'package:epandu/services/api/networking.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';

import '../../app_localizations.dart';

class EpanduRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  Future<Response> getEnrollByCode({context}) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    //  Temporarily use TBS as diCode
    String diCode = 'TBS';
    // String diCode = await localStorage.getDiCode();
    String groupId = '';
    String icNo = await localStorage.getStudentIc();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&icNo=$icNo&groupId=$groupId';

    var response = await networking.getData(
      path: 'GetEnrollByCode?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetEnrollmentResponse getEnrollmentResponse;

      getEnrollmentResponse = GetEnrollmentResponse.fromJson(response.data);

      // not relevant anymore as there could be more than one enrollment
      localStorage.saveEnrolledGroupId(getEnrollmentResponse.enroll[0].groupId);
      localStorage.saveBlacklisted(getEnrollmentResponse.enroll[0].blacklisted);

      return Response(true, data: getEnrollmentResponse.enroll);
    } else if (response.message != null &&
        response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message != null &&
        response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message != null && response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message != null &&
        response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: AppLocalizations.of(context).translate('no_enrollment_desc'));
  }

  Future<Response> getCollectionByStudent({context}) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    //  Temporarily use TBS as diCode
    String diCode = 'TBS';
    // String diCode = await localStorage.getDiCode();
    String icNo = await localStorage.getStudentIc();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&icNo=$icNo';

    var response = await networking.getData(
      path: 'GetCollectionHeaderDetailByStudent?$path',
    );

    if (response.isSuccess && response.data != null) {
      StudentPaymentResponse studentPaymentResponse;

      studentPaymentResponse = StudentPaymentResponse.fromJson(response.data);

      return Response(true, data: studentPaymentResponse.collectTrn);
    } else if (response.message != null &&
        response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message != null &&
        response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message != null && response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message != null &&
        response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: AppLocalizations.of(context).translate('no_payment_desc'));
  }

  Future<Response> getDTestByCode({context}) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    //  Temporarily use TBS as diCode
    String diCode = 'TBS';
    // String diCode = await localStorage.getDiCode();
    String groupId = await localStorage.getEnrolledGroupId();
    String icNo = await localStorage.getStudentIc();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&icNo=$icNo&groupId=$groupId';

    var response = await networking.getData(
      path: 'GetDTestByCode?$path',
    );

    if (response.isSuccess && response.data != null) {
      StudentAttendanceResponse studentAttendanceResponse;

      studentAttendanceResponse =
          StudentAttendanceResponse.fromJson(response.data);

      return Response(true, data: studentAttendanceResponse.dTest);
    } else if (response.message != null &&
        response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message != null &&
        response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message != null && response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message != null &&
        response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: AppLocalizations.of(context).translate('no_attendance_desc'));
  }
}
