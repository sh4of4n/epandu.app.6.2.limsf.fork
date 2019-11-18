import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

import 'model/login_model.dart';

part 'api.g.dart';

@RestApi()
abstract class Api {
  factory Api(Dio dio) = _Api;

  @GET("GetUserByUserPhonePwd")
  Future<dynamic> login(@Body() LoginRequest params);
}

// xml2json toParker
