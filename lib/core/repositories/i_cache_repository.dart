abstract class ICacheRepository {
  Future<void> saveToken(String token);
  Future<String?> fetchToken();
  Future<void> saveLoginID(String loginID);
  Future<String?> fetchLoginID();
}