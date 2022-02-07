import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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
  late RemoteAuthentication sut;
  late HttpClientSpy client;
  late String url;

  setUp(() {
    client = HttpClientSpy();
    sut = RemoteAuthentication(
      httpClient: client,
      url: url,
    );
  });

  setUpAll(() {
    url = faker.internet.httpUrl();
    registerFallbackValue(Uri.parse(url));
  });
  test('Should call HttpClient with correct URL', () async {
    // late HttpClientSpy httpClient = HttpClientSpy();
    // late String url = faker.internet.httpUrl();
    // late RemoteAuthentication sut = RemoteAuthentication(
    //   httpClient: httpClient,
    //   url: url,
    // );
    when(() => client.request(url: url)).thenAnswer((_) async {});

    verify(() => client.request(url: url));
  });
}
