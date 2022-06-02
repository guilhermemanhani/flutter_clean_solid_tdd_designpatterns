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

  void validateEmail(String email);

  void validatePassword(String password);

  Future<void> auth();

  void dispose();
}
