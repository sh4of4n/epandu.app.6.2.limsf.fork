import 'preferences.dart';

class LocalStorage {
  static const String kLocale = 'LOCALE';
  static const String kWsUrl = 'WS_URL';
  static const String kCaUid = 'CAUID';
  static const String kCaPwd = 'CAPWD';
  static const String kCaPwdEncode = 'CAPWD_ENCODE';
  static const String kUserId = 'USER_ID';
  static const String kUsername = 'USERNAME';
  static const String kCountryCode = 'COUNTRY_CODE';
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
  static const String kAppVersion = 'APP_VERSION';
  static const String kBirthDate = 'BIRTH_DATE';
  static const String kRace = 'RACE';
  static const String kNickName = 'NICK_NAME';
  static const String kMerchantDbCode = 'MERCHANT_DB_CODE';
  static const String kProfilePic = 'PROFILE_PIC';
  static const String kLoginDeviceId = 'LOGIN_DEVICE_ID';
  static const String kMerchantName = 'MERCHANT_NAME';
  static const String kMsgDoc = 'MSG_DOC';
  static const String kMsgRef = 'MSG_REF';
  static const String kCdl = 'CDL';
  static const String kLdl = 'LDL';

  Future<bool> saveNickName(String nickName) {
    return Preference.setString(kNickName, nickName);
  }

  Future<String?> getNickName() async {
    return Preference.getString(kNickName, def: '');
  }

  Future<bool> saveRace(String race) {
    return Preference.setString(kRace, race);
  }

  Future<String?> getRace() async {
    return Preference.getString(kRace, def: '');
  }

  Future<bool> saveBirthDate(String birthDate) {
    return Preference.setString(kBirthDate, birthDate);
  }

  Future<String?> getBirthDate() async {
    return Preference.getString(kBirthDate, def: '');
  }

  Future<bool> saveLocale(String locale) {
    return Preference.setString(kLocale, locale);
  }

  Future<String?> getLocale() async {
    return Preference.getString(kLocale, def: 'en');
  }

  Future<bool> saveWsUrl(String wsUrl) {
    return Preference.setString(kWsUrl, wsUrl);
  }

  Future<String?> getWsUrl() async {
    return Preference.getString(kWsUrl, def: '');
  }

  Future<String?> getCaUid() async {
    return Preference.getString(kCaUid, def: 'epandu_prod');
  }

  Future<bool> saveCaUid(String caUid) async {
    return Preference.setString(kCaUid, caUid);
  }

  Future<String?> getCaPwd() async {
    return Preference.getString(kCaPwd, def: 'vWh7SmgDRJ%TW4xa');
  }

  Future<bool> saveCaPwd(String caPwd) async {
    return Preference.setString(kCaPwd, caPwd);
  }

  Future<String?> getCaPwdEncode() async {
    return Preference.getString(kCaPwdEncode, def: 'vWh7SmgDRJ%25TW4xa');
  }

  Future<bool> saveCaPwdEncode(String caPwdEncode) async {
    return Preference.setString(kCaPwdEncode, caPwdEncode);
  }

  Future<bool> saveUserId(String userId) {
    return Preference.setString(kUserId, userId);
  }

  Future<String?> getUserId() async {
    return Preference.getString(kUserId, def: '');
  }

  Future<bool> saveName(String username) {
    return Preference.setString(kUsername, username);
  }

  Future<String?> getName() async {
    return Preference.getString(kUsername, def: '');
  }

  Future<bool> saveCountryCode(String countryCode) {
    return Preference.setString(kCountryCode, countryCode);
  }

  Future<String?> getCountryCode() async {
    return Preference.getString(kCountryCode, def: '');
  }

  Future<bool> saveUserPhone(String userPhone) {
    return Preference.setString(kUserPhone, userPhone);
  }

  Future<String?> getUserPhone() async {
    return Preference.getString(kUserPhone, def: '');
  }

  Future<bool> saveEmail(String email) {
    return Preference.setString(kEmail, email);
  }

  Future<String?> getEmail() async {
    return Preference.getString(kEmail, def: '');
  }

  Future<bool> saveDiCode(String diCode) async {
    return Preference.setString(kDiCode, diCode);
  }

  Future<String?> getDiCode() async {
    return Preference.getString(kDiCode, def: '');
  }

  Future<bool> saveSessionId(String sessionId) async {
    return Preference.setString(kSessionId, sessionId);
  }

  Future<String?> getSessionId() async {
    return Preference.getString(kSessionId, def: '');
  }

  Future<bool> saveNationality(String nationality) async {
    return Preference.setString(kNationality, nationality);
  }

  Future<String?> getNationality() async {
    return Preference.getString(kNationality, def: '');
  }

  Future<bool> saveGender(String gender) async {
    return Preference.setString(kGender, gender);
  }

  Future<String?> getGender() async {
    return Preference.getString(kGender, def: '');
  }

