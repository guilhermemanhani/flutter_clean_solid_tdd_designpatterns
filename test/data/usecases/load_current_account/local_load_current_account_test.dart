import 'package:faker/faker.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/data/cache/cache.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/data/usecases/load_current_account/load_current_account.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/entities/entities.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/helpers/helpers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_load_current_account_test.mocks.dart';

@GenerateMocks([FetchSecureCacheStorage])
void main() {
  late LocalLoadCurrentAccount sut;

  late MockFetchSecureCacheStorage fetchSecureCacheStorage;
  late String token;

  PostExpectation mockFetchSecureCall() =>
      when(fetchSecureCacheStorage.fetchSecure(any));

  void mockFetchSecure() {
    mockFetchSecureCall().thenAnswer((_) async => token);
  }

  void mockFetchSecureErro() {
    mockFetchSecureCall().thenThrow(Exception());
  }

  setUp(() {
    fetchSecureCacheStorage = MockFetchSecureCacheStorage();
    sut = LocalLoadCurrentAccount(
        fetchSecureCacheStorage: fetchSecureCacheStorage);
    token = faker.guid.guid();
    mockFetchSecure();
  });
  test('Should call FetchSecureCacheStorag with correct valeu', () async {
    await sut.load();
    verify(fetchSecureCacheStorage.fetchSecure('token'));
  });

  test('Should return an AccountEntity', () async {
    final account = await sut.load();

    expect(account, AccountEntity(token));
  });

  test('Should throw UnexpectedErro if FetchSecureCacheStorage throws',
      () async {
    mockFetchSecureErro();
    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
