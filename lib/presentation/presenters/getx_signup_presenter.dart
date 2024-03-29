import 'package:get/state_manager.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/errors/errors.dart';
import '../../ui/pages/pages.dart';
import '../protocols/protocols.dart';

class GetxSignUpPresenter extends GetxController implements SignupPresenter {
  final Validation validation;
  final AddAccount addAccount;
  final SaveCurrentAccount saveCurrentAccount;

  GetxSignUpPresenter({
    required this.validation,
    required this.addAccount,
    required this.saveCurrentAccount,
  });

  String? _email;
  String? _password;
  String? _name;
  String? _passwordConfirmation;

  var _navigateTo = RxString('');
  var _isFormValid = false.obs;
  var _isLoading = false.obs;

  final _emailError = Rx<UIError?>(null);
  final _passwordError = Rx<UIError?>(null);
  final _nameError = Rx<UIError?>(null);
  final _passwordConfirmationError = Rx<UIError?>(null);
  final _mainError = Rx<UIError?>(null);

  @override
  Stream<UIError?> get emailErrorStream => _emailError.stream;

  @override
  Stream<UIError?> get mainErrorStream => _mainError.stream;

  @override
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;

  @override
  Stream<UIError?> get nameErrorStream => _nameError.stream;

  @override
  Stream<UIError?> get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream;

  Stream<bool> get isFormValidStream => _isFormValid.stream;

  Stream<bool> get isLoadingStream => _isLoading.stream;

  Stream<String> get navigateToStream => _navigateTo.stream;

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField('email');
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField('password');
    _validateForm();
  }

  @override
  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField('name');
    _validateForm();
  }

  @override
  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField('passwordConfirmation');
    _validateForm();
  }

  UIError? _validateField(String field) {
    final formData = {
      'name': _name,
      'email': _email,
      'password': _password,
      'passwordConfirmation': _passwordConfirmation
    };
    final error = validation.validate(field: field, input: formData);
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
        _nameError.value == null &&
        _passwordConfirmationError.value == null &&
        _email != null &&
        _password != null &&
        _name != null &&
        _passwordConfirmation != null;
  }

  Future<void> signUp() async {
    try {
      _isLoading.value = true;
      final account = await addAccount.add(AddAccountParams(
        email: _email!,
        password: _password!,
        name: _name!,
        passwordConfirmation: _passwordConfirmation!,
      ));
      await saveCurrentAccount.save(account);
      _navigateTo.value = '/surveys';
    } on DomainError catch (error) {
      // _mainError.value = error.description;
      switch (error) {
        case DomainError.emailInUse:
          _mainError.value = UIError.emailInUse;
          break;
        default:
          _mainError.value = UIError.unexpected;
          break;
      }
      _isLoading.value = false;
    }
  }

  @override
  void goToLogin() {
    _navigateTo.value = '/login';
  }

  // ignore: must_call_super
  void dispose() {}
}
