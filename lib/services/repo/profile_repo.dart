import 'package:epandu/services/result.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/networking.dart';
import 'package:epandu/services/api/model/profile_model.dart';

class ProfileRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  Future getStudentProfile() async {
    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();

    String params =
        'GetUserRegisteredDI?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${appConfig.caUid}&caPwd=${appConfig.caPwdUrlEncode}&diCode=$diCode&userId=$userId';

    var response = await networking.getData(path: params);
  }

  Future getStudentProfilePicture() async {}
}
