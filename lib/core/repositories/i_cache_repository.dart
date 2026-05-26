abstract class ICacheRepository {
  Future<void> saveToken(String token);
  Future<String?> fetchToken();
}