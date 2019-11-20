class AppConfig {
  String wsCodeCrypt = 'EPANDU';
  String caUid = 'epandu_devp_3';
  String caPwd = 'wTA@D@cUHR&3Mq@\$';
  String caPwdUrlEncode = 'wTA%40D%40cUHR%263Mq%40%24';
  String tbsEduCaUid = 'tbsedu1_devp';
  String tbsEduCaPwd = 'DJNTjwSxXb8v43ar';
  String businessTypePass = 'visa2u';
  String diCode = 'TBS';

  static String getBaseUrl() {
    return "http://tbsweb.tbsdns.com/ePandu.Mainservice/1_2/MainService.svc/webapi/";
  }

  String eWalletWsCodeCrypt = 'CARSERWS';
  String eWalletCaUid = 'visa2u';
  String eWalletCaPwd = 'visa2u';

  static String eWalletUrl() {
    return 'https://tbsweb.tbsdns.com/eCarser.WebService/1_9/MemberService.asmx/';
  }

  String sosCodeCrypt = 'TBSSOS';

  String sosCaUid = 'tbssos1_devp';
  String sosCaPwd = 'DJNTjwSxXb8v43ar';

  static String sosUrl() {
    return 'http://tbsweb.tbsdns.com/TbsSos.MainService/1_8/MainService.svc/webapi/';
  }
}
