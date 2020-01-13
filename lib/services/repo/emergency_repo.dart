import 'package:epandu/services/api/model/emergency_model.dart';
import 'package:epandu/services/location.dart';
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
        defEmergencyContactResponse = DefaultEmergencyContactResponse.fromJson(
            response.data['GetDefaultSosContactResponse']
                ['GetDefaultSosContactResult']['SosContactInfo']);

        return Response(true,
            data: defEmergencyContactResponse.sosContactHelpDesk);
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

    EmergencyContactResponse emergencyContactResponse;

    var response = await networking.getData(method: method, param: param);

    if (response.isSuccess) {
      if (response.data != null) {
        emergencyContactResponse = EmergencyContactResponse.fromJson(
            response.data['GetSosContactResponse']['GetSosContactResult']
                ['SosContactInfo']);

        for (int i = 0;
            i < emergencyContactResponse.sosContact.length;
            i += 1) {
          double locLatitude =
              double.tryParse(emergencyContactResponse.sosContact[i].latitude);
          double locLongitude = double.tryParse(
              emergencyContactResponse.sosContact[i].longtitude);

          double locDistance = await Location().getDistance(
              locLatitude: locLatitude, locLongitude: locLongitude);

          // emergencyContactResponse.sosContact.insert(i, locDistance.toString());
        }

        /* emergencyContactResponse.sosContact.map((contact) {
          contact
        }); */

        return Response(true, data: emergencyContactResponse.sosContact);
      }
    }

    return Response(false);
  }

  // SendGpsSos

}
