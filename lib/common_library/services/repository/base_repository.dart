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
          message: 'Server is not available now. Pls try later.');
    } else if (error is HttpException) {
      return Response(false, message: 'Please verify your client account.');
    } else if (error.message
        .contains('Unable to connect to any of the specified MySQL hosts.')) {
      return Response(false,
          message: 'Server is not available now. Pls try later.');
    } else if (error.message.contains(
        'Could not connect to database server, please try again later!')) {
      return Response(false,
          message: 'Server is not available now. Pls try later.');
    }
    return Response(false, message: error.message);
  }
}
