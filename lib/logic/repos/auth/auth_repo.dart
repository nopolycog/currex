abstract class AuthRepo {
  Future<void> put(String data);
  Future<String?> get();
}