  Future<bool> saveStudentIc(String icNo) async {
    return Preference.setString(kStudentIc, icNo);
  }

  Future<String?> getStudentIc() async {
    return Preference.getString(kStudentIc, def: '');
  }

  Future<bool> saveAddress(String address) async {
    return Preference.setString(kAddress, address);
  }

  Future<String?> getAddress() async {
    return Preference.getString(kAddress, def: '');
  }

  Future<bool> saveCountry(String country) async {
    return Preference.setString(kCountry, country);
  }

  Future<String?> getCountry() async {
    return Preference.getString(kCountry, def: '');
  }

  Future<bool> saveState(String state) async {
    return Preference.setString(kState, state);
  }

  Future<String?> getState() async {
    return Preference.getString(kState, def: '');
  }

  Future<bool> savePostCode(String postCode) async {
    return Preference.setString(kPostCode, postCode);
  }

  Future<String?> getPostCode() async {
    return Preference.getString(kPostCode, def: '');
  }

  Future<bool> saveInstituteLogo(String instituteLogo) async {
    return Preference.setString(kInstituteLogo, instituteLogo);
  }

  Future<String?> getInstituteLogo() async {
    return Preference.getString(kInstituteLogo, def: '');
  }

  Future<bool> saveEnrolledGroupId(String enrolledGroupId) async {
    return Preference.setString(kEnrolledGroupId, enrolledGroupId);
  }

  Future<String?> getEnrolledGroupId() async {
    return Preference.getString(kEnrolledGroupId, def: '');
  }

  Future<bool> saveBlacklisted(String blacklisted) async {
    return Preference.setString(kBlacklisted, blacklisted);
  }

  Future<String?> getBlacklisted() async {
    return Preference.getString(kBlacklisted, def: '');
  }

  Future<bool> saveUserLatitude(String latitude) async {
    return Preference.setString(kUserLatitude, latitude);
  }

  Future<String?> getUserLatitude() async {
    return Preference.getString(kUserLatitude, def: '');
  }

  Future<bool> saveUserLongitude(String longitude) async {
    return Preference.setString(kUserLongitude, longitude);
  }

  Future<String?> getUserLongitude() async {
    return Preference.getString(kUserLongitude, def: '');
  }

  Future<String?> getAppVersion() async {
    return Preference.getString(kAppVersion, def: '');
  }

  Future<bool> saveAppVersion(String appVersion) async {
    return Preference.setString(kAppVersion, appVersion);
  }

  Future<String?> getMerchantDbCode() async {
    return Preference.getString(kMerchantDbCode, def: '');
  }

  Future<bool> saveMerchantDbCode(String dbCode) async {
    return Preference.setString(kMerchantDbCode, dbCode);
  }

  Future<String?> getMerchantName() async {
    return Preference.getString(kMerchantName, def: '');
  }

  Future<bool> saveMerchantName(String merchantName) async {
    return Preference.setString(kMerchantName, merchantName);
  }

  Future<String?> getProfilePic() async {
    return Preference.getString(kProfilePic, def: '');
  }

  Future<bool> saveProfilePic(String profilePic) async {
    return Preference.setString(kProfilePic, profilePic);
  }

  Future<String?> getLoginDeviceId() async {
    return Preference.getString(kLoginDeviceId, def: '');
  }

  Future<bool> saveLoginDeviceId(String deviceId) async {
    return Preference.setString(kLoginDeviceId, deviceId);
  }

  Future<String?> getMsgDoc() async {
    return Preference.getString(kMsgDoc, def: '');
  }

  Future<bool> saveMsgDoc(String msgDoc) async {
    return Preference.setString(kMsgDoc, msgDoc);
  }

  Future<String?> getMsgRef() async {
    return Preference.getString(kMsgRef, def: '');
  }

  Future<bool> saveMsgRef(String msgRef) async {
    return Preference.setString(kMsgRef, msgRef);
  }

  Future<String?> getCdl() async {
    return Preference.getString(kCdl, def: '');
  }

  Future<bool> saveCdl(String cdl) async {
    return Preference.setString(kCdl, cdl);
  }

  Future<String?> getLdl() async {
    return Preference.getString(kLdl, def: '');
  }

  Future<bool> saveLdl(String ldl) async {
    return Preference.setString(kLdl, ldl);
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
    await Preference.remove(kCountryCode);
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
    await Preference.remove(kAppVersion);
    await Preference.remove(kBirthDate);
    await Preference.remove(kNickName);
    await Preference.remove(kRace);
    await Preference.remove(kMerchantDbCode);
    await Preference.remove(kProfilePic);
    await Preference.remove(kMerchantName);
    await Preference.remove(kMsgDoc);
    await Preference.remove(kMsgRef);
    await Preference.remove(kCdl);
    await Preference.remove(kLdl);
  }
}
