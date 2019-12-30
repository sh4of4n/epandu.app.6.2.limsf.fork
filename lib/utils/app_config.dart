import 'local_storage.dart';

class AppConfig {
  final LocalStorage localStorage = LocalStorage();

  String wsCodeCrypt = 'EPANDU';

  String diCode = 'TBS';

  Future<String> getBaseUrl() async {
    String type = await localStorage.getServerType();
    String wsUrl = await localStorage.getWsUrl();
    String url;

    // String caUidEncode = Uri.encodeFull(caUid);

    if (type == 'DEVP' && wsUrl.isEmpty)
      url =
          'http://tbsweb.tbsdns.com/ePandu.Mainservice/1_2/MainService.svc/webapi/';
    else if (type == 'PROD' && wsUrl.isEmpty)
      url = 'https://epandu.com/ePandu.MainService/1_2/MainService.svc/webapi/';
    else
      url = '$wsUrl/webapi/';

    return url;
  }
}
