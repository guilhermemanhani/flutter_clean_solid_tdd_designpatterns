import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'stream_login_presenter_test.mocks.dart';

import 'package:flutter_clean_solid_tdd_designpatterns/domain/helpers/helpers.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/presentation/protocols/protocols.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/entities/entities.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/usecases/usecases.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/presentation/presenters/presenters.dart';

@GenerateMocks([Validation, Authentication])
// ? @GenerateMocks([], customMocks: [MockSpec<Validation>(returnNullOnMissingStub: true)])
// ? Forma de gerar a classe mock para nao haver alteraçao dos teste da maneira antiga do mockito
// @GenerateMocks([], customMocks: [
//   MockSpec<Authentication>(returnNullOnMissingStub: true),
//   MockSpec<Validation>(returnNullOnMissingStub: true)
// ])
void main() {
  late Validation validation;
  late StreamLoginPresenter sut;
  late String email;
  late String password;
  late MockAuthentication authentication;

  PostExpectation mockValidationCall(String? field) => when(validation.validate(
      field: field == null ? anyNamed('field') : field,
      value: anyNamed('value')));

  void mockValidation({String? field, String? value}) {
    mockValidationCall(field).thenReturn(value);
  }

  PostExpectation mockAuthenticationCall() => when(authentication.auth(any));

  void mockAuthentication() {
    mockAuthenticationCall()
        .thenAnswer((_) async => AccountEntity(faker.guid.guid()));
  }

  void mockAuthenticationErro(DomainError error) {
    mockAuthenticationCall().thenThrow(error);
  }

  setUp(() {
    validation = MockValidation();
    authentication = MockAuthentication();
    sut = StreamLoginPresenter(
        validation: validation, authentication: authentication);
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation();
    mockAuthentication();
  });
  test('Sould call Validation with correct email', () {
    // ! TEST ANTIGO
    // ? sut.validateEmail(email);
    // ? verify(validation.validate(field: 'email', value: email)).called(1);
    // ! OUTRO MODO DE TESTAR
    // ! https://github.com/dart-lang/mockito/issues/402
    // * when(sut.validateEmail(email)).thenReturn(email);
    // * sut.validateEmail(email);
    // when(sut.validateEmail(email)).thenReturn(email);
    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Sould emit error if validation fails', () {
    mockValidation(value: 'error');
    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Sould emit null if validation fails', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Sould call Validation with correct password', () {
    sut.validatePassword(password);
    verify(validation.validate(field: 'password', value: password)).called(1);
  });

  test('Sould emit password error if validation fails value error', () {
    mockValidation(value: 'error');

    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Sould emit null password error if validation fails', () {
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Sould emit password error if validation fails', () {
    mockValidation(field: 'email', value: 'error');

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));

    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);

    sut.validatePassword(password);
  });

  // test('Sould emit password error if validation fails daily', () async {
  //   sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));

  //   sut.passwordErrorStream
  //       .listen(expectAsync1((error) => expect(error, null)));

  //   expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

  //   sut.validateEmail(email);
  //   await Future.delayed(Duration.zero);
  //   sut.validatePassword(password);
  // });

  test('Sould call Authentication with correct values', () async {
    sut.validateEmail(email);

    sut.validatePassword(password);

    await sut.auth();

    verify(authentication
            .auth(AuthenticationParams(email: email, secret: password)))
        .called(1);
  });

  test('Sould emit correct events on Authentication success', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.auth();
  });

  test('Sould emit correct events on InvalidCredentialsError', () async {
    mockAuthenticationErro(DomainError.invalidCredentials);
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emits(false));
    sut.mainErrorStream.listen(
        expectAsync1((error) => expect(error, 'Credenciais inválidas.')));

    await sut.auth();
  });

  test('Sould emit correct events on UnexpectedError', () async {
    mockAuthenticationErro(DomainError.unexpected);
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emits(false));
    sut.mainErrorStream.listen(expectAsync1((error) =>
        expect(error, 'Algo errado aconteceu. Tente novamente em breva.')));

    await sut.auth();
  });

  test('Sould not emit after dispose', () async {
    expectLater(sut.emailErrorStream, neverEmits(null));

    sut.dispose();

    sut.validateEmail(email);
  });
}
