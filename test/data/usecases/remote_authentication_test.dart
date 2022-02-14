import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_authentication_test.mocks.dart';

import 'package:flutter_clean_solid_tdd_designpatterns/domain/helpers/helpers.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/usecases/usecases.dart';

import 'package:flutter_clean_solid_tdd_designpatterns/data/http/http.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/data/usecases/usecases.dart';

@GenerateMocks([HttpClient])
void main() {
  late MockHttpClient httpClient;
  late RemoteAuthentication sut;
  late String url;
  setUp(() {
    httpClient = MockHttpClient();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });
  test("Should call HttpClient with correct values", () async {
    final params = AuthenticationParams(
      email: faker.internet.email(),
      secret: faker.internet.password(),
    );
    await sut.auth(params);
    verify(
      httpClient.request(
        url: url,
        method: 'post',
        body: {
          'email': params.email,
          'password': params.secret,
        },
      ),
    );
  });

  test("Should throw UnexpectedError if HttpClient returns 400", () async {
    when(httpClient.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenThrow(HttpError.badRequest);
    final params = AuthenticationParams(
      email: faker.internet.email(),
      secret: faker.internet.password(),
    );
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });
}
