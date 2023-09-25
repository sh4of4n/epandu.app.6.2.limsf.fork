import 'dart:convert';
import '../../../utils/app_config.dart';
import '../../utils/local_storage.dart';
import '../model/bill_model.dart';
import '../networking.dart';
import '../response.dart';
import 'package:hive/hive.dart';

class BillRepo {
  final appConfig = AppConfig();
  final networking = Networking();
  final localStorage = LocalStorage();
  final url =
      'https://tbsweb.tbsdns.com/eCarser.WebService/1_9/MemberService.asmx/';
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  Future<Response> getTelco({context}) async {
    // final String userId = await localStorage.getUserId();
    final String caUid = appConfig.eWalletCaUid;
    final String caPwd = Uri.encodeQueryComponent(appConfig.eWalletCaPwd);
    final String businessType = appConfig.businessTypePass;
    List<TelcoComm>? responseData;
    Box<dynamic> telcoList = Hive.box('telcoList');

    String path =
        'wsCodeCrypt=CARSERWS&caUid=$caUid&caPwd=$caPwd&businessType=$businessType&userId=8435615081';

    var response = await Networking(customUrl: url).getData(
      path: 'GetAllTelco?$path',
    );

    if (response.isSuccess && response.data != 'null') {
      Map<String, dynamic> mapData =
          jsonDecode(response.data.replaceAll(exp, ''));

      GetTelcoResponse getTelcoResponse = GetTelcoResponse.fromJson(mapData);

      responseData = getTelcoResponse.telcoComm;

      if (responseData != null) {
        telcoList.put('telcoList', responseData);

        return Response(true, data: responseData);
      }
    }

    return Response(false, data: response.message);
  }

  Future<Response> getService({context}) async {
    // final String userId = await localStorage.getUserId();
    final String caUid = appConfig.eWalletCaUid;
    final String caPwd = Uri.encodeQueryComponent(appConfig.eWalletCaPwd);
    final String businessType = appConfig.businessTypePass;
    List<ServiceComm>? responseData;
    Box<dynamic> serviceList = Hive.box('serviceList');

    String path =
        'wsCodeCrypt=CARSERWS&caUid=$caUid&caPwd=$caPwd&businessType=$businessType&userId=8435615081';

    var response = await Networking(customUrl: url).getData(
      path: 'GetAllService?$path',
    );

    if (response.isSuccess && response.data != null) {
      Map<String, dynamic> mapData = jsonDecode(response.data
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

    return Response(false, data: response.message);
  }
}
