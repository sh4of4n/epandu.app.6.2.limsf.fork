import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_config.dart';
import '../../utils/local_storage.dart';
import '../model/epandu_model.dart';
import '../networking.dart';
import '../response.dart';
import 'package:html_unescape/html_unescape_small.dart';

class EpanduRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();
  final unescape = HtmlUnescape();
  final customDialog = CustomDialog();

  Future<Response> getEnrollByCode({groupId}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    //  Temporarily use TBS as diCode
    String diCode = appConfig.diCode;
    // String diCode = await localStorage.getDiCode();
    // String groupId = '';
    String icNo = await localStorage.getStudentIc();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&icNo=$icNo&groupId=${groupId ?? ''}';

    var response = await networking.getData(
      path: 'GetEnrollByCode?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetEnrollmentResponse getEnrollmentResponse;

      getEnrollmentResponse = GetEnrollmentResponse.fromJson(response.data);

      // not relevant anymore as there could be more than one enrollment
      // localStorage.saveEnrolledGroupId(getEnrollmentResponse.enroll[0].groupId);
      // localStorage.saveBlacklisted(getEnrollmentResponse.enroll[0].blacklisted);

      return Response(true, data: getEnrollmentResponse.enroll);
    }

    return Response(false, message: 'You have no class enrolled.');
  }

  Future<Response> getCollectionByStudent({context, startIndex}) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    //  Temporarily use TBS as diCode
    String diCode = appConfig.diCode;
    // String diCode = await localStorage.getDiCode();
    String icNo = await localStorage.getStudentIc();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&icNo=$icNo&startIndex=$startIndex&noOfRecords=10';

    var response = await networking.getData(
      path: 'GetCollectionByStudentV2?$path',
    );

    if (response.isSuccess && response.data != null) {
      StudentPaymentResponse studentPaymentResponse;

      studentPaymentResponse = StudentPaymentResponse.fromJson(response.data);

      return Response(true, data: studentPaymentResponse.collectTrn);
    }

    return Response(false, message: 'You have no payment history');
  }

  Future<Response> getCollectionDetailByRecpNo({context, recpNo}) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    //  Temporarily use TBS as diCode
    String diCode = appConfig.diCode;
    // String diCode = await localStorage.getDiCode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&recpNo=$recpNo';

    var response = await networking.getData(
      path: 'GetCollectionDetailByRecpNo?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetCollectionDetailByRecpNoResponse getCollectionDetailByRecpNoResponse;

      getCollectionDetailByRecpNoResponse =
          GetCollectionDetailByRecpNoResponse.fromJson(response.data);

      return Response(true,
          data: getCollectionDetailByRecpNoResponse.collectDetail);
    }

    return Response(false, message: 'No records found.');
  }

  Future<Response> getDTestByCode({context}) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    //  Temporarily use TBS as diCode
    String diCode = await localStorage.getDiCode();
    // String diCode = await localStorage.getDiCode();
    // String groupId = await localStorage.getEnrolledGroupId();
    String icNo = await localStorage.getStudentIc();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&icNo=$icNo&groupId=';

    var response = await networking.getData(
      path: 'GetDTestByCode?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetDTestByCodeResponse getDTestByCodeResponse;

      getDTestByCodeResponse = GetDTestByCodeResponse.fromJson(response.data);

      return Response(true, data: getDTestByCodeResponse.dTest);
    }

    return Response(false, message: 'You have no booking.');
  }

  // booking
  /* Future<Response> getBookingTest({
    context,
    groupId,
    testType,
  }) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    String diCode = await localStorage.getDiCode();
    // String groupId = await localStorage.getEnrolledGroupId();
    String icNo = await localStorage.getStudentIc();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&groupId=${groupId ?? ''}&testType=${testType ?? ''}&icNo=$icNo';

    var response = await networking.getData(
      path: 'GetBookingTest?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetBookingTestResponse getBookingTestResponse;

      getBookingTestResponse = GetBookingTestResponse.fromJson(response.data);

      return Response(true, data: getBookingTestResponse.dTest);
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
        message: AppLocalizations.of(context).translate('no_records_found'));
  } */

  Future<Response> getTestListGroupId({
    context,
  }) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    String diCode = await localStorage.getDiCode();
    // String groupId = await localStorage.getEnrolledGroupId();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode';

    var response = await networking.getData(
      path: 'GetTestListGroupId?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetTestListGroupIdResponse getTestListGroupIdResponse;

      getTestListGroupIdResponse =
          GetTestListGroupIdResponse.fromJson(response.data);

      return Response(true, data: getTestListGroupIdResponse.test);
    }

    return Response(false, message: 'No records found.');
  }

  Future<Response> getTestListGroupIdByIcNo({
    context,
  }) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String icNo = await localStorage.getStudentIc();
    String diCode = await localStorage.getDiCode();
    // String groupId = await localStorage.getEnrolledGroupId();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&icNo=$icNo';

    var response = await networking.getData(
      path: 'GetTestListGroupIdByIcNo?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetTestListGroupIdResponse getTestListGroupIdResponse;

      getTestListGroupIdResponse =
          GetTestListGroupIdResponse.fromJson(response.data);

      return Response(true, data: getTestListGroupIdResponse.test);
    }

    return Response(false, message: 'No records found.');
  }

  Future<Response> getTestListTestType({
    context,
    groupId,
  }) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    String diCode = await localStorage.getDiCode();
    // String groupId = await localStorage.getEnrolledGroupId();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&groupId=$groupId';

    var response = await networking.getData(
      path: 'GetTestListTestType?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetTestListTestTypeResponse getTestListTestTypeResponse;

      getTestListTestTypeResponse =
          GetTestListTestTypeResponse.fromJson(response.data);

      return Response(true, data: getTestListTestTypeResponse.test);
    }

    return Response(false, message: 'No records found.');
  }

  Future<Response> getTestList({
    context,
    groupId,
    testType,
  }) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    String diCode = await localStorage.getDiCode();
    // String groupId = await localStorage.getEnrolledGroupId();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&groupId=${groupId ?? ''}&testType=${testType ?? ''}';

    var response = await networking.getData(
      path: 'GetTestList?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetTestListResponse getTestListResponse;

      getTestListResponse = GetTestListResponse.fromJson(response.data);

      return Response(true, data: getTestListResponse.test);
    }

    return Response(false, message: 'No records found.');
  }

  Future<Response> getCourseSectionList({
    context,
    groupId,
  }) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    String diCode = await localStorage.getDiCode();
    // String groupId = await localStorage.getEnrolledGroupId();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&groupId=${groupId ?? ''}';

    var response = await networking.getData(
      path: 'GetCourseSectionList?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetCourseSectionListResponse getCourseSectionListResponse;

      getCourseSectionListResponse =
          GetCourseSectionListResponse.fromJson(response.data);

      return Response(true, data: getCourseSectionListResponse.courseSection);
    }

    return Response(false, message: 'No records found.');
  }

  Future<Response> saveBookingTest({
    context,
    userId,
    groupId,
    testType,
    testDate,
    courseSection,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String diCode = await localStorage.getDiCode();
    String icNo = await localStorage.getStudentIc();

    SaveBookingTestRequest saveUserPasswordRequest = SaveBookingTestRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      groupId: groupId,
      testType: testType,
      testDate: testDate,
      courseSection: courseSection,
      icNo: icNo,
      userId: userId,
    );

    String body = jsonEncode(saveUserPasswordRequest);
    String api = 'SaveBookingTest';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data == 'True') {
      return Response(true);
    }

    return Response(false,
        message: response.message.replaceAll(r'\u000d\u000a', ''));
  }

  Future<Response> getJpjTestCheckIn() async {
    String customUrl =
        'http://192.168.168.2/etesting.MainService/${appConfig.wsVer}/MainService.svc';

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String icNo = await localStorage.getStudentIc();
    String userId = await localStorage.getUserId();

    String diCode = await localStorage.getDiCode();
    // String groupId = await localStorage.getEnrolledGroupId();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&userId=$userId&icNo=$icNo';

    var response = await Networking(customUrl: customUrl).getData(
      path: 'GetJpjTestCheckIn?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetJpjTestCheckInResponse getJpjTestCheckInResponse;

      getJpjTestCheckInResponse =
          GetJpjTestCheckInResponse.fromJson(response.data);

      return Response(true, data: getJpjTestCheckInResponse.jpjTestTrn);
    }

    return Response(false, message: 'No records found.');
  }

  Future<Response> getLastJpjTestCheckInByInterval({
    String intervalInSeconds,
  }) async {
    String customUrl =
        'http://192.168.168.2/etesting.MainService/${appConfig.wsVer}/MainService.svc';

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String diCode = await localStorage.getDiCode();
    // String groupId = await localStorage.getEnrolledGroupId();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&intervalInSeconds=${intervalInSeconds ?? ''}';

    var response = await Networking(customUrl: customUrl).getData(
      path: 'GetLastJpjTestCheckInByInterval?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetLastJpjTestCheckInByIntervalResponse
          getLastJpjTestCheckInByIntervalResponse;

      getLastJpjTestCheckInByIntervalResponse =
          GetLastJpjTestCheckInByIntervalResponse.fromJson(response.data);

      return Response(true,
          data: getLastJpjTestCheckInByIntervalResponse.jpjTestTrn);
    }

    return Response(false, message: 'No records found.');
  }

  Future<Response> verifyScanCode({
    context,
    @required qrcodeJson,
  }) async {
    String customUrl =
        'http://192.168.168.2/etesting.MainService/${appConfig.wsVer}/MainService.svc';

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String diCode = await localStorage.getDiCode();
    String userId = await localStorage.getUserId();
    String icNo = await localStorage.getStudentIc();

    VerifyScanCodeRequest verifyScanCodeRequest = VerifyScanCodeRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      icNo: icNo,
      diCode: diCode,
      userId: userId,
      qrcodeJson: qrcodeJson,
    );

    customDialog.show(
      context: context,
      title: Text('$customUrl/webapi/VerifyScanCodeByIcNo'),
      content:
          'wsCodeCrypt: ${appConfig.wsCodeCrypt}, caUid: $caUid, caPwd: $caPwd, icNo: $icNo, merchantNo: $diCode, userId: $userId, qrCodeJson: $qrcodeJson',
      customActions: [
        TextButton(
          child: Text(AppLocalizations.of(context).translate('ok_btn')),
          onPressed: () => ExtendedNavigator.of(context).pop(),
        ),
      ],
      type: DialogType.GENERAL,
    );

    String body = jsonEncode(verifyScanCodeRequest);
    String api = 'VerifyScanCodeByIcNo';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await Networking(customUrl: customUrl)
        .postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data != null) {
      VerifyScanCodeResponse verifyScanCodeResponse =
          VerifyScanCodeResponse.fromJson(response.data);

      return Response(true, data: verifyScanCodeResponse.jpjTestTrn);
    }

    return Response(false,
        message: response.message == null || response.message.isEmpty
            ? 'Queue number not created. Please try again.'
            : response.message.replaceAll(r'\u000d\u000a', ''));
  }

  Future<Response> getScanCodeByAction() async {
    String customUrl =
        'http://192.168.168.2/etesting.MainService/${appConfig.wsVer}/MainService.svc';

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String diCode = await localStorage.getDiCode();
    String userId = await localStorage.getUserId();

    GetScanCodeByActionRequest getScanCodeByActionRequest =
        GetScanCodeByActionRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      userId: userId,
      action: 'JPJ_PART2_CHECK_IN',
    );

    String body = jsonEncode(getScanCodeByActionRequest);
    String api = 'GetScanCodeByAction';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await Networking(customUrl: customUrl)
        .postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data != null) {
      GetScanCodeByActionResponse getScanCodeByActionResponse =
          GetScanCodeByActionResponse.fromJson(response.data);

      return Response(true, data: getScanCodeByActionResponse.table1);
    }

    return Response(false,
        message: response.message == null || response.message.isEmpty
            ? 'Failed to receive QR code data. Please try again.'
            : response.message.replaceAll(r'\u000d\u000a', ''));
  }
}
