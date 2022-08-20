import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

SignupPresenter makeGetxSignupPresenter() => GetxSignUpPresenter(
      addAccount: makeRemoteAddAccount(),
      validation: makeSignupValidation(),
      saveCurrentAccount: makeLocalSaveCurrentAccount(),
    );
