import 'dart:async';

import '../model/vclub_model.dart';
import '../networking.dart';
import '../response.dart';
import '../../../utils/app_config.dart';
import '../../utils/local_storage.dart';

class VclubRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  Future<Response> getMerchantType({
    context,
    keywordSearch,
    startIndex,
    noOfRecords,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwdEncode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&keywordSearch=$keywordSearch&startIndex=$startIndex&noOfRecords=$noOfRecords';

    var response = await networking.getData(
      path: 'GetMerchantType?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetMerchantTypeResponse getMerchantTypeResponse;

      getMerchantTypeResponse = GetMerchantTypeResponse.fromJson(response.data);

      return Response(true, data: getMerchantTypeResponse.merchantType);
    }

    return Response(false, message: 'No records found.');
  }

  Future<Response> getMerchant({
    context,
    merchantType,
    keywordSearch,
    startIndex,
    noOfRecords,
    latitude,
    longitude,
    maxRadius,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwdEncode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&merchantType=$merchantType&keywordSearch=$keywordSearch&startIndex=$startIndex&noOfRecords=$noOfRecords&latitude=$latitude&longitude=$longitude&maxRadius=$maxRadius';

    var response = await networking.getData(
      path: 'GetMerchant?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetMerchantResponse getMerchantResponse;

      getMerchantResponse = GetMerchantResponse.fromJson(response.data);

      return Response(true, data: getMerchantResponse.merchant);
    }

    return Response(false, message: 'No records found.');
  }
}
