import 'dart:convert';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_adapter_test.mocks.dart';

class HttpAdapter {
  final http.Client client;
  HttpAdapter(this.client);
  Future<void> request({
    required String url,
    required String method,
    Map? body,
  }) async {
    final headers = {
      'content-type': 'application/json',
<<<<<<< HEAD
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    await client.post(Uri.parse(url), headers: headers, body: jsonBody);
=======
      'accept': 'application/json',
    };
    await client.post(Uri.parse(url), headers: headers);
>>>>>>> 6eff52e827aa2a23cdd16692f1d28f1d851f0ece
  }
}

@GenerateMocks([http.Client])
void main() {
  late MockClient client;
  late HttpAdapter sut;
  late String url;

  setUp(() {
    client = MockClient();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });
<<<<<<< HEAD
  group('post', () {
    test('Should call post with correct values', () async {
      // when(client.get(any, headers: anyNamed('headers')))
      //     .thenAnswer((_) async => http.Response(('trivia.json'), 200));
      when(client.post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'accept': 'application/json'
              },
              body: '{"any_key":"any_value"}'))
          .thenAnswer((_) async => http.post(Uri.parse(url)));
      // await sut
      //     .request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(Uri.parse(url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}'));
    });

    test('Should call post without body', () async {
      await sut.request(
        url: url,
        method: 'post',
      );

      verify(
        client.post(
          any,
          headers: anyNamed('headers'),
        ),
      );
=======

  group('post', () {
    test('Should call post with correct values', () async {
      await sut
          .request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(Uri.parse(url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}'));
>>>>>>> 6eff52e827aa2a23cdd16692f1d28f1d851f0ece
    });
  });
}
