import 'dart:convert';

import 'package:epandu/services/api/model/profile_model.dart';
import 'package:epandu/services/api/networking.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';

import '../../app_localizations.dart';

class ProfileRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  Future<Response> saveUserProfile({
    context,
    String name,
    String address,
    String postcode,
    String state,
    String country,
    String email,
    String registerAs,
    String icNo,
    String nationality,
    String dateOfBirthString,
    String race,
    String nickName,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String diCode = await localStorage.getDiCode();
    String userId = await localStorage.getUserId();

    SaveProfileRequest params = SaveProfileRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      appCode: appConfig.appCode,
      appId: appConfig.appId,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode ?? appConfig.diCode,
      userId: userId,
      name: name,
      nickName: nickName ?? '',
      icNo: icNo ?? '',
      nationality: nationality ?? 'WARGANEGARA',
      dateOfBirthString: dateOfBirthString ?? '',
      race: race ?? '',
      address: address ?? '',
      postcode: postcode ?? '',
      state: state ?? '',
      country: country ?? '',
      email: email ?? '',
    );

    String body = jsonEncode(params);
    String api = 'SaveUserProfileWithIC';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    // Success
    if (response.isSuccess && response.data != null) {
      localStorage.saveBirthDate(dateOfBirthString ?? '');
      localStorage.saveStudentIc(icNo ?? '');
      localStorage.saveUsername(name ?? '');
      localStorage.saveEmail(email ?? '');
      localStorage.saveNickName(nickName ?? '');

      return Response(true,
          message: AppLocalizations.of(context).translate('profile_updated'));
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
        message: AppLocalizations.of(context).translate('profile_update_fail'));
  }
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

/*   Future<Response> getStudentEtestingLog() async {
    String params =
        'GetStudentFullLogByCode?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${credentials.caUid}&caPwd=${credentials.caPwdUrlEncode}';

    var response = await networking.getData(path: params);

    var responseData = response;
  } */
}
