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

    // Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await networking.getData(method: method, param: param);

    var responseData = response.data;
  }

  // Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.
  Future<Response> getStudentPayment() async {
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

    // Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await networking.getData(method: method, param: param);

    var responseData = response.data;
  }

  // Unknown column 'StuPrac.di_code' in 'where clause'
  Future<Response> getStudentAttendance() async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    //  Temporarily use TBS as diCode
    String diCode = 'TBS';
    // String diCode = await localStorage.getDiCode();
    String groupId;
    String icNo = await localStorage.getStudentIc();

    Map<String, String> param = {
      'wsCodeCrypt': appConfig.wsCodeCrypt,
      'caUid': caUid,
      'caPwd': caPwd,
      'diCode': diCode,
      'icNo': icNo,
      'groupId': groupId,
    };

    String method = 'GetDTestByCode';

    // Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await networking.getData(method: method, param: param);

    var responseData = response.data;
  }

/*   Future<Response> getStudentEtestingLog() async {
    String params =
        'GetStudentFullLogByCode?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${credentials.caUid}&caPwd=${credentials.caPwdUrlEncode}';

    var response = await networking.getData(path: params);

    var responseData = response;
  } */

  Future<Response> getBookingTest(groupId) async {
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
      'groupId': groupId,
    };

    String method = 'GetDTestByCode';

    // Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await networking.getData(method: method, param: param);

    var responseData = response.data;
  }
}
