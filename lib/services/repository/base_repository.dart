import 'dart:async';
import 'dart:io';

import '../response.dart';

class BaseRepo {
  handleError(error) {
    if (error is TimeoutException) {
      return Response(false,
          message: 'Data took too long to load, please try again.');
    } else if (error is SocketException) {
      return Response(false,
          message: 'Our servers appear to be down. Please try again later.');
    } else if (error is FormatException) {
      return Response(false,
          message: 'Server error, we apologize for any inconvenience.');
    } else if (error is HttpException) {
      return Response(false, message: 'Please verify your client account.');
    }
    return Response(false, message: '');
  }
}
