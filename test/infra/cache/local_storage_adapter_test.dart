import 'package:faker/faker.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/infra/cache/cache.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_storage_adapter_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late LocalStorageAdapter sut;
  late MockFlutterSecureStorage secureStorage;
  late String key;
  late String value;
  setUp(() {
    secureStorage = MockFlutterSecureStorage();
    key = faker.lorem.word();
    value = faker.guid.guid();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
  });
  group('saveSecure', () {
    void mockSaveSecureError() {
      when(secureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
          .thenThrow(Exception());
    }

    test('Should call save secure with correct values', () async {
      await sut.saveSecure(key: key, value: value);
      verify(secureStorage.write(key: key, value: value));
    });

    test('Should throw if save secure throws', () async {
      mockSaveSecureError();

      final future = sut.saveSecure(key: key, value: value);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });

  group('fetchSecure', () {
    void mockFetchSecure() {
      when(secureStorage.read(key: anyNamed('key')))
          .thenAnswer((_) async => value);
    }

    setUp(() {
      mockFetchSecure();
    });

    test('Should call fetch secure with correct values', () async {
      await sut.fetchSecure(key);
      verify(secureStorage.read(key: key));
    });

    test('Should return correct value on success', () async {
      final fetchedValue = await sut.fetchSecure(key);
      expect(fetchedValue, value);
    });
  });
}
