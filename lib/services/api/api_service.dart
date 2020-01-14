import 'package:chopper/chopper.dart';
import 'package:epandu/services/api/model/auth_model.dart';
import 'package:epandu/utils/app_config.dart';

part 'api_service.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  final appConfig = AppConfig();

  @Get()
  Future<LoginResponse> login(@Path('params') var params);

  @Get(path: '/{id}')
  Future<Response> getPost(@Path('id') int id);

  @Post()
  Future<Response> postPost(
    @Body() Map<String, dynamic> body,
  );

  static ApiService create() async {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: await appConfig.getBaseUrl(),
      services: [
        // The generated implementation
        _$ApiService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$ApiService(client);
  }
}
