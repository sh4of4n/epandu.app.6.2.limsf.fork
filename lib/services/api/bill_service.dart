import 'dart:io';
import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart' as http;

part 'bill_service.chopper.dart';

@ChopperApi()
abstract class BillService extends ChopperService {
  static BillService create() {
    final client = ChopperClient(
      client: http.IOClient(
        HttpClient()..connectionTimeout = const Duration(seconds: 60),
      ),
      // The first part of the URL is now here
      services: [
        // The generated implementation
        _$BillService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
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

    // The generated class with the ChopperClient passed in
    return _$BillService(client);
  }

  @Get(
      path:
          'https://tbsweb.tbsdns.com/eCarser.WebService/1_9/MemberService.asmx/GetAllTelco?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&businessType={businessType}&userId={userId}')
  Future<Response> getTelco({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('businessType') String businessType,
    @Path('userId') String userId,
  });

  @Get(
      path:
          'https://tbsweb.tbsdns.com/eCarser.WebService/1_9/MemberService.asmx/GetAllService?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&businessType={businessType}&userId={userId}')
  Future<Response> getService({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('businessType') String businessType,
    @Path('userId') String userId,
  });

  @Get(
      path:
          'https://tbsweb.tbsdns.com/eCarser.WebService/1_9/MemberService.asmx/GetBillPaymentChargeByServiceXML?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&service={service}')
  Future<Response> getCharges({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('service') String service,
  });

  @Post(
      path:
          'https://tbsweb.tbsdns.com/eCarser.WebService/1_9/MemberService.asmx/CheckAgentMobileTopUpPin')
  Future<Response> verifyTrx(@Body() var body);

  @Post(
      path:
          'https://tbsweb.tbsdns.com/eCarser.WebService/1_9/MemberService.asmx/IsDistributorAirtimeSufficient')
  Future<Response> checkDistributor(@Body() var body);

  @Post(
      path:
          'https://tbsweb.tbsdns.com/eCarser.WebService/1_9/MemberService.asmx/IsArmasterAirtimeSufficient')
  Future<Response> checkArmaster(@Body() var body);

  @Post(
      path:
          'https://tbsweb.tbsdns.com/eCarser.WebService/1_9/MemberService.asmx/TopUpSubscriberAirtime')
  Future<Response> topUp(@Body() var body);
}
