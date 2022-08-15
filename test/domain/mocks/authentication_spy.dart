import 'package:flutter_clean_solid_tdd_designpatterns/domain/entities/account_entity.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/helpers/helpers.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

class AuthenticationSpy extends Mock implements Authentication {
  When mockAuthenticationCall() => when(() => this.auth(any()));
  void mockAuthentication(AccountEntity data) =>
      this.mockAuthenticationCall().thenAnswer((_) async => data);
  void mockAuthenticationError(DomainError error) =>
      this.mockAuthenticationCall().thenThrow(error);
}
