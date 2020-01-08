import 'dart:convert';

import 'package:epandu/services/api/model/profile_model.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/networking.dart';

class ProfileRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  /* Future getStudentProfile() async {
    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();

    String params =
        'GetUserRegisteredDI?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${credentials.caUid}&caPwd=${credentials.caPwdUrlEncode}&diCode=$diCode&userId=$userId';

    var response = await networking.getData(path: params);
  }

  Future getStudentProfilePicture() async {} */

  // already obtained from getUserRegisteredDi
  Future<Response> getCustomerData() async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    //  Temporarily use TBS as diCode
    String diCode = 'TBS';
    // String diCode = await localStorage.getDiCode();
    String icNo = await localStorage.getStudentIc();

    Map<String, String> param = {
      'wsCodeCrypt': appConfig.wsCodeCrypt,
      'caUid': caUid,
      'caPwd': caPwd,
      'diCode': diCode,
      'icNo': icNo,
    };

    String method = 'GetCustomerByCode';

    var response = await networking.getData(method: method, param: param);

    var responseData = response.data;
  }

  Future<Response> getStudentEnrollmentData() async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    //  Temporarily use TBS as diCode
    String diCode = 'TBS';
    // String diCode = await localStorage.getDiCode();
    String groupId = '';
    String icNo = await localStorage.getStudentIc();

    GetEnrollmentRequest getEnrollmentRequest = GetEnrollmentRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      icNo: icNo,
      groupId: groupId,
    );

    Map<String, String> param = getEnrollmentRequest.toJson();

    String method = 'GetEnrollByCode';

    var response = await networking.getData(method: method, param: param);

    Map<String, dynamic> enrollmentData;

    String encodeData;
    String processedData;
    var decodedData;

    GetEnrollmentResponse getEnrollmentResponse;

    if (response.isSuccess) {
      if (response.data != null &&
          response.data['GetEnrollByCodeResponse']['GetEnrollByCodeResult']
                  ['EnrollInfo'] !=
              null) {
        //  if response.data is not a list of object
        if (response.data['GetEnrollByCodeResponse']['GetEnrollByCodeResult']
                ['EnrollInfo']['Enroll'][0] ==
            null) {
          enrollmentData = response.data['GetEnrollByCodeResponse']
              ['GetEnrollByCodeResult']['EnrollInfo']['Enroll'];

          encodeData = '{"Enroll": [${jsonEncode(enrollmentData)}]}';
          processedData = encodeData.replaceAll('null', '""');
          decodedData = jsonDecode(processedData);
        }
        // if response.data is a list of object
        else {
          decodedData = response.data['GetEnrollByCodeResponse']
              ['GetEnrollByCodeResult']['EnrollInfo'];
        }

        getEnrollmentResponse = GetEnrollmentResponse.fromJson(decodedData);

        // print(getEnrollmentResponse.enroll[0].groupId);
        // print(getEnrollmentResponse.enroll[0].blacklisted);

        localStorage
            .saveEnrolledGroupId(getEnrollmentResponse.enroll[0].groupId);
        localStorage
            .saveBlacklisted(getEnrollmentResponse.enroll[0].blacklisted);

        return Response(true, data: getEnrollmentResponse.enroll);
      }
    }

    return Response(false);
  }

  // now using getenrolledbycode
  Future<Response> getEnrolledClasses() async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    //  Temporarily use TBS as diCode
    String diCode = 'TBS';
    // String diCode = await localStorage.getDiCode();
    String groupId = await localStorage.getEnrolledGroupId();
    String icNo = await localStorage.getStudentIc();

    EnrolledClassesRequest enrolledClassesRequest = EnrolledClassesRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      icNo: icNo,
      groupId: groupId,
    );

    Map<String, String> param = enrolledClassesRequest.toJson();

    String method = 'GetStuPracByCode';

    var response = await networking.getData(method: method, param: param);

    Map<String, dynamic> classesData;

    String encodeData;
    String processedData;
    var decodedData;

    EnrolledClassesResponse enrolledClassesResponse;

    if (response.isSuccess) {
      if (response.data != null &&
          response.data['GetStuPracByCodeResponse']['GetStuPracByCodeResult']
                  ['StuPracInfo'] !=
              null) {
        //  if response.data is not a list of object
        if (response.data['GetStuPracByCodeResponse']['GetStuPracByCodeResult']
                ['StuPracInfo']['StuPrac'][0] ==
            null) {
          classesData = response.data['GetStuPracByCodeResponse']
              ['GetStuPracByCodeResult']['StuPracInfo']['StuPrac'];

          encodeData = '{"StuPrac": [${jsonEncode(classesData)}]}';
          processedData = encodeData.replaceAll('null', '""');
          decodedData = jsonDecode(processedData);
        }
        // if response.data is a list of object
        else {
          decodedData = response.data['GetStuPracByCodeResponse']
              ['GetStuPracByCodeResult']['StuPracInfo'];
        }

        enrolledClassesResponse = EnrolledClassesResponse.fromJson(decodedData);

        return Response(true, data: enrolledClassesResponse.stuPrac);
      }
    }

    return Response(false);
  }

  Future<Response> getStudentPayment() async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    //  Temporarily use TBS as diCode
    String diCode = 'TBS';
    // String diCode = await localStorage.getDiCode();
    String icNo = await localStorage.getStudentIc();

    StudentPaymentRequest studentPaymentRequest = StudentPaymentRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      icNo: icNo,
    );

    Map<String, String> param = studentPaymentRequest.toJson();

    String method = 'GetCollectionByStudent';

    var response = await networking.getData(method: method, param: param);

    Map<String, dynamic> paymentData;

    String encodeData;
    String processedData;
    var decodedData;

    StudentPaymentResponse studentPaymentResponse;

    if (response.isSuccess) {
      if (response.data != null &&
          response.data['GetCollectionByStudentResponse']
                  ['GetCollectionByStudentResult']['PaymentInfo'] !=
              null) {
        //  if response.data is not a list of object
        if (response.data['GetCollectionByStudentResponse']
                    ['GetCollectionByStudentResult']['PaymentInfo']
                ['CollectTrn'][0] ==
            null) {
          paymentData = response.data['GetCollectionByStudentResponse']
              ['GetCollectionByStudentResult']['PaymentInfo']['CollectTrn'];

          encodeData = '{"CollectTrn": [${jsonEncode(paymentData)}]}';
          processedData = encodeData.replaceAll('null', '""');
          decodedData = jsonDecode(processedData);
        }
        // if response.data is a list of object
        else {
          decodedData = response.data['GetCollectionByStudentResponse']
              ['GetCollectionByStudentResult']['PaymentInfo'];
        }

        studentPaymentResponse = StudentPaymentResponse.fromJson(decodedData);

        return Response(true, data: studentPaymentResponse.collectTrn);
      }
    }

    return Response(false);
  }

  Future<Response> getStudentAttendance() async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    //  Temporarily use TBS as diCode
    String diCode = 'TBS';
    // String diCode = await localStorage.getDiCode();
    String groupId = await localStorage.getEnrolledGroupId();
    String icNo = await localStorage.getStudentIc();

    StudentAttendanceRequest studentAttendanceRequest =
        StudentAttendanceRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      icNo: icNo,
      groupId: groupId,
    );

    Map<String, String> param = studentAttendanceRequest.toJson();

    String method = 'GetDTestByCode';

    var response = await networking.getData(method: method, param: param);

    Map<String, dynamic> attendanceData;

    String encodeData;
    String processedData;
    var decodedData;

    StudentAttendanceResponse studentAttendanceResponse;

    if (response.isSuccess) {
      if (response.data != null &&
          response.data['GetDTestByCodeResponse']['GetDTestByCodeResult']
                  ['DTestInfo'] !=
              null) {
        //  if response.data is not a list of object
        if (response.data['GetDTestByCodeResponse']['GetDTestByCodeResult']
                ['DTestInfo']['DTest'][0] ==
            null) {
          attendanceData = response.data['GetDTestByCodeResponse']
              ['GetDTestByCodeResult']['DTestInfo']['DTest'];

          encodeData = '{"DTest": [${jsonEncode(attendanceData)}]}';
          processedData = encodeData.replaceAll('null', '""');
          decodedData = jsonDecode(processedData);
        }
        // if response.data is a list of object
        else {
          decodedData = response.data['GetDTestByCodeResponse']
              ['GetDTestByCodeResult']['DTestInfo'];
        }

        studentAttendanceResponse =
            StudentAttendanceResponse.fromJson(decodedData);

        return Response(true, data: studentAttendanceResponse.dTest);
      }
    }

    return Response(false);
  }

/*   Future<Response> getStudentEtestingLog() async {
    String params =
        'GetStudentFullLogByCode?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${credentials.caUid}&caPwd=${credentials.caPwdUrlEncode}';

    var response = await networking.getData(path: params);

    var responseData = response;
  } */
}
