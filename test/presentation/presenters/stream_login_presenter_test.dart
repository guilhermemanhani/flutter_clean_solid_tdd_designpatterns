import 'package:faker/faker.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/presentation/presenters/stream_login_presenter.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'stream_login_presenter_test.mocks.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/presentation/protocols/validation.dart';

@GenerateMocks([Validation])
// ? @GenerateMocks([], customMocks: [MockSpec<Validation>(returnNullOnMissingStub: true)])
// ? Forma de gerar a classe mock para nao haver alteraçao dos teste da maneira antiga do mockito
// @GenerateMocks([],
//     customMocks: [MockSpec<Validation>(returnNullOnMissingStub: true)])
void main() {
  late Validation validation;
  late StreamLoginPresenter sut;
  late String email;
  late String password;

  PostExpectation mockValidationCall(String field) =>
      when(validation.validate(field: field, value: 'value'));

  void mockValidation({required String field, required String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = MockValidation();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation(field: 'email', value: 'error');
  });
  test('Sould call Validation with correct email', () {
    // ! TEST ANTIGO
    // ? sut.validateEmail(email);
    // ? verify(validation.validate(field: 'email', value: email)).called(1);
    // ! OUTRO MODO DE TESTAR
    // * when(sut.validateEmail(email)).thenReturn(email);
    // * sut.validateEmail(email);
    when(sut.validateEmail(email)).thenReturn(email);
    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Sould emit error if validation fails', () {
    mockValidation(field: 'email', value: 'error');
    when(sut.validateEmail(email)).thenReturn('error');
    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Sould emit null if validation fails', () {
    when(sut.validateEmail(email)).thenReturn('');
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Sould call Validation with correct password', () {
    when(sut.validatePassword(password)).thenReturn(password);
    sut.validatePassword(password);
    verify(validation.validate(field: 'password', value: password)).called(1);
  });

  test('Sould emit password error if validation fails', () {
    mockValidation(field: 'password', value: 'error');
    when(sut.validatePassword(password)).thenReturn('error');
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Sould emit empty password error if validation fails', () {
    when(sut.validatePassword(password)).thenReturn('');
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Sould emit password error if validation fails', () {
    mockValidation(field: 'email', value: 'error');
    when(sut.validateEmail(email)).thenReturn('error');
    when(sut.validatePassword(password)).thenReturn(password);
    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, password)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validatePassword(password);
  });
}
