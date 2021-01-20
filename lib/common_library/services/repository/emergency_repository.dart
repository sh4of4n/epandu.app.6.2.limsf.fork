import 'package:flutter/material.dart';

import '../../../utils/app_config.dart';
import '../../utils/local_storage.dart';
import '../model/emergency_model.dart';
import '../networking.dart';
import '../response.dart';

class EmergencyRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  // was getDefaultSosContact
  Future<Response> getDefaultSosContact({context}) async {
    assert(context != null);

    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd';

    var response = await networking.getData(
      path: 'GetDefaultSosContact?$path',
    );

    if (response.isSuccess && response.data != null) {
      DefaultEmergencyContactResponse defEmergencyContactResponse =
          DefaultEmergencyContactResponse.fromJson(response.data);

      return Response(true,
          data: defEmergencyContactResponse.sosContactHelpDesk);
    }

    return Response(false);
  }

  // was getSosContact
  // Future<Response> getSosContact(
  //     {context, sosContactType, sosContactCode, areaCode}) async {
  //   // Hive
  //   final emergencyContactBox = Hive.box('emergencyContact');

  //   String caUid = await localStorage.getCaUid();
  //   String caPwd = await localStorage.getCaPwd();

  //   var response =
  //       await Provider.of<ApiService>(context, listen: false).getSosContact(
  //     wsCodeCrypt: appConfig.wsCodeCrypt,
  //     caUid: caUid,
  //     caPwd: caPwd,
  //     sosContactType: sosContactType ?? '',
  //     sosContactCode: sosContactCode ?? '',
  //     areaCode: areaCode ?? '',
  //   );

  //   if (response.body != 'null' && response.statusCode == 200) {
  //     EmergencyContactResponse emergencyContactResponse =
  //         EmergencyContactResponse.fromJson(response.body);

  //     for (int i = 0; i < emergencyContactResponse.sosContact.length; i += 1) {
  //       double locLatitude =
  //           double.tryParse(emergencyContactResponse.sosContact[i].latitude);
  //       double locLongitude =
  //           double.tryParse(emergencyContactResponse.sosContact[i].longtitude);

  //       double locDistance = await Location()
  //           .getDistance(locLatitude: locLatitude, locLongitude: locLongitude);

  //       emergencyContactResponse.sosContact[i].distance =
  //           '${(locDistance / 1000).toStringAsFixed(2)}km';
  //     }

  //     var sortedResponse = await getSortedContacts(
  //         emergencyContacts: emergencyContactResponse.sosContact);

  //     // Store sortedResponse in hive box
  //     switch (sosContactType) {
  //       case 'POLICE':
  //         emergencyContactBox.put('policeContact', sortedResponse.data);
  //         break;
  //       case 'AMBULANCE':
  //         emergencyContactBox.put('ambulanceContact', sortedResponse.data);
  //         break;
  //       case 'EMBASSY':
  //         emergencyContactBox.put('embassyContact', sortedResponse.data);
  //     }

  //     return sortedResponse;
  //   }

  //   return Response(false);
  // }

  // Note: Some of the API return coordinates are invalid and
  // will cause distance to become 0.0 leading to incorrect sorting
  Future<Response> getSortedContacts(
      {List<SosContact> emergencyContacts}) async {
    emergencyContacts.sort((a, b) =>
        double.tryParse(a.distance.replaceAll('km', ''))
            .compareTo(double.tryParse(b.distance.replaceAll('km', ''))));

    return Response(true, data: emergencyContacts);
  }

  // GetSosContactNearest

  Future<Response> getSosContactSortByNearest({
    @required context,
    sosContactType,
    sosContactCode,
    areaCode,
    @required maxRadius,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String latitude = await localStorage.getUserLatitude();
    String longitude = await localStorage.getUserLongitude();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&sosContactType=${sosContactType ?? ''}&sosContactCode=${sosContactCode ?? ''}&areaCode=${areaCode ?? ''}&latitude=$latitude&longitude=$longitude&maxRadius=$maxRadius';

    var response = await networking.getData(
      path: 'GetSosContactSortByNearest?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetSosContactSortByNearestResponse getSosContactSortByNearestResponse =
          GetSosContactSortByNearestResponse.fromJson(response.data);

      return Response(true,
          data: getSosContactSortByNearestResponse.sosContact);
    }

    return Response(false, message: 'No facilities nearby.');
  }

  // SendGpsSos
  // ----------------

  Future<Response> getPandemicTrack({
    @required context,
    dateFromString,
    dateToString,
    phone,
    startIndex,
    noOfRecords,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String diCode = await localStorage.getDiCode();
    String merchantNo = await localStorage.getMerchantDbCode();
    String userId = await localStorage.getUserId();
    String deviceId = await localStorage.getLoginDeviceId();
    // String phoneCountryCode = await localStorage.getCountryCode();
    // String phone = await localStorage.getUserPhone();

    String path = 'wsCodeCrypt=${appConfig.wsCodeCrypt}' +
        '&caUid=$caUid' +
        '&caPwd=$caPwd' +
        '&diCode=$diCode' +
        '&phone=$phone' +
        '&dateFromString=$dateFromString' +
        '&dateToString=$dateToString' +
        '&startIndex=$startIndex' +
        '&noOfRecords=$noOfRecords' +
        '&merchantNo=$merchantNo' +
        '&userId=$userId' +
        '&appCode=${appConfig.appCode}' +
        '&appId=${appConfig.appId}' +
        '&deviceId=$deviceId';

    var response = await networking.getData(
      path: 'GetPandemicTrack?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetPandemicTrackResponse getPandemicTrackResponse =
          GetPandemicTrackResponse.fromJson(response.data);

      return Response(true, data: getPandemicTrackResponse.pandemicTrack);
    }

    return Response(false,
        message: 'Failed to load pandemic track list. Please try again later.');
  }

  Future<Response> getPandemicPDFReport({
    context,
    String diCode,
    String phone,
    String dateFromString,
    String dateToString,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String merchantNo = await localStorage.getMerchantDbCode();
    String userId = await localStorage.getUserId();
    String deviceId = await localStorage.getLoginDeviceId();

    String path = 'wsCodeCrypt=${appConfig.wsCodeCrypt}' +
        '&caUid=$caUid' +
        '&caPwd=$caPwd' +
        '&diCode=$diCode' +
        '&phone=$phone' +
        '&dateFromString=$dateFromString' +
        '&dateToString=$dateToString' +
        '&merchantNo=$merchantNo' +
        '&userId=$userId' +
        '&appCode=${appConfig.appCode}' +
        '&appId=${appConfig.appId}' +
        '&deviceId=$deviceId';

    var response = await networking.getData(
      path: 'GetPandemicPDFReport?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetPandemicPDFReportResponse getTemporaryReceiptPdfResponse =
          GetPandemicPDFReportResponse.fromJson(response.data);

      return Response(true,
          data: getTemporaryReceiptPdfResponse.pDF[0].fileName);
    }

    return Response(false,
        message: 'Failed to load pdf, please try again later.');
  }
}
