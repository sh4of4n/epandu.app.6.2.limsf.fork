import 'dart:convert';

import 'package:epandu/services/api/networking.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/model/pickup_model.dart';

import '../../app_localizations.dart';

class PickupRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  Future<Response> getPickUpByIcNo({context}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String diCode = await localStorage.getDiCode();
    String icNo = await localStorage.getStudentIc();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&icNo=$icNo';

    var response = await networking.getData(
      path: 'GetPickUpByIcNo?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetPickUpByIcNoResponse getPickUpByIcNoResponse =
          GetPickUpByIcNoResponse.fromJson(response.data);

      return Response(true, data: getPickUpByIcNoResponse.pickup);
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
        message: AppLocalizations.of(context).translate('no_records_found'));
  }

  Future<Response> savePickup({
    context,
    pickupDate,
    pickupTime,
    destination,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String diCode = await localStorage.getDiCode();
    String icNo = await localStorage.getStudentIc();
    String userId = await localStorage.getUserId();

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
        message: response.message.replaceAll(r'\u000d\u000a', ''));
  }
}
