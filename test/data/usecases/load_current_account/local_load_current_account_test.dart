import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_load_current_account_test.mocks.dart';

class LocalLoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  LocalLoadCurrentAccount({
    required this.fetchSecureCacheStorage,
  });
  Future<void> load() async {
    await fetchSecureCacheStorage.fetchSecure('token');
  }
}

abstract class FetchSecureCacheStorage {
  Future<void> fetchSecure(String key);
}

@GenerateMocks([FetchSecureCacheStorage])
void main() {
  late LocalLoadCurrentAccount sut;

  late MockFetchSecureCacheStorage fetchSecureCacheStorage;

  setUp(() {
    fetchSecureCacheStorage = MockFetchSecureCacheStorage();
    sut = LocalLoadCurrentAccount(
        fetchSecureCacheStorage: fetchSecureCacheStorage);
    // account = AccountEntity(faker.guid.guid());
  });
  test('Should call FetchSecureCacheStorag with correct valeu', () async {
    await sut.load();
    verify(fetchSecureCacheStorage.fetchSecure('token'));
  });
}
