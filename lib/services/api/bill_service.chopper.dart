// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$BillService extends BillService {
  _$BillService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = BillService;

  @override
  Future<Response> getTelco(
      {String wsCodeCrypt,
      String caUid,
      String caPwd,
      String businessType,
      String userId}) {
    final $url =
        '/MemberService.asmx/GetAllTelco?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&businessType=$businessType&userId=$userId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getService(
      {String wsCodeCrypt,
      String caUid,
      String caPwd,
      String businessType,
      String userId}) {
    final $url =
        '/MemberService.asmx/GetAllService?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&businessType=$businessType&userId=$userId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getCharges(
      {String wsCodeCrypt, String caUid, String caPwd, String service}) {
    final $url =
        '/MemberService.asmx/GetBillPaymentChargeByServiceXML?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&service=$service';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> verifyTrx(dynamic body) {
    final $url = '/MemberService.asmx/CheckAgentMobileTopUpPin';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> checkDistributor(dynamic body) {
    final $url = '/MemberService.asmx/IsDistributorAirtimeSufficient';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> checkArmaster(dynamic body) {
    final $url = '/MemberService.asmx/IsArmasterAirtimeSufficient';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> topUp(dynamic body) {
    final $url = '/MemberService.asmx/TopUpSubscriberAirtime';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
