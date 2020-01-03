import 'dart:convert';

import 'package:epandu/services/api/model/kpp_model.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/networking.dart';

class KppRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  Future<Response> getInstituteLogo() async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();

    Map<String, String> param = {
      'wsCodeCrypt': appConfig.wsCodeCrypt,
      'caUid': caUid,
      'caPwd': caPwd,
      'diCode': diCode,
      'userId': userId,
    };

    String method = 'GetArmasterAppPhotoForCode';

    var response = await networking.getData(method: method, param: param);

    var responseData = response.data['GetArmasterAppPhotoForCodeResponse']
        ['GetArmasterAppPhotoForCodeResult']['ArmasterInfo'];

    if (responseData != null) {
      localStorage
          .saveInstituteLogo(responseData['Armaster']['app_background_photo']);

      return Response(true,
          data: responseData['Armaster']['app_background_photo']);
    }
    return Response(false, message: response.message);
  }

  Future<Response> getExamNo(groupId) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    String courseCode = 'KPP1';
    String langCode = 'ms-MY';

    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();
    String userPhone = await localStorage.getUserPhone();
    String phone = userPhone.substring(2);

    /* Map<String, String> param = {
      'wsCodeCrypt': appConfig.wsCodeCrypt,
      'caUid': caUid,
      'caPwd': caPwd,
      'groupId': groupId,
      'courseCode': courseCode,
      'langCode': langCode,
    };

    String method = 'GetTheoryQuestionPaperNo'; */

    Map<String, String> param = {
      'wsCodeCrypt': appConfig.wsCodeCrypt,
      'caUid': caUid,
      'caPwd': caPwd,
      'diCode': diCode,
      'groupId': groupId,
      'courseCode': courseCode,
      'langCode': langCode,
      'phone': phone,
      'userId': userId,
    };

    String method = 'GetTheoryQuestionPaperNoWithCreditControl';

    var response = await networking.getData(method: method, param: param);

    if (response.isSuccess) {
      var responseData =
          response.data['GetTheoryQuestionPaperNoWithCreditControlResponse']
                  ['GetTheoryQuestionPaperNoWithCreditControlResult']
              ['TheoryQuestionInfo'];

      if (responseData != null) {
        return Response(true, data: responseData);
      }
    }

    return Response(false,
        message: response.data['string'].replaceAll(r'\r\n', ''));
  }

  Future<Response> getExamQuestions({groupId, paperNo}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    // String caPwdUrlEncode = await localStorage.getCaPwdEncode();

    String courseCode = 'KPP1';
    String langCode = 'ms-MY';

    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();
    String userPhone = await localStorage.getUserPhone();
    String phone = userPhone.substring(2);

    /* Map<String, String> param = {
      'wsCodeCrypt': appConfig.wsCodeCrypt,
      'caUid': caUid,
      'caPwd': caPwd,
      'diCode': diCode,
      'groupId': groupId,
      'courseCode': courseCode,
      'langCode': langCode,
      'paperNo': paperNo,
      'phone': phone,
      'userId': userId,
    };

    String method = 'GetTheoryQuestionByPaperWithCreditControl';

    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await networking.getRequest(
        method: method, param: param, headers: headers);

    if (response.isSuccess) {
      var responseData = response.data['GetTheoryQuestionByPaperResponse']
          ['GetTheoryQuestionByPaperResult']['TheoryQuestionInfo'];

      if (responseData != null) {
        return Response(true, data: responseData);
      }
    }

    return Response(false, message: response.message); */

    Map<String, String> param = {
      'wsCodeCrypt': appConfig.wsCodeCrypt,
      'caUid': caUid,
      'caPwd': caPwd,
      'groupId': groupId,
      'courseCode': courseCode,
      'langCode': langCode,
      'paperNo': paperNo,
    };

    String method = 'GetTheoryQuestionByPaper';

    var response = await networking.getData(method: method, param: param);

    var responseData = response.data['GetTheoryQuestionByPaperResponse']
        ['GetTheoryQuestionByPaperResult']['TheoryQuestionInfo'];

    if (responseData != null) {
      return Response(true, data: responseData);
    }
    return Response(false, message: response.message);
  }

  Future<Response> pinActivation(pinNumber, groupId) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();
    String userPhone = await localStorage.getUserPhone();

    PinRequest pinRequest = PinRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      pinNumber: pinNumber,
      diCode: diCode,
      phone: userPhone.substring(2),
      userId: userId,
      groupId: groupId,
      courseCode: 'KPP1',
    );

    String body = jsonEncode(pinRequest);

    String api = 'PinActivation';

    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess) {
      var result = await getExamNo(groupId);

      return result;
    }

    return Response(false,
        message: response.message
            .replaceAll(r'\u000d\u000a', '')
            .replaceAll(r'"', ''));
  }
}
