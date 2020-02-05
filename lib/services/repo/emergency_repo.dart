import 'package:epandu/services/api/api_service.dart';
import 'package:epandu/services/api/model/emergency_model.dart';
import 'package:epandu/services/location.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class EmergencyRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();

  // GetDefaultSosContact
  Future<Response> getDefEmergencyContact({context}) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    var response =
        await Provider.of<ApiService>(context).getDefEmergencyContact(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
    );

    if (response.body != 'null' && response.statusCode == 200) {
      DefaultEmergencyContactResponse defEmergencyContactResponse =
          DefaultEmergencyContactResponse.fromJson(response.body);

      return Response(true,
          data: defEmergencyContactResponse.sosContactHelpDesk);
    }

    return Response(false);
  }

  // GetSosContact
  Future<Response> getEmergencyContact(
      {context, sosContactType, sosContactCode, areaCode}) async {
    // Hive
    final emergencyContactBox = Hive.box('emergencyContact');

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    var response = await Provider.of<ApiService>(context).getEmergencyContact(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      sosContactType: sosContactType ?? '',
      sosContactCode: sosContactCode ?? '',
      areaCode: areaCode ?? '',
    );

    if (response.body != 'null' && response.statusCode == 200) {
      EmergencyContactResponse emergencyContactResponse =
          EmergencyContactResponse.fromJson(response.body);

      for (int i = 0; i < emergencyContactResponse.sosContact.length; i += 1) {
        double locLatitude =
            double.tryParse(emergencyContactResponse.sosContact[i].latitude);
        double locLongitude =
            double.tryParse(emergencyContactResponse.sosContact[i].longtitude);

        double locDistance = await Location()
            .getDistance(locLatitude: locLatitude, locLongitude: locLongitude);

        emergencyContactResponse.sosContact[i].distance =
            '${(locDistance / 1000).toStringAsFixed(2)}km';
      }

      var sortedResponse = await getSortedContacts(
          emergencyContacts: emergencyContactResponse.sosContact);

      // Store sortedResponse in hive box
      switch (sosContactType) {
        case 'POLICE':
          emergencyContactBox.put('policeContact', sortedResponse.data);
          break;
        case 'AMBULANCE':
          emergencyContactBox.put('ambulanceContact', sortedResponse.data);
          break;
        case 'EMBASSY':
          emergencyContactBox.put('embassyContact', sortedResponse.data);
      }

      return sortedResponse;
    }

    return Response(false);
  }

  // Note: Some of the API return coordinates are invalid and
  // will cause distance to become 0.0 leading to incorrect sorting
  Future<Response> getSortedContacts(
      {List<SosContact> emergencyContacts}) async {
    emergencyContacts.sort((a, b) =>
        double.tryParse(a.distance.replaceAll('km', ''))
            .compareTo(double.tryParse(b.distance.replaceAll('km', ''))));

    return Response(true, data: emergencyContacts);
  }

  // SendGpsSos

}
