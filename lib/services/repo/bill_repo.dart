import 'dart:convert';

import 'package:epandu/services/api/bill_service.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/model/bill_model.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class BillRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final postApiService = BillService;
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  Future<Response> getTelco({context}) async {
    // final String userId = await localStorage.getUserId();
    final String caUid = appConfig.eWalletCaUid;
    final String caPwd = Uri.encodeQueryComponent(appConfig.eWalletCaPwd);
    final String businessType = appConfig.businessTypePass;
    var responseData;
    Box<dynamic> telcoList = Hive.box('telcoList');

    var response =
        await Provider.of<BillService>(context, listen: false).getTelco(
      wsCodeCrypt: 'CARSERWS',
      caUid: caUid,
      caPwd: caPwd,
      businessType: businessType,
      userId: '8435615081',
    );

    if (response.body != 'null' && response.statusCode == 200) {
      Map<String, dynamic> mapData =
          jsonDecode(response.body.replaceAll(exp, ''));

      GetTelcoResponse getTelcoResponse = GetTelcoResponse.fromJson(mapData);

      responseData = getTelcoResponse.telcoComm;

      if (responseData != null) {
        telcoList.put('telcoList', responseData);

        return Response(true, data: responseData);
      }
    }

    return Response(false, data: response.error.toString());
  }

  Future<Response> getService({context}) async {
    // final String userId = await localStorage.getUserId();
    final String caUid = appConfig.eWalletCaUid;
    final String caPwd = Uri.encodeQueryComponent(appConfig.eWalletCaPwd);
    final String businessType = appConfig.businessTypePass;
    var responseData;
    Box<dynamic> serviceList = Hive.box('serviceList');

    var response =
        await Provider.of<BillService>(context, listen: false).getService(
      wsCodeCrypt: 'CARSERWS',
      caUid: caUid,
      caPwd: caPwd,
      businessType: businessType,
      userId: '8435615081',
    );

    if (response.body != 'null' && response.statusCode == 200) {
      Map<String, dynamic> mapData = jsonDecode(response.body
          .replaceAll(exp, '')
          .replaceAll('TelcoComm', 'ServiceComm'));

      GetServiceResponse getServiceResponse =
          GetServiceResponse.fromJson(mapData);

      responseData = getServiceResponse.serviceComm;

      if (responseData != null) {
        serviceList.put('serviceList', responseData);

        return Response(true, data: responseData);
      }
    }

    return Response(false, data: response.error.toString());
  }
}
