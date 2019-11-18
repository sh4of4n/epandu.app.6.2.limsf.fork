import 'package:dio/dio.dart';
import 'package:epandu/utils/constants.dart';
import 'dart:convert';

import 'api.dart';
import 'package:epandu/utils/app_config.dart';

class Networking {
  static Api getInstance() {
    return Api(_getDio());
  }

  static Dio _getDio() {
    var dio = Dio();
    dio.options.baseUrl = AppConfig.getBaseUrl();
    dio.interceptors.add(
        LogInterceptor(responseBody: true, requestHeader: true, error: true));
    dio.interceptors.add(InterceptorsWrapper(onResponse: (Response response) {
      if (response.data != null && response.data is String) {
        response.data = jsonDecode(response.data);
      }
      return response;
    }, onRequest: (RequestOptions options) {
      if (options.data != null) {
        Common.printWrapped('Request params: ' + jsonEncode(options.data));
      }
    }, onError: (DioError e) async {
      return e;
    }));

    return dio;
  }
}
