import 'dart:async';
import 'dart:io';

import '../response.dart';

class BaseRepo {
  handleError(error, stackTrace) {
    if (error is TimeoutException) {
      return Response(false,
          message: 'Connection timed out. Please try again.');
    } else if (error is SocketException) {
      return Response(false,
          message: 'An error occurred. Please try again later.');
    } else if (error is FormatException) {
      return Response(false,
          message: 'Server error, we apologize for any inconvenience.');
    } else if (error is HttpException) {
      return Response(false, message: 'Please verify your client account.');
    }
    return Response(false, message: error.message);
  }
}
