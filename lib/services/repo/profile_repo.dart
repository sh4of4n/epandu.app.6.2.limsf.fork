import 'package:epandu/services/result.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/networking.dart';
import 'package:epandu/services/api/model/profile_model.dart';

class ProfileRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  /* Future getStudentProfile() async {
    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();

    String params =
        'GetUserRegisteredDI?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${appConfig.caUid}&caPwd=${appConfig.caPwdUrlEncode}&diCode=$diCode&userId=$userId';

    var response = await networking.getData(path: params);
  }

  Future getStudentProfilePicture() async {} */

  Future<Result> getCustomerData() async {
    String diCode = await localStorage.getDiCode();
    String icNo = await localStorage.getStudentIc();

    String params =
        'GetCustomerByCode?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${appConfig.caUid}&caPwd=${appConfig.caPwdUrlEncode}&diCode=$diCode&icNo=$icNo';

    var response = await networking.getData(path: params);

    var responseData = response;
  }

  // Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.
  Future<Result> getStudentPayment() async {
    String diCode = await localStorage.getDiCode();
    String icNo = await localStorage.getStudentIc();

    String params =
        'GetCollectionByStudent?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${appConfig.caUid}&caPwd=${appConfig.caPwdUrlEncode}&diCode=$diCode&icNo=$icNo';

    var response = await networking.getData(path: params);

    var responseData = response;
  }

  // Unknown column 'StuPrac.di_code' in 'where clause'
  Future<Result> getStudentAttendance() async {
    String diCode = await localStorage.getDiCode();
    String groupId;
    String icNo = await localStorage.getStudentIc();

    String params =
        'GetStuPracByCode?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${appConfig.caUid}&caPwd=${appConfig.caPwdUrlEncode}&diCode=$diCode&icNo=$icNo&groupId=$groupId';

    var response = await networking.getData(path: params);

    var responseData = response;
  }

/*   Future<Result> getStudentEtestingLog() async {
    String params =
        'GetStudentFullLogByCode?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${appConfig.caUid}&caPwd=${appConfig.caPwdUrlEncode}';

    var response = await networking.getData(path: params);

    var responseData = response;
  } */

  Future<Result> getBookingTest(groupId) async {
    String diCode = await localStorage.getDiCode();
    String icNo = await localStorage.getStudentIc();

    String params =
        'GetDTestByCode?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${appConfig.caUid}&caPwd=${appConfig.caPwdUrlEncode}&diCode=$diCode&icNo=$icNo&groupId=$groupId';

    var response = await networking.getData(path: params);

    var responseData = response;
  }
}
