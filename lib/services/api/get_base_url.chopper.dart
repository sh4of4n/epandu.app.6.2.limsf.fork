// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_base_url.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$GetBaseUrl extends GetBaseUrl {
  _$GetBaseUrl([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = GetBaseUrl;

  @override
  Future<Response> getWsUrl(
      {String baseUrl,
      String wsCodeCrypt,
      String acctUid,
      String acctPwd,
      String loginType,
      String misc}) {
    final $url =
        '$baseUrl/LoginPub?wsCodeCrypt=$wsCodeCrypt&acctUid=$acctUid&acctPwd=$acctPwd&loginType=$loginType&misc=$misc';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
