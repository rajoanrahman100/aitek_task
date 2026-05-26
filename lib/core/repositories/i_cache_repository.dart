abstract class ICacheRepository {
  Future<void> saveToken(String token);
  Future<String?> fetchToken();
  Future<void> saveLoginID(String loginID);
  Future<String?> fetchLoginID();
  Future<void> clearSession();
  Future<void> savePartnerToken(String token);
  Future<String?> fetchPartnerToken();
  Future<void> savePartnerLoginID(String loginID);
  Future<String?> fetchPartnerLoginID();
  Future<void> clearPartnerSession();
}
