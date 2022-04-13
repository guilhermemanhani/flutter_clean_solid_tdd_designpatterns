import '../../data/cache/cache.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageAdapter
    implements SaveSecureCacheStorage, FetchSecureCacheStorage {
  final FlutterSecureStorage secureStorage;
  LocalStorageAdapter({required this.secureStorage});
  @override
  Future<void> saveSecure({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String> fetchSecure(String key) async {
    final result = await secureStorage.read(key: key);
    return result ?? '';
  }
}
