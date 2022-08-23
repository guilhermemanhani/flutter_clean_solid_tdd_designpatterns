import 'package:faker/faker.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/data/http/http.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/data/models/remote_survey_model.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../infra/mocks/api_factory.dart';
import '../../mocks/http_client_spy.dart';

class RemoteLoadSurveys {
  final String url;
  final HttpClient httpClient;

  RemoteLoadSurveys({required this.url, required this.httpClient});
  Future<List<SurveyEntity>> load() async {
    final httpResponse = await httpClient.request(url: url, method: 'get');
    return httpResponse
        .map<SurveyEntity>(
            (json) => RemoteSurveyModel.fromJson(json).toEntity())
        .toList();
  }
}

void main() {
  late RemoteLoadSurveys sut;
  late HttpClientSpy httpClient;
  late String url;
  late List<Map> list;

  setUp(() {
    list = ApiFactory.makeSurveyList();
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    httpClient.mockRequest(list);
    sut = RemoteLoadSurveys(url: url, httpClient: httpClient);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();

    verify(() => httpClient.request(url: url, method: 'get'));
  });
  test('Should return surveys on 200', () async {
    final surveys = await sut.load();

    expect(surveys, [
      SurveyEntity(
        id: list[0]['id'],
        question: list[0]['question'],
        dateTime: DateTime.parse(list[0]['date']),
        didAnswer: list[0]['didAnswer'],
      ),
      SurveyEntity(
        id: list[1]['id'],
        question: list[1]['question'],
        dateTime: DateTime.parse(list[1]['date']),
        didAnswer: list[1]['didAnswer'],
      )
    ]);
  });
}
