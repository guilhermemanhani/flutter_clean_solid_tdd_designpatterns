import 'package:faker/faker.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/entities/account_entity.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/usecases/usecases.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/presentation/presenters/presenters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'getx_splash_presenter_test.mocks.dart';

@GenerateMocks([LoadCurrentAccount])
void main() {
  late LoadCurrentAccount loadCurrentAccount;
  late GetxSplashPresenter sut;

  void mockLoadCurrentAccount({AccountEntity? account}) {
    when(loadCurrentAccount.load())
        .thenAnswer((_) async => Future<AccountEntity>(() => account!));
  }

  void mockLoadCurrentAccountErro() {
    when(loadCurrentAccount.load()).thenThrow(Exception());
  }

  setUp(() {
    loadCurrentAccount = MockLoadCurrentAccount();
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    mockLoadCurrentAccount(account: AccountEntity(faker.guid.guid()));
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount(durationInSeconds: 0);

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should  go to surveys page on success', () async {
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should  go to login page on null result', () async {
    mockLoadCurrentAccount(account: null);

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should  go to login page on null result', () async {
    mockLoadCurrentAccount(account: null);

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should  go to login page on empty token', () async {
    mockLoadCurrentAccount(account: AccountEntity(''));

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should  go to login page on error', () async {
    mockLoadCurrentAccountErro();

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount(durationInSeconds: 0);
  });
}
