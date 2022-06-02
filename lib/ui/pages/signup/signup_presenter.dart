import 'package:flutter/material.dart';

import '../../../ui/helpers/errors/errors.dart';

abstract class SignupPresenter implements Listenable {
  Stream<UIError?> get nameErrorStream;
  Stream<UIError?> get emailErrorStream;
  Stream<UIError?> get passwordErrorStream;
  Stream<UIError?> get passwordConfirmationErrorStream;
  Stream<UIError?> get mainErrorStream;
  Stream<String?> get navigateToStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;

  void validateName(String name);

  void validateEmail(String email);

  void validatePassword(String password);

  void validatePasswordConfirmation(String passwordConfirmation);

  Future<void> auth();

  void dispose();
}
