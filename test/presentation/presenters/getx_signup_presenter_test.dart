import 'package:faker/faker.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/entities/account_entity.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/helpers/domain_error.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/usecases/usecases.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/presentation/presenters/presenters.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/presentation/protocols/protocols.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/ui/helpers/errors/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'getx_signup_presenter_test.mocks.dart';

@GenerateMocks([Validation, Authentication, SaveCurrentAccount])
// ? @GenerateMocks([], customMocks: [MockSpec<Validation>(returnNullOnMissingStub: true)])
// ? Forma de gerar a classe mock para nao haver alteraçao dos teste da maneira antiga do mockito
// @GenerateMocks([], customMocks: [
//   MockSpec<Authentication>(returnNullOnMissingStub: true),
//   MockSpec<Validation>(returnNullOnMissingStub: true)
// ])
void main() {
  late GetxSignUpPresenter sut;
  late MockValidation validation;
  late MockAuthentication authentication;
  late MockSaveCurrentAccount saveCurrentAccount;
  late String email;
  late String password;

  late String token;

  PostExpectation mockValidationCall(String? field) => when(validation.validate(
      field: field == null ? anyNamed('field') : field,
      value: anyNamed('value')));

  void mockValidation({String? field, ValidationError? value}) {
    mockValidationCall(field).thenReturn(value);
  }

  PostExpectation mockAuthenticationCall() => when(authentication.auth(any));

  void mockAuthentication() {
    mockAuthenticationCall().thenAnswer((_) async => AccountEntity(token));
  }

  void mockAuthenticationErro(DomainError error) {
    mockAuthenticationCall().thenThrow(error);
  }

  PostExpectation mockSaveCurremtAccountCall() =>
      when(saveCurrentAccount.save(any));

  void mockSaveCurremtAccountErro() {
    mockSaveCurremtAccountCall().thenThrow(DomainError.unexpected);
  }

  setUp(() {
    validation = MockValidation();
    authentication = MockAuthentication();
    saveCurrentAccount = MockSaveCurrentAccount();
    sut = GetxSignUpPresenter(
      validation: validation,
      authentication: authentication,
      saveCurrentAccount: saveCurrentAccount,
    );
    email = faker.internet.email();
    password = faker.internet.password();
    token = faker.guid.guid();
    mockValidation();
    mockAuthentication();
  });
  test('Should call Validation with correct email', () {
    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit invalidFieldError if email is invalid', () {
    mockValidation(value: ValidationError.invalidField);
    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    // ! validando q a stream nao vai chamar duas vezes
    // ! para atualizar se o valor for igual, tipo se for erro ele
    // ! nao vai ficar atualizando o valor para erro, mesmo q vc chame
    // ! o metodo validateEmail 200 vezes

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit requiredFieldError if email is empty', () {
    mockValidation(value: ValidationError.requiredField);
    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if validation fails', () {
    // when(sut.validateEmail(email)).thenReturn('');
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validateEmail(email);
    sut.validateEmail(email);
  });
}
