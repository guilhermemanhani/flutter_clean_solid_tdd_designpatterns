import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth() async {
    await httpClient.request(url: url);
  }
}

abstract class HttpClient {
  Future<void> request({required String url});
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  test("Deve retornar os dados http com a url correta", () async {
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);
    when(httpClient.request(url: url)).thenAnswer((_) async {});
    await sut.auth();
    // verify(httpClient.request(url: url));

    verify(httpClient.request(url: url));
  });
}
