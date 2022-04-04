import 'package:faker/faker.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/data/cache/save_secure_cache_storage.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/data/usecases/usecases.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/entities/account_entity.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/helpers/helpers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_save_current_account_test.mocks.dart';

@GenerateMocks([SaveSecureCacheStorage])
void main() {
  late LocalSaveCurrentAccount sut;
  late AccountEntity account;
  late MockSaveSecureCacheStorage saveSecureCacheStorage;

  setUp(() {
    saveSecureCacheStorage = MockSaveSecureCacheStorage();
    sut =
        LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    account = AccountEntity(faker.guid.guid());
  });
  test('Should call SaveCacheStorage with correct values', () async {
    await sut.save(account);

    verify(
        saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws',
      () async {
    when(saveSecureCacheStorage.saveSecure(
            key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());

    final future = sut.save(account);
    expect(future, throwsA(DomainError.unexpected));
  });
}
