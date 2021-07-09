import 'dart:convert';

import '../networking.dart';
import '../response.dart';
import '../../../utils/app_config.dart';
import '../../utils/local_storage.dart';
import '../model/pickup_model.dart';

class PickupRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  Future<Response> getPickUpByIcNo({context}) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwdEncode();
    String? diCode = await localStorage.getMerchantDbCode();
    String? icNo = await localStorage.getStudentIc();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&icNo=$icNo';

    var response = await networking.getData(
      path: 'GetPickUpByIcNo?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetPickUpByIcNoResponse getPickUpByIcNoResponse =
          GetPickUpByIcNoResponse.fromJson(response.data);

      return Response(true, data: getPickUpByIcNoResponse.pickup);
    }

    return Response(false, message: 'No records found.');
  }

  Future<Response> savePickup({
    context,
    pickupDate,
    pickupTime,
    destination,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? diCode = await localStorage.getMerchantDbCode();
    String? icNo = await localStorage.getStudentIc();
    String? userId = await localStorage.getUserId();

    SavePickupRequest savePickupRequest = SavePickupRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      pickupDate: pickupDate,
      pickupTime: pickupTime,
      destination: destination,
      icNo: icNo,
      userId: userId,
    );

    String body = jsonEncode(savePickupRequest);
    String api = 'SavePickUp';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data == 'True') {
      return Response(true);
    }

    return Response(false,
        message: response.message!.replaceAll(r'\u000d\u000a', ''));
  }
}
