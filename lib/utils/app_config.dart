import 'local_storage.dart';

class AppConfig {
  final LocalStorage localStorage = LocalStorage();
  String wsCodeCrypt = 'EPANDU';

  // Dev
  // String caUid = 'epandu1_devp_3';
  // String caPwd = 'wTA@D@cUHR&3Mq@\$';
  // String caPwdUrlEncode = 'wTA%40D%40cUHR%263Mq%40%24';

  // Prod
  String caUid = 'epandu_prod';
  String caPwd = 'vWh7SmgDRJ%TW4xa';
  String caPwdUrlEncode = 'vWh7SmgDRJ%25TW4xa';

  String diCode = 'TBS';

  getCredentials() async {
    // await localStorage.reset();
    String type = await localStorage.getServerType();
    String getCaUid = await localStorage.getCaUid();
    String getCaPwd = await localStorage.getCaPwd();
    String getCaPwdEncode = await localStorage.getCaPwdEncode();

    if (type == 'DEVP' && getCaUid.isEmpty) {
      caUid = 'epandu1_devp_3';
      caPwd = 'wTA@D@cUHR&3Mq@\$';
      caPwdUrlEncode = 'wTA%40D%40cUHR%263Mq%40%24';
    } else if (type == 'PROD' && getCaUid.isEmpty) {
      caUid = 'epandu_prod';
      caPwd = 'vWh7SmgDRJ%TW4xa';
      caPwdUrlEncode = 'vWh7SmgDRJ%25TW4xa';
    } else {
      caUid = getCaUid;
      caPwd = getCaPwd;
      caPwdUrlEncode = getCaPwdEncode;
    }
  }

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
