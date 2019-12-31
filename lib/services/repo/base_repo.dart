/* import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:epandu/utils/crash_report.dart';
import '../response.dart';

class BaseRepo {
  Response handleError(exception, stackTrace) {
    // CrashReport().logError(
    //     FlutterErrorDetails(exception: exception, stack: stackTrace));

    String errorMsg = "";
    if (exception is DioError) {
      errorMsg = exception.response?.statusCode == null
          ? exception.message
          : "HTTP Error: ${exception.response?.statusCode}";
    } else {
      errorMsg = exception?.toString();
    }
    return Response(false, message: errorMsg);
  }
}
 */
