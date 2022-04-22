import 'package:get/state_manager.dart';

import '../../ui/pages/pages.dart';
import '../../ui/helpers/errors/errors.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../protocols/protocols.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  GetxLoginPresenter({
    required this.validation,
    required this.authentication,
    required this.saveCurrentAccount,
  });

  String? _email;
  String? _password;

  var _navigateTo = RxString('');
  var _isFormValid = false.obs;
  var _isLoading = false.obs;

  final _emailError = Rx<UIError?>(null);
  final _passwordError = Rx<UIError?>(null);
  final _mainError = Rx<UIError?>(null);

  Stream<UIError?> get emailErrorStream => _emailError.stream;

  Stream<UIError?> get passwordErrorStream => _passwordError.stream;

  Stream<UIError?> get mainErrorStream => _mainError.stream;

  Stream<bool> get isFormValidStream => _isFormValid.stream;

  Stream<bool> get isLoadingStream => _isLoading.stream;

  Stream<String> get navigateToStream => _navigateTo.stream;

  // void validateEmail(String email) {
  //   _email = email;
  //   _emailError.value = validation.validate(field: 'email', value: email);

  //   _validateForm();
  // }

  // void validatePassword(String password) {
  //   _password = password;
  //   _passwordError.value =
  //       validation.validate(field: 'password', value: password);
  //   _validateForm();
  // }
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField('email', email);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField('password', password);
    _validateForm();
  }

  UIError? _validateField(String field, String value) {
    // final formData = {
    //   'email': _email,
    //   'password': _password,
    // };
    final error = validation.validate(field: field, value: value);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }

  void _validateForm() {
    _isFormValid.value = _emailError.value == null &&
        _passwordError.value == null &&
        _email != null &&
        _password != null;
  }

  Future<void> auth() async {
    try {
      _isLoading.value = true;
      final account = await authentication
          .auth(AuthenticationParams(email: _email!, secret: _password!));
      await saveCurrentAccount.save(account);
      _navigateTo.value = '/surveys';
    } on DomainError catch (error) {
      // _mainError.value = error.description;
      switch (error) {
        case DomainError.invalidCredentials:
          _mainError.value = UIError.invalidCredentials;
          break;
        default:
          _mainError.value = UIError.unexpected;
          break;
      }
      _isLoading.value = false;
    }
  }

  // ignore: must_call_super
  void dispose() {}
}
