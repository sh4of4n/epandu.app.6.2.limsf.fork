import 'preferences.dart';

class LocalStorage {
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

  Future<void> reset() async {
    await Preference.removeAll();
  }
}
