abstract class TokenService {
  Future<void> saveAuthToken(String authToken);

  Future<String> getAuthToken();

  Future<void> clearAuthToken();
}
