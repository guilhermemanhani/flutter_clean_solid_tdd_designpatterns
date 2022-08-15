import 'package:flutter_clean_solid_tdd_designpatterns/domain/entities/account_entity.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/helpers/helpers.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

class AddAccountSpy extends Mock implements AddAccount {
  When mockAddAccountCall() => when(() => this.add(any()));
  void mockAddAccount(AccountEntity data) =>
      this.mockAddAccountCall().thenAnswer((_) async => data);
  void mockAddAccountError(DomainError error) =>
      this.mockAddAccountCall().thenThrow(error);
}
