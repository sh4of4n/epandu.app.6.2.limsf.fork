import '../common_library/utils/local_storage.dart';

class AppConfig {
  final LocalStorage localStorage = LocalStorage();

  String wsCodeCrypt = 'EPANDU';

  String diCode = 'EPANDU';

  String businessTypePass = 'visa2u';

  String eWalletUrl =
      'https://tbsweb.tbsdns.com/eCarser.WebService/1_9/MemberService.asmx/';

  String eWalletCaUid = 'visa2u1';
  String eWalletCaPwd = 'visa2u';

  String appCode = 'EPANDU';
  String appId = 'ePandu.App';

  String wsVer = '6_1';
}
