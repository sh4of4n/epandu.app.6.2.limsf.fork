import 'dart:convert';

import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/api/model/kpp_model.dart';
import 'package:epandu/services/api/networking.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';

class KppRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  // was getExamNo
  Future<Response> getTheoryQuestionPaperNoWithCreditControl(
      {context, groupId}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    String courseCode = 'KPP1';
    String langCode = 'ms-MY';

    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();
    String userPhone = await localStorage.getUserPhone();
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

    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return Response(false,
        message: response.message
            .toString()
            .replaceAll(exp, '')
            .replaceAll('&#xD;', '')
            .replaceAll('[BLException]', ''));
  }

  // was getTheoryQuestionByPaper
  Future<Response> getTheoryQuestionByPaper({context, groupId, paperNo}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
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
        message: AppLocalizations.of(context).translate('timeout_exception'));
  }

  Future<Response> pinActivation({context, pinNumber, groupId}) async {
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

    if (response.isSuccess && response.data != 'null') {
      return Response(true);
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
