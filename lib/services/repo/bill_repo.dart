import 'dart:convert';

import 'package:epandu/services/api/bill_service.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/model/bill_model.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';

class BillRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final postApiService = BillService;

  Future<Response> getTelco({context}) async {
    final String userId = await localStorage.getUserId();
    final String caUid = appConfig.eWalletCaUid;
    final String caPwd = Uri.encodeQueryComponent(appConfig.eWalletCaPwd);
    final String businessType = appConfig.businessTypePass;

    var response = await Provider.of<BillService>(context).getTelco(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      businessType: businessType,
      userId: userId,
    );

    print(response.body);

    // return Response(true, data: response.body);
  }

  Future<Response> getService({context}) async {
    final String userId = await localStorage.getUserId();
    final String caUid = appConfig.eWalletCaUid;
    final String caPwd = Uri.encodeQueryComponent(appConfig.eWalletCaPwd);
    final String businessType = appConfig.businessTypePass;

    var response = await Provider.of<BillService>(context).getService(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      businessType: businessType,
      userId: userId,
    );

    print(response.body);

    // return Response(true, data: response.body);
  }
}
