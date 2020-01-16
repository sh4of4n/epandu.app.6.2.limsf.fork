import 'package:chopper/chopper.dart';

part 'get_base_url.chopper.dart';

@ChopperApi()
abstract class GetBaseUrl extends ChopperService {
  static GetBaseUrl create() {
    final client = ChopperClient(
      services: [
        _$GetBaseUrl(),
      ],
      converter: JsonConverter(),
      interceptors: [
        HeadersInterceptor({'Cache-Control': 'no-cache'}),
        HttpLoggingInterceptor(),
        CurlInterceptor(),
        (Request request) async {
          if (request.method == HttpMethod.Post) {
            chopperLogger.info('Performed a POST request');
          } else if (request.method == HttpMethod.Get) {
            chopperLogger.info('Performed a GET request');
          }
          return request;
        },
        (Response response) async {
          if (response.statusCode != 200) {
            chopperLogger.severe('${response.statusCode}');
          }
          return response;
        },
      ],
    );

    return _$GetBaseUrl(client);
  }

  // auth_repo
  @Get(
      path:
          '{baseUrl}/LoginPub?wsCodeCrypt={wsCodeCrypt}&acctUid={acctUid}&acctPwd={acctPwd}&loginType={loginType}&misc={misc}')
  Future<Response> getWsUrl({
    @Path('baseUrl') String baseUrl,
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('acctUid') String acctUid,
    @Path('acctPwd') String acctPwd,
    @Path('loginType') String loginType,
    @Path('misc') String misc,
  });
}
