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
  test('Should call save secure with correct values', () async {
    await sut.saveSecure(key: key, value: value);
    verify(secureStorage.write(key: key, value: value));
  });

  test('Should throw if save secure throws', () async {
    when(secureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());

    final future = sut.saveSecure(key: key, value: value);

    expect(future, throwsA(TypeMatcher<Exception>()));
  });
}
