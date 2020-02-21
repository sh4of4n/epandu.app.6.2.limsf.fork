import 'package:epandu/services/api/api_service.dart';
import 'package:epandu/services/api/model/profile_model.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:provider/provider.dart';

class ProfileRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();

  /* Future getStudentProfile() async {
    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();

    String params =
        'GetUserRegisteredDI?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${credentials.caUid}&caPwd=${credentials.caPwdUrlEncode}&diCode=$diCode&userId=$userId';

    var response = await networking.getData(path: params);
  }

  Future getStudentProfilePicture() async {} */

  // already obtained from getUserRegisteredDi
  /* Future<Response> getCustomerData() async {
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
  } */

  // was called getEnrollByCode
  Future<Response> getEnrollByCode({context}) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    //  Temporarily use TBS as diCode
    String diCode = 'TBS';
    // String diCode = await localStorage.getDiCode();
    String groupId = '';
    String icNo = await localStorage.getStudentIc();

    var response = await Provider.of<ApiService>(context).getEnrollByCode(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      icNo: icNo,
      groupId: groupId,
    );

    if (response.body != 'null') {
      GetEnrollmentResponse getEnrollmentResponse;

      getEnrollmentResponse = GetEnrollmentResponse.fromJson(response.body);

      // not relevant anymore as there could be more than one enrollment
      localStorage.saveEnrolledGroupId(getEnrollmentResponse.enroll[0].groupId);
      localStorage.saveBlacklisted(getEnrollmentResponse.enroll[0].blacklisted);

      return Response(true, data: getEnrollmentResponse.enroll);
    }

    return Response(false);
  }

  // now using GetEnrollByCode
  /* Future<Response> getEnrolledClasses() async {
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
  } */

  // was called getCollectionByStudent
  Future<Response> getCollectionByStudent({context}) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    //  Temporarily use TBS as diCode
    String diCode = 'TBS';
    // String diCode = await localStorage.getDiCode();
    String icNo = await localStorage.getStudentIc();

    var response =
        await Provider.of<ApiService>(context).getCollectionByStudent(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      icNo: icNo,
    );

    if (response.body != 'null') {
      StudentPaymentResponse studentPaymentResponse;

      studentPaymentResponse = StudentPaymentResponse.fromJson(response.body);

      return Response(true, data: studentPaymentResponse.collectTrn);
    }

    return Response(false);
  }

  // was getDTestByCode
  Future<Response> getDTestByCode({context}) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    //  Temporarily use TBS as diCode
    String diCode = 'TBS';
    // String diCode = await localStorage.getDiCode();
    String groupId = await localStorage.getEnrolledGroupId();
    String icNo = await localStorage.getStudentIc();

    var response = await Provider.of<ApiService>(context).getDTestByCode(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      icNo: icNo,
      groupId: groupId,
    );

    if (response.body != 'null') {
      StudentAttendanceResponse studentAttendanceResponse;

      studentAttendanceResponse =
          StudentAttendanceResponse.fromJson(response.body);

      return Response(true, data: studentAttendanceResponse.dTest);
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
