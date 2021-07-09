import 'dart:convert';

import '../model/kpp_model.dart';
import '../networking.dart';
import '../response.dart';
import '../../../utils/app_config.dart';
import '../../utils/local_storage.dart';

class KppRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  Future<Response> getTheoryQuestionPaperNo({context, groupId}) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();

    String courseCode = 'KPP1';
    String langCode = 'ms-MY';

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&groupId=$groupId&courseCode=$courseCode&langCode=$langCode';

    var response = await networking.getData(
      path: 'GetTheoryQuestionPaperNo?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetPaperNoResponse getPaperNoResponse;

      getPaperNoResponse = GetPaperNoResponse.fromJson(response.data);

      return Response(true, data: getPaperNoResponse.paperNo);
    }

    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return Response(false,
        message: response.message
            .toString()
            .replaceAll(exp, '')
            .replaceAll('&#xD;', '')
            .replaceAll('[BLException]', ''));
  }

  Future<Response> getTheoryQuestionPaperNoWithCreditControl(
      {context, groupId}) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();

    String courseCode = 'KPP1';
    String langCode = 'ms-MY';

    String? userId = await localStorage.getUserId();
    String? diCode = await localStorage.getMerchantDbCode();
    String userPhone = (await localStorage.getCountryCode())! +
        (await localStorage.getUserPhone())!;
    String phone = userPhone.substring(2);

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&groupId=$groupId&courseCode=$courseCode&langCode=$langCode&phone=$phone&userId=$userId';

    var response = await networking.getData(
      path: 'GetTheoryQuestionPaperNoWithCreditControl?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetPaperNoResponse getPaperNoResponse;

      getPaperNoResponse = GetPaperNoResponse.fromJson(response.data);

      return Response(true, data: getPaperNoResponse.paperNo);
    }

    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return Response(false,
        message: response.message
            .toString()
            .replaceAll(exp, '')
            .replaceAll('&#xD;', '')
            .replaceAll('[BLException]', ''));
  }

  Future<Response> getTheoryQuestionByPaper({context, groupId, paperNo}) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwdEncode();
    // String caPwdUrlEncode = await localStorage.getCaPwdEncode();
    String courseCode = 'KPP1';
    String langCode = 'ms-MY';

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&groupId=$groupId&courseCode=$courseCode&langCode=$langCode&paperNo=$paperNo';

    var response = await networking.getData(
      path: 'GetTheoryQuestionByPaper?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetTheoryQuestionByPaperResponse getTheoryQuestionByPaperResponse;

      getTheoryQuestionByPaperResponse =
          GetTheoryQuestionByPaperResponse.fromJson(response.data);

      return Response(true,
          data: getTheoryQuestionByPaperResponse.theoryQuestion);
    }

    return Response(false, message: 'Request timed out.');
  }

  Future<Response> pinActivation({context, pinNumber, groupId}) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? userId = await localStorage.getUserId();
    String? diCode = await localStorage.getMerchantDbCode();
    String userPhone = (await localStorage.getCountryCode())! +
        (await localStorage.getUserPhone())!;

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

    if (response.isSuccess && response.data != 'null') {
      return Response(true);
    }

    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return Response(false,
        message: response.message
            .toString()
            .replaceAll(exp, '')
            .replaceAll('&#xD;', '')
            .replaceAll('[BLException]', '')
            .replaceAll(r'\u000d\u000a', '')
            .replaceAll(r'"', ''));
  }
}
