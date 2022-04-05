import 'package:flutter_clean_solid_tdd_designpatterns/data/cache/cache.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageAdapter implements SaveSecureCacheStorage {
  final FlutterSecureStorage secureStorage;
  SecureStorageAdapter({required this.secureStorage});
  @override
  Future<void> saveSecure({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }
}
