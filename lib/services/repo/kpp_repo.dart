import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/api/api_service.dart';
import 'package:epandu/services/api/model/kpp_model.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:provider/provider.dart';

class KppRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();

  // was getArmasterAppPhotoForCode
  Future<Response> getArmasterAppPhotoForCode({context}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();

    var response = await Provider.of<ApiService>(context, listen: false)
        .getArmasterAppPhotoForCode(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      userId: userId,
    );

    if (response.body != 'null' && response.statusCode == 200) {
      InstituteLogoResponse instituteLogoResponse;

      instituteLogoResponse = InstituteLogoResponse.fromJson(response.body);

      localStorage.saveInstituteLogo(
          instituteLogoResponse.armaster[0].appBackgroundPhoto);

      return Response(true,
          data: instituteLogoResponse.armaster[0].appBackgroundPhoto);
    }

    return Response(false);
  }

  // was getTheoryQuestionPaperNoWithCreditControl
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

    var response = await Provider.of<ApiService>(context, listen: false)
        .getTheoryQuestionPaperNoWithCreditControl(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      groupId: groupId,
      courseCode: courseCode,
      langCode: langCode,
      phone: phone,
      userId: userId,
    );

    if (response.body != 'null' && response.statusCode == 200) {
      GetPaperNoResponse getPaperNoResponse;

      getPaperNoResponse = GetPaperNoResponse.fromJson(response.body);

      return Response(true, data: getPaperNoResponse.paperNo);
    }

    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return Response(false,
        message: response.error
            .toString()
            .replaceAll(exp, '')
            .replaceAll('&#xD;', '')
            .replaceAll('[BLException]', ''));
  }

  // was getTheoryQuestionByPaper
  Future<Response> getTheoryQuestionByPaper({context, groupId, paperNo}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    // String caPwdUrlEncode = await localStorage.getCaPwdEncode();
    String courseCode = 'KPP1';
    String langCode = 'ms-MY';

    var response = await Provider.of<ApiService>(context, listen: false)
        .getTheoryQuestionByPaper(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      groupId: groupId,
      courseCode: courseCode,
      langCode: langCode,
      paperNo: paperNo,
    );

    if (response.body != 'null' && response.statusCode == 200) {
      GetTheoryQuestionByPaperResponse getTheoryQuestionByPaperResponse;

      getTheoryQuestionByPaperResponse =
          GetTheoryQuestionByPaperResponse.fromJson(response.body);

      return Response(true,
          data: getTheoryQuestionByPaperResponse.theoryQuestion);
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

    var response = await Provider.of<ApiService>(context, listen: false)
        .pinActivation(pinRequest);

    if (response.body != 'null' && response.statusCode == 200) {
      return Response(true);
    }

    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return Response(false,
        message: response.error
            .toString()
            .replaceAll(exp, '')
            .replaceAll('&#xD;', '')
            .replaceAll('[BLException]', '')
            .replaceAll(r'\u000d\u000a', '')
            .replaceAll(r'"', ''));
  }
}
