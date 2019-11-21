import 'package:dio/dio.dart';
import 'package:epandu/utils/constants.dart';
import 'dart:convert';

import 'api.dart';
import 'package:epandu/utils/app_config.dart';

class Networking {
  static Api getInstance({type}) {
    return Api(_getDio(type));
  }

  static Dio _getDio(type) {
    String url;

    if (type == 'EWALLET')
      url = AppConfig.eWalletUrl();
    else if (type == 'SOS')
      url = AppConfig.sosUrl();
    else
      url = AppConfig.getBaseUrl();

    var dio = Dio();
    // dio.options.headers = {};
    dio.options.baseUrl = url;
    dio.interceptors.add(
        LogInterceptor(responseBody: true, requestHeader: true, error: true));
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (Response response) {
          /* if (response.data != null && response.data is String) {
            response.data = jsonDecode(response.data);
          } */
          return response;
        },
        onRequest: (RequestOptions options) {
          if (options.data != null) {
            Common.printWrapped('Request params: ' + jsonEncode(options.data));
          }
        },
        onError: (DioError e) async {
          return e;
        },
      ),
    );

    return dio;
  }
}
