import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

import 'model/auth_model.dart';

part 'api.g.dart';

@RestApi()
abstract class Api {
  factory Api(Dio dio) = _Api;

  @GET("GetUserByUserPhonePwd?{params}")
  Future<LoginResponse> login(@Path() String params);

  @GET("GetUserRegisteredDI?{params}")
  Future<UserRegisteredDiResponse> getUserRegisteredDi(@Path() String params);

  @GET("GetUserByUserPhone?{params}")
  Future<String> checkExistingUser(@Path() String params);

  @POST("CreateAppAccount")
  Future<String> register(@Body() RegisterRequest params);
}
