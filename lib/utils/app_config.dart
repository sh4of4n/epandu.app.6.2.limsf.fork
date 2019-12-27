import 'package:epandu/services/api/model/auth_model.dart';
import 'package:epandu/services/api/model/credentials_model.dart';

import 'local_storage.dart';

class AppConfig {
  final LocalStorage localStorage = LocalStorage();
  final credentials = CredentialsModel();

  String wsCodeCrypt = 'EPANDU';

  String caUid = '';
  String caPwd = '';
  String caPwdUrlEncode = '';

  String diCode = 'TBS';

  getCredentials() async {
    String type = await localStorage.getServerType();
    String getCaUid = await localStorage.getCaUid();
    String getCaPwd = await localStorage.getCaPwd();
    String getCaPwdEncode = await localStorage.getCaPwdEncode();

    if (type == 'DEVP' && getCaUid.isEmpty) {
      credentials.setCredentials(
        codeCrypt: wsCodeCrypt,
        accId: 'epandu1_devp_3',
        accPwd: 'wTA@D@cUHR&3Mq@\$',
        accPwdUrlEncode: 'wTA%40D%40cUHR%263Mq%40%24',
      );

      caUid = 'epandu1_devp_3';
      caPwd = 'wTA@D@cUHR&3Mq@\$';
      caPwdUrlEncode = 'wTA%40D%40cUHR%263Mq%40%24';
    } else if (type == 'PROD' && getCaUid.isEmpty) {
      credentials.setCredentials(
        codeCrypt: wsCodeCrypt,
        accId: 'epandu_prod',
        accPwd: 'vWh7SmgDRJ%TW4xa',
        accPwdUrlEncode: 'vWh7SmgDRJ%25TW4xa',
      );

      caUid = 'epandu_prod';
      caPwd = 'vWh7SmgDRJ%TW4xa';
      caPwdUrlEncode = 'vWh7SmgDRJ%25TW4xa';
    } else {
      credentials.setCredentials(
        codeCrypt: wsCodeCrypt,
        accId: getCaUid,
        accPwd: getCaPwd,
        accPwdUrlEncode: getCaPwdEncode,
      );
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
