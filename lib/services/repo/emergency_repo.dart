import 'package:epandu/services/api/model/emergency_model.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/networking.dart';

class EmergencyRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  // GetDefaultSosContact
  Future<Response> getDefEmergencyContact() async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    Map<String, String> param = {
      'wsCodeCrypt': appConfig.wsCodeCrypt,
      'caUid': caUid,
      'caPwd': caPwd,
    };

    String method = 'GetDefaultSosContact';

    DefaultEmergencyContactResponse defEmergencyContactResponse;

    var response = await networking.getData(method: method, param: param);

    if (response.isSuccess) {
      if (response.data != null) {
        defEmergencyContactResponse =
            DefaultEmergencyContactResponse.fromJson(response.data);

        return Response(true,
            data: defEmergencyContactResponse
                .getDefaultSosContactResult.sosContactInfo.sosContactHelpDesk);
      }
    }

    return Response(false);
  }

  // GetSosContact
  Future<Response> getEmergencyContact(
      {sosContactType, sosContactCode, areaCode}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    EmergencyContactRequest emergencyContactRequest = EmergencyContactRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      sosContactType: sosContactType ?? '',
      sosContactCode: sosContactCode ?? '',
      areaCode: areaCode ?? '',
    );

    Map<String, String> param = emergencyContactRequest.toJson();

    String method = 'GetSosContact';

    DefaultEmergencyContactResponse defEmergencyContactResponse;

    var response = await networking.getData(method: method, param: param);

    if (response.isSuccess) {
      if (response.data != null) {
        defEmergencyContactResponse =
            DefaultEmergencyContactResponse.fromJson(response.data);

        return Response(true,
            data: defEmergencyContactResponse
                .getDefaultSosContactResult.sosContactInfo.sosContactHelpDesk);
      }
    }

    return Response(false);
  }

  // SendGpsSos

}
