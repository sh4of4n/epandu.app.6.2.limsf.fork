import 'preferences.dart';

class LocalStorage {
  static const String kLocale = 'LOCALE';
  static const String kWsUrl = 'WS_URL';
  static const String kCaUid = 'CAUID';
  static const String kCaPwd = 'CAPWD';
  static const String kCaPwdEncode = 'CAPWD_ENCODE';
  static const String kUserId = 'USER_ID';
  static const String kUsername = 'USERNAME';
  static const String kUserPhone = 'USER_PHONE';
  static const String kEmail = 'EMAIL';
  static const String kDiCode = 'DI_CODE';
  static const String kSessionId = 'SESSION_ID';
  static const String kNationality = 'NATIONALITY';
  static const String kGender = 'GENDER';
  static const String kAddress = 'ADDRESS';
  static const String kStudentIc = 'STUDENT_IC';
  static const String kState = 'STATE';
  static const String kCountry = 'COUNTRY';
  static const String kPostCode = 'POST_CODE';
  static const String kInstituteLogo = 'INSTITUTE_LOGO';
  static const String kEnrolledGroupId = 'ENROLLED_GROUP_ID';
  static const String kBlacklisted = 'BLACKLISTED';
  static const String kUserLatitude = 'LATITUDE';
  static const String kUserLongitude = 'LONGITUDE';

  Future<void> saveLocale(String locale) {
    return Preference.setString(kLocale, locale);
  }

  Future<String> getLocale() async {
    return Preference.getString(kLocale, def: 'en');
  }

  Future<void> saveWsUrl(String wsUrl) {
    return Preference.setString(kWsUrl, wsUrl);
  }

  Future<String> getWsUrl() async {
    return Preference.getString(kWsUrl, def: '');
  }

  Future<String> getCaUid() async {
    return Preference.getString(kCaUid, def: 'epandu_prod');
  }

  Future<void> saveCaUid(String caUid) async {
    return Preference.setString(kCaUid, caUid);
  }

  Future<String> getCaPwd() async {
    return Preference.getString(kCaPwd, def: 'vWh7SmgDRJ%TW4xa');
  }

  Future<void> saveCaPwd(String caPwd) async {
    return Preference.setString(kCaPwd, caPwd);
  }

  Future<String> getCaPwdEncode() async {
    return Preference.getString(kCaPwdEncode, def: 'vWh7SmgDRJ%25TW4xa');
  }

  Future<void> saveCaPwdEncode(String caPwdEncode) async {
    return Preference.setString(kCaPwdEncode, caPwdEncode);
  }

  Future<void> saveUserId(String userId) {
    return Preference.setString(kUserId, userId);
  }

  Future<String> getUserId() async {
    return Preference.getString(kUserId, def: '');
  }

  Future<void> saveUsername(String username) {
    return Preference.setString(kUsername, username);
  }

  Future<String> getUsername() async {
    return Preference.getString(kUsername, def: '');
  }

  Future<void> saveUserPhone(String userPhone) {
    return Preference.setString(kUserPhone, userPhone);
  }

  Future<String> getUserPhone() async {
    return Preference.getString(kUserPhone, def: '');
  }

  Future<void> saveEmail(String email) {
    return Preference.setString(kEmail, email);
  }

  Future<String> getEmail() async {
    return Preference.getString(kEmail, def: '');
  }

  Future<void> saveDiCode(String diCode) async {
    return Preference.setString(kDiCode, diCode);
  }

  Future<String> getDiCode() async {
    return Preference.getString(kDiCode, def: '');
  }

  Future<void> saveSessionId(String sessionId) async {
    return Preference.setString(kSessionId, sessionId);
  }

  Future<String> getSessionId() async {
    return Preference.getString(kSessionId, def: '');
  }

  Future<void> saveNationality(String nationality) async {
    return Preference.setString(kNationality, nationality);
  }

  Future<String> getNationality() async {
    return Preference.getString(kNationality, def: '');
  }

  Future<void> saveGender(String gender) async {
    return Preference.setString(kGender, gender);
  }

  Future<String> getGender() async {
    return Preference.getString(kGender, def: '');
  }

  Future<void> saveStudentIc(String icNo) async {
    return Preference.setString(kStudentIc, icNo);
  }

  Future<String> getStudentIc() async {
    return Preference.getString(kStudentIc, def: '');
  }

  Future<void> saveAddress(String address) async {
    return Preference.setString(kAddress, address);
  }

  Future<String> getAddress() async {
    return Preference.getString(kAddress, def: '');
  }

  Future<void> saveCountry(String country) async {
    return Preference.setString(kCountry, country);
  }

  Future<String> getCountry() async {
    return Preference.getString(kCountry, def: '');
  }

  Future<void> saveState(String state) async {
    return Preference.setString(kState, state);
  }

  Future<String> getState() async {
    return Preference.getString(kState, def: '');
  }

  Future<void> savePostCode(String postCode) async {
    return Preference.setString(kPostCode, postCode);
  }

  Future<String> getPostCode() async {
    return Preference.getString(kPostCode, def: '');
  }

  Future<void> saveInstituteLogo(String instituteLogo) async {
    return Preference.setString(kInstituteLogo, instituteLogo);
  }

  Future<String> getInstituteLogo() async {
    return Preference.getString(kInstituteLogo, def: '');
  }

  Future<void> saveEnrolledGroupId(String enrolledGroupId) async {
    return Preference.setString(kEnrolledGroupId, enrolledGroupId);
  }

  Future<String> getEnrolledGroupId() async {
    return Preference.getString(kEnrolledGroupId, def: '');
  }

  Future<void> saveBlacklisted(String blacklisted) async {
    return Preference.setString(kBlacklisted, blacklisted);
  }

  Future<String> getBlacklisted() async {
    return Preference.getString(kBlacklisted, def: '');
  }

  Future<void> saveUserLatitude(String latitude) async {
    return Preference.setString(kUserLatitude, latitude);
  }

  Future<String> getUserLatitude() async {
    return Preference.getString(kUserLongitude, def: '');
  }

  Future<void> saveUserLongitude(String longitude) async {
    return Preference.setString(kUserLongitude, longitude);
  }

  Future<String> getUserLongitude() async {
    return Preference.getString(kUserLongitude, def: '');
  }

  Future<void> reset() async {
    // await Preference.removeAll();
    await Preference.remove(kWsUrl);
    // await Preference.remove(kCaUid);
    // await Preference.remove(kCaPwd);
    // await Preference.remove(kCaPwdEncode);
    // await Preference.remove(kServerType);
    await Preference.remove(kUserId);
    await Preference.remove(kUsername);
    await Preference.remove(kUserPhone);
    await Preference.remove(kEmail);
    await Preference.remove(kDiCode);
    await Preference.remove(kSessionId);
    await Preference.remove(kNationality);
    await Preference.remove(kGender);
    await Preference.remove(kAddress);
    await Preference.remove(kStudentIc);
    await Preference.remove(kState);
    await Preference.remove(kCountry);
    await Preference.remove(kPostCode);
    await Preference.remove(kInstituteLogo);
    await Preference.remove(kEnrolledGroupId);
    await Preference.remove(kBlacklisted);
    await Preference.remove(kUserLatitude);
    await Preference.remove(kUserLongitude);
  }
}
