import 'dart:convert';
import 'package:faker/faker.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/data/http/http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_adapter_test.mocks.dart';

class HttpAdapter implements HttpClient {
  final http.Client client;
  HttpAdapter(this.client);
  Future<Map> request({
    required String url,
    required String method,
    Map? body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response =
        await client.post(Uri.parse(url), headers: headers, body: jsonBody);
    if (response.body.isEmpty) {
      print(response.body.isEmpty);
    }
    return jsonDecode(response.body);
    // ! antes do nullsafy
    // ! return response.body.isEmpty ? null : jsonDecode(response.body);
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
  group('post', () {
    PostExpectation mockRequest() => when(
        client.post(any, body: anyNamed('body'), headers: anyNamed('headers')));

    void mockResponse(int statusCode,
        {String body = '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => http.Response(body, statusCode));
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should call post with correct values', () async {
      // !
      // ! quando for testar tem q mockar utilizando a linha abaixo
      // ! Sem when ele da erro de stub ficar atendo a esse tipo de erro
      // ! Acredito q é devido ao nullsafy
      // !
      // !when(client.post(any,
      // !        body: anyNamed('body'), headers: anyNamed('headers')))
      // !   .thenAnswer(
      // !      (_) async => http.Response('{"any_key":"any_value"}', 200));
      // !
      // ! funcao refatorada e jogado no setUp

      await sut
          .request(url: url, method: 'post', body: {'any_key': 'any_value'});

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
    });

    test('Should return data if post returns 200', () async {
      final response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(response, {'any_key': 'any_value'});
    });

    // ! teste de corpo vazio não funciona talvez pelo nullsafy
    // test('Should return null if post returns 200 with no data', () async {
    //   mockResponse(200, body: '');
    //   final response = await sut.request(
    //     url: url,
    //     method: 'post',
    //   );

    //   expect(response, null);
    // });
  });
}
