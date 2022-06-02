// Mocks generated by Mockito 5.2.0 from annotations
// in flutter_clean_solid_tdd_designpatterns/test/presentation/presenters/getx_login_presenter_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:flutter_clean_solid_tdd_designpatterns/domain/entities/account_entity.dart'
    as _i2;
import 'package:flutter_clean_solid_tdd_designpatterns/domain/usecases/authentication.dart'
    as _i4;
import 'package:flutter_clean_solid_tdd_designpatterns/domain/usecases/save_current_account.dart'
    as _i6;
import 'package:flutter_clean_solid_tdd_designpatterns/presentation/protocols/validation.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeAccountEntity_0 extends _i1.Fake implements _i2.AccountEntity {}

/// A class which mocks [Validation].
///
/// See the documentation for Mockito's code generation for more information.
class MockValidation extends _i1.Mock implements _i3.Validation {
  MockValidation() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.ValidationError? validate({String? field, String? value}) =>
      (super.noSuchMethod(
              Invocation.method(#validate, [], {#field: field, #value: value}))
          as _i3.ValidationError?);
}

/// A class which mocks [Authentication].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthentication extends _i1.Mock implements _i4.Authentication {
  MockAuthentication() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.AccountEntity> auth(_i4.AuthenticationParams? params) =>
      (super.noSuchMethod(Invocation.method(#auth, [params]),
              returnValue:
                  Future<_i2.AccountEntity>.value(_FakeAccountEntity_0()))
          as _i5.Future<_i2.AccountEntity>);
}

/// A class which mocks [SaveCurrentAccount].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveCurrentAccount extends _i1.Mock
    implements _i6.SaveCurrentAccount {
  MockSaveCurrentAccount() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<void> save(_i2.AccountEntity? account) =>
      (super.noSuchMethod(Invocation.method(#save, [account]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
}
