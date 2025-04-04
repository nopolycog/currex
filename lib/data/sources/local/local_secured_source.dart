import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppLocalSecuredSource {
  AppLocalSecuredSource(this.storage);

  final FlutterSecureStorage storage;

  Future<void> put(String key, String value) async => await storage.write(key: key, value: value);

  Future<String?> get(String key) async => await storage.read(key: key);
}
