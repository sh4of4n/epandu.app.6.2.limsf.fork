import 'package:epandu/services/result.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/networking.dart';

class KppRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  Future<Result> getInstituteLogo() async {
    String caUid = await localStorage.getCaUid();
    String caPwdUrlEncode = await localStorage.getCaPwdEncode();

    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();

    String params =
        'GetArmasterAppPhotoForCode?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwdUrlEncode&diCode=$diCode&userId=$userId';

    var response = await networking.getData(path: params);

    var responseData = response['GetArmasterAppPhotoForCodeResponse']
        ['GetArmasterAppPhotoForCodeResult']['ArmasterInfo'];

    if (responseData != null) {
      localStorage
          .saveInstituteLogo(responseData['Armaster']['app_background_photo']);

      return Result(true,
          data: responseData['Armaster']['app_background_photo']);
    }
    return Result(false);
  }

  Future<Result> getExamNo(groupId) async {
    String caUid = await localStorage.getCaUid();
    String caPwdUrlEncode = await localStorage.getCaPwdEncode();

    String courseCode = 'KPP1';
    String langCode = 'ms-MY';

    String params =
        'GetTheoryQuestionPaperNo?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwdUrlEncode&groupId=$groupId&courseCode=$courseCode&langCode=$langCode';

    var response = await networking.getData(path: params);

    var responseData = response['GetTheoryQuestionPaperNoResponse']
        ['GetTheoryQuestionPaperNoResult']['TheoryQuestionInfo'];

    if (responseData != null) {
      return Result(true, data: responseData);
    }
    return Result(false);
  }

  Future<Result> getExamQuestions({groupId, paperNo}) async {
    String caUid = await localStorage.getCaUid();
    String caPwdUrlEncode = await localStorage.getCaPwdEncode();

    String courseCode = 'KPP1';
    String langCode = 'ms-MY';

    String params =
        'GetTheoryQuestionByPaper?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwdUrlEncode&groupId=$groupId&courseCode=$courseCode&langCode=$langCode&paperNo=$paperNo';

    var response = await networking.getData(path: params);

    var responseData = response['GetTheoryQuestionByPaperResponse']
        ['GetTheoryQuestionByPaperResult']['TheoryQuestionInfo'];

    if (responseData != null) {
      return Result(true, data: responseData);
    }
    return Result(false);
  }
}
